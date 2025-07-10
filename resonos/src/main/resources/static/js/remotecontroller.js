const remote = document.querySelector('.mypage-tabs');
const max = document.querySelector('.con').offsetHeight - 350
let targetTop = 0;


function animate() {
  if(targetTop >= max) targetTop = max
  remote.style.top = `${targetTop}px`;
  requestAnimationFrame(animate);
}

window.addEventListener('scroll', () => {
  console.log(remote.offsetHeight)
  const scrollY = window.scrollY || document.documentElement.scrollTop;
  targetTop = scrollY;
});

// 애니메이션 시작
animate();
