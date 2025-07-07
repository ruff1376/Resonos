document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector('.album-container');
  if (!container) return;

  /* ---------- 기존 DOM 재구성 부분 그대로 ---------- */
  const track = document.createElement('div');
  track.className = 'album-track';
  while (container.firstChild) track.appendChild(container.firstChild);
  container.appendChild(track);

  const CARD_GAP = 15;
  const card = track.querySelector('.album');
  const cardWidth = card.offsetWidth + CARD_GAP;

  /* ---------- 자동 슬라이드 ---------- */
  let autoSlideId = null;
  const startAutoSlide = () => {
    clearInterval(autoSlideId);
    autoSlideId = setInterval(() => {
      if (Math.ceil(container.scrollLeft + container.offsetWidth) >= track.scrollWidth) {
        container.scrollLeft = 0;
      } else {
        container.scrollLeft += cardWidth;
      }
    }, 3000);
  };
  const stopAutoSlide = () => clearInterval(autoSlideId);
  startAutoSlide();

  /* ---------- 드래그 · 클릭 구분 ---------- */
  const THRESHOLD = 5;        // 5px 이하면 “클릭”, 초과면 “드래그”
  let isDown     = false;     // 누른 상태
  let startX     = 0;         // 누른 지점
  let scrollLeft = 0;         // 원래 스크롤 값
  let moved      = 0;         // 이동 거리 누적

  const dragStart = (x) => {
    isDown   = true;
    moved    = 0;
    startX   = x - container.offsetLeft;
    scrollLeft = container.scrollLeft;
    container.classList.add('grabbing');
    stopAutoSlide();
  };

  const dragMove = (x) => {
    if (!isDown) return;
    const xPos = x - container.offsetLeft;
    const walk = xPos - startX;     // (+ → 오른쪽, – → 왼쪽)
    moved = Math.max(moved, Math.abs(walk));
    container.scrollLeft = scrollLeft - walk;
  };

  const dragEnd = () => {
    isDown = false;
    container.classList.remove('grabbing');
    startAutoSlide();
  };

  /* ---------- 마우스/터치 이벤트 ---------- */
  // ↓ 마우스
  container.addEventListener('mousedown', (e) => {
    dragStart(e.pageX);
    e.preventDefault();
  });
  window.addEventListener('mousemove', (e) => dragMove(e.pageX));
  window.addEventListener('mouseup',  dragEnd);

  // ↓ 터치
  container.addEventListener('touchstart', (e) => dragStart(e.touches[0].pageX), {passive:true});
  container.addEventListener('touchmove',  (e) => dragMove(e.touches[0].pageX), {passive:false});
  container.addEventListener('touchend',   dragEnd);

  /* ---------- 클릭 취소 로직 ---------- */
  container.addEventListener('click', (e) => {
    if (moved > THRESHOLD) {   // 방금 전 동작이 “드래그”였다면
      e.preventDefault();      // a 태그 링크 이동 막기
      e.stopPropagation();
    }
    // moved ≤ 5px 이면 클릭으로 간주 → 링크 정상 작동
  });

  /* ---------- 호버 시 자동 슬라이드 제어 ---------- */
  container.addEventListener('mouseenter', stopAutoSlide);
  container.addEventListener('mouseleave', startAutoSlide);
});
