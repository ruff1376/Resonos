function changeFooterInfo(type) {
    // 버튼 스타일 초기화
    document.querySelectorAll('.footer-link').forEach(btn => {
        btn.classList.remove('selected');
    });

    let title = '';
    let desc = '';

    if (type === 'terms') {
        title = '이용약관';
        desc = '본 사이트의 서비스 이용은 이용약관을 따릅니다. 저작권 침해, 비방, 도배, 부정이용시 서비스 이용이 제한될 수 있습니다.';
        document.getElementById('footer-terms-btn').classList.add('selected');
    } else if (type === 'policy') {
        title = '개인정보 처리방침';
        desc = 'RESONOS는 회원의 개인정보를 안전하게 보호하며, 외부에 무단 제공하지 않습니다. 자세한 내용은 개인정보 처리방침을 참고하세요.';
        document.getElementById('footer-policy-btn').classList.add('selected');
    } else if (type === 'qna') {
        title = '고객센터(Q&A)';
        desc = '이용 중 문의/불편 사항은&nbsp;<a href="/support" style="text-decoration:underline; font-weight:bold; color:#D4B97F;" target="_blank">고객센터</a>를 통해 남겨주세요. 빠르게 답변해드리겠습니다.';
        document.getElementById('footer-qna-btn').classList.add('selected');
    } else if (type === 'intro') {
        title = '사이트 소개';
        desc = 'RESONOS는 음악 감상, 리뷰, 커뮤니티, 차트, 플레이리스트, 아티스트 정보를 제공하는 음악 커뮤니티 플랫폼입니다.\n문의: support@resonos.com';
        document.getElementById('footer-intro-btn').classList.add('selected');
    }

    document.getElementById('footer-info-title').innerText = title;

    // Q&A는 링크 포함, 나머지는 일반 텍스트
    if (type === 'qna') {
        document.getElementById('footer-info-desc').innerHTML = desc;
    } else {
        document.getElementById('footer-info-desc').innerText = desc;
    }
}