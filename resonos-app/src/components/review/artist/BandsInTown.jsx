import React, { useEffect } from 'react';

const BandsintownWidget = ({ artistName }) => {
  useEffect(() => {
    // 컴포넌트가 마운트되면 위젯 초기화
    // window.Bandsintown이 존재할 때만 실행되도록 조건 추가
    if (window.Bandsintown) {
      window.Bandsintown.init();
    }
  }, []); // ✅ 의존성 배열을 비워서 컴포넌트 마운트 시에만 실행

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