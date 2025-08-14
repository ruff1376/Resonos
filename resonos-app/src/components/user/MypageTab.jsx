import React, { useEffect } from "react";
import { Link } from "react-router-dom";

const MypageTab = ({ lastPath }) => {

  useEffect(() => {
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
  }, [])

  return (
    <section className="mypage-tabs">
      <Link to="/users/activities" className={`tab ${lastPath === "activity" ? "active" : ""}`}>
        내 활동
      </Link>
      <Link to="/users/notifications" className={`tab ${lastPath === "noti" ? "active" : ""}`}>
        알림함
      </Link>
      <Link to="/users/playlists" className={`tab ${lastPath === "playlist" ? "active" : ""}`}>
        플레이리스트
      </Link>
      <Link to="/users/liked-music" className={`tab ${lastPath === "liked-music" ? "active" : ""}`}>
        앨범 / 트랙
      </Link>
      <Link to="/users/follow-artists" className={`tab ${lastPath === "artist-follows" ? "active" : ""}`}>
        팔로우 아티스트
      </Link>
      <Link to="/users/follow-users" className={`tab ${lastPath === "user-follows" ? "active" : ""}`}>
        팔로워 / 팔로우
      </Link>
      <Link to="/users/badges" className={`tab ${lastPath === "badge" ? "active" : ""}`}>
        배지
      </Link>
      <Link to="/users/security" className={`tab ${lastPath === "security" ? "active" : ""}`}>
        계정 / 보안
      </Link>
      <Link to="/users/notifications/status" className={`tab ${lastPath === "alarm" ? "active" : ""}`}>
        알림 설정
      </Link>
    </section>
  );
};

export default MypageTab;
