document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector('.track-container');
  if (!container) return;

  /* 카드 하나 + gap = 270 + 20 */
  const STEP       = 290;
  const THRESHOLD  = 5;    // 클릭·드래그 구분
  const INTERVAL   = 3000; // 자동 슬라이드 간격(ms)

  /* ─── 자동 슬라이드 ─── */
  let autoId = null;
  const startAuto = () => {
    clearInterval(autoId);
    autoId = setInterval(() => {
      const max = container.scrollWidth - container.clientWidth;
      const atEnd = Math.ceil(container.scrollLeft) >= max;
      container.scrollTo({ left: atEnd ? 0 : container.scrollLeft + STEP, behavior:'smooth' });
    }, INTERVAL);
  };
  const stopAuto  = () => clearInterval(autoId);

  /* ─── 드래그 변수 ─── */
  let down = false, startX = 0, startScroll = 0, moved = 0;

  const dragStart = x => {
    down = true; moved = 0;
    startX = x - container.offsetLeft;
    startScroll = container.scrollLeft;
    container.classList.add('grabbing');
    stopAuto();
  };
  const dragMove = x => {
    if (!down) return;
    const delta = (x - container.offsetLeft) - startX;
    moved = Math.max(moved, Math.abs(delta));
    container.scrollLeft = startScroll - delta;
  };
  const dragEnd = () => {
    if (!down) return;
    down = false; container.classList.remove('grabbing');

    /* 스냅 위치 보정 */
    const rest   = container.scrollLeft % STEP;
    const target = rest > STEP/2
                 ? container.scrollLeft + (STEP - rest)
                 : container.scrollLeft - rest;
    container.scrollTo({ left: target, behavior:'smooth' });
    startAuto();
  };

  /* ─── 이벤트 ─── */
  // 마우스
  container.addEventListener('mousedown', e => { dragStart(e.pageX); e.preventDefault(); });
  window.addEventListener('mousemove',  e => dragMove(e.pageX));
  window.addEventListener('mouseup',    dragEnd);

  // 터치
  container.addEventListener('touchstart', e => dragStart(e.touches[0].pageX), { passive:true });
  container.addEventListener('touchmove',  e => dragMove(e.touches[0].pageX),  { passive:false });
  container.addEventListener('touchend',   dragEnd);

  // 클릭 vs 드래그
  container.addEventListener('click', e => {
    if (moved > THRESHOLD){ e.preventDefault(); e.stopPropagation(); }
  });

  // 호버 시 자동 슬라이드 일시 정지 (PC)
  container.addEventListener('mouseenter', stopAuto);
  container.addEventListener('mouseleave', startAuto);

  startAuto();      // 최초 실행
});