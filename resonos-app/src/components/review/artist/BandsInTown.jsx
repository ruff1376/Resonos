import React, { useEffect } from 'react';

const BandsintownWidget = ({ artistName }) => {

  useEffect(() => {
    if (artistName) {
      const timer = setTimeout(() => {
        if (window.Bandsintown) {
          window.Bandsintown.init();
          console.log("밴즈인타운 초기화 성공! 🥳");
        } else {
          console.warn("Bandsintown 스크립트가 아직 로드되지 않았습니다.");
        }
      }, 500); // 3초는 너무 길 수 있으니 0.5초로 조정

      return () => clearTimeout(timer);
    }
  }, [artistName]);

  // artistName이 유효할 때만 위젯 div를 반환
  if (!artistName) {
    return null;
  }

  return (
    <div
      className="bit-widget-initializer"
      data-artist-name={artistName}
      data-text-color="#FFF"
      data-background-color="transparent"
      data-display-local-dates="true"
      data-auto-style="true"
      data-separator-color="#DDDDDD"
      data-link-color="#1DB954"
      data-display-limit="3"
      data-display-lineup="false"
      data-display-play-my-city="false"
    ></div>
  );
};

export default BandsintownWidget;