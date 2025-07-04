document.addEventListener('DOMContentLoaded', () => {
    const container = document.querySelector('.album-container');
    if (!container) return;

    // 트랙 생성 및 카드 래핑
    const track = document.createElement('div');
    track.className = 'album-track';
    while (container.firstChild) {
        track.appendChild(container.firstChild);
    }
    container.appendChild(track);

    const CARD_GAP = 15;
    const card = track.querySelector('.album');
    const cardWidth = card.offsetWidth + CARD_GAP;

    let autoSlideId = null;

    function startAutoSlide() {
    clearInterval(autoSlideId);
    autoSlideId = setInterval(() => {
        if (Math.ceil(container.scrollLeft + container.offsetWidth) >= track.scrollWidth) {
        container.scrollLeft = 0;
        } else {
        container.scrollLeft += cardWidth;
        }
    }, 3000);
    }

function stopAutoSlide() {
  clearInterval(autoSlideId);
}
    // 자동 슬라이드 정지
    function stopAutoSlide() {
        clearInterval(autoSlideId);
    }

    startAutoSlide();

    // 드래그 관련 변수
    let isDown = false;
    let startX;
    let scrollLeft;

    function dragStart(x) {
        isDown = true;
        container.classList.add('grabbing');
        startX = x - container.offsetLeft;
        scrollLeft = container.scrollLeft;
        stopAutoSlide();
    }

    function dragMove(x) {
        if (!isDown) return;
        const xPos = x - container.offsetLeft;
        container.scrollLeft = scrollLeft - (xPos - startX);
    }

    function dragEnd() {
        isDown = false;
        container.classList.remove('grabbing');
        startAutoSlide();
    }

    // 마우스 이벤트
    container.addEventListener('mousedown', e => {
        dragStart(e.pageX);
        e.preventDefault();
    });
    window.addEventListener('mouseup', dragEnd);
    window.addEventListener('mousemove', e => dragMove(e.pageX));

    // 터치 이벤트
    container.addEventListener('touchstart', e => dragStart(e.touches[0].pageX));
    container.addEventListener('touchmove', e => dragMove(e.touches[0].pageX));
    container.addEventListener('touchend', dragEnd);
    // 마우스 호버 시 자동 슬라이드 멈춤
    container.addEventListener('mouseenter', stopAutoSlide);
    // 마우스 떠나면 다시 시작
    container.addEventListener('mouseleave', startAutoSlide);
});