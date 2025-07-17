const remote = document.querySelector('.mypage-tabs');
if(remote) {
  const max = document.querySelector('.con').offsetHeight - 300
  let targetTop = 0;


  function animate() {
    if(targetTop >= max) targetTop = max
    remote.style.top = `${targetTop}px`;
    requestAnimationFrame(animate);
  }

  window.addEventListener('scroll', () => {
    const scrollY = window.scrollY || document.documentElement.scrollTop;
    targetTop = scrollY;
  });

  // 애니메이션 시작
  animate();
}
