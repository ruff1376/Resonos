document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector('.track-container');
  if (!container) return;

  /* 카드 폭 + gap (270 + 20) */
  const STEP = 290;          // 스냅 단위
  const THRESHOLD = 5;       // 5px 이하면 클릭, 초과면 드래그

  let isDown = false;
  let startX = 0;
  let scrollStart = 0;
  let moved = 0;

  /* ── 드래그 시작 ── */
  const dragStart = pageX => {
    isDown      = true;
    moved       = 0;
    startX      = pageX - container.offsetLeft;
    scrollStart = container.scrollLeft;
    container.classList.add('grabbing');
  };

  /* ── 드래그 진행 ── */
  const dragMove = pageX => {
    if (!isDown) return;
    const x     = pageX - container.offsetLeft;
    const walk  = x - startX;               // (+ → 오른쪽으로 끌기)
    moved       = Math.max(moved, Math.abs(walk));
    container.scrollLeft = scrollStart - walk;
  };

  /* ── 드래그 끝 ── */
  const dragEnd = () => {
    if (!isDown) return;
    isDown = false;
    container.classList.remove('grabbing');

    /* 스냅: 가장 가까운 카드 경계로 맞춤 */
    const remainder = container.scrollLeft % STEP;
    const target = remainder > STEP / 2
                   ? container.scrollLeft + (STEP - remainder)
                   : container.scrollLeft - remainder;
    container.scrollTo({ left: target, behavior: 'smooth' });
  };

  /* ── 이벤트 바인딩 ── */
  // 마우스
  container.addEventListener('mousedown', e => { dragStart(e.pageX); e.preventDefault(); });
  window.addEventListener('mousemove', e => dragMove(e.pageX));
  window.addEventListener('mouseup',   dragEnd);

  // 터치
  container.addEventListener('touchstart', e => dragStart(e.touches[0].pageX), { passive: true });
  container.addEventListener('touchmove',  e => dragMove(e.touches[0].pageX),  { passive: false });
  container.addEventListener('touchend',   dragEnd);

  /* 클릭 vs 드래그 구분 */
  container.addEventListener('click', e => {
    if (moved > THRESHOLD) {
      e.preventDefault();
      e.stopPropagation();   // 하이퍼링크 이동 차단
    }
  });
});