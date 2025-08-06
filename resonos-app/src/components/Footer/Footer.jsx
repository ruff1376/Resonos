import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import 'bootstrap-icons/font/bootstrap-icons.css';

const Footer = () => {
    const [selected, setSelected] = useState('terms');

    const infoMap = {
        terms: {
            title: '이용약관',
            desc: '본 사이트의 서비스 이용은 이용약관을 따릅니다. 저작권 침해, 비방, 도배, 부정이용시 서비스 이용이 제한될 수 있습니다.',
        },
        policy: {
            title: '개인정보 처리방침',
            desc: '이 사이트는 사용자 정보를 안전하게 관리하며, 제3자 제공은 법령에 따라 처리됩니다.',
        },
        qna: {
            title: '고객센터(Q&A)',
            desc: '문의 사항은 고객센터로 남겨주세요. 빠른 시일 내에 답변드리겠습니다.',
        },
        intro: {
            title: '사이트 소개',
            desc: 'Resonos는 음악 검색과 추천을 도와주는 웹 서비스입니다.',
        },
    };

    const handleChange = (type) => {
        setSelected(type);
    };

    return (
        <footer style={{ marginTop: '150px' }}>
            <div className="footer-container">
                <div className="d-flex flex-row align-items-start gap-3" style={{ height: '300px' }}>
                    {/* 로고 */}
                    <div
                        className="footer-logo-section d-flex flex-column justify-content-between align-items-center p-0"
                        style={{ width: '300px', height: '300px' }}
                    >
                        <div className="footer-logo-img d-flex justify-content-center align-items-center">
                            <Link className="navbar-brand d-flex align-items-center" to="/list/main">
                                <img
                                    src="/img/resonosPlusLogo.png"
                                    alt="Main Page Logo"
                                    className="logo-img"
                                    style={{ maxWidth: '100%', maxHeight: '100%' }}
                                />
                            </Link>
                        </div>
                        <div
                            className="d-flex flex-row justify-content-between align-items-center px-4 gap-2 mb-5"
                            style={{ width: '300px' }}
                        >
                            <a href="#" className="footer-sns-icon">
                                <i className="bi bi-youtube" style={{ fontSize: '4rem', color: 'var(--main-color)' }}></i>
                            </a>
                            <a href="#" className="footer-sns-icon">
                                <i className="bi bi-instagram" style={{ fontSize: '4rem', color: 'var(--main-color)' }}></i>
                            </a>
                            <a href="#" className="footer-sns-icon">
                                <i className="bi bi-spotify" style={{ fontSize: '4rem', color: 'var(--main-color)' }}></i>
                            </a>
                        </div>
                    </div>

                    {/* 링크 */}
                    <div
                        className="footer-links d-flex flex-column justify-content-between align-items-center py-5 gap-4"
                        style={{ width: '200px' }}
                    >
                        <button
                            type="button"
                            className={`footer-link ${selected === 'terms' ? 'selected' : ''}`}
                            onClick={() => handleChange('terms')}
                        >
                            이용약관
                        </button>
                        <button
                            type="button"
                            className={`footer-link ${selected === 'policy' ? 'selected' : ''}`}
                            onClick={() => handleChange('policy')}
                        >
                            개인정보 처리방침
                        </button>
                        <button
                            type="button"
                            className={`footer-link ${selected === 'qna' ? 'selected' : ''}`}
                            onClick={() => handleChange('qna')}
                        >
                            고객센터(Q&A)
                        </button>
                        <button
                            type="button"
                            className={`footer-link ${selected === 'intro' ? 'selected' : ''}`}
                            onClick={() => handleChange('intro')}
                        >
                            사이트 소개
                        </button>
                    </div>

                    {/* 정보 내용 */}
                    <div
                        className="footer-info-section d-flex flex-column align-items-start gap-3 pt-5 px-5"
                        style={{
                            width: '920px',
                            height: '300px',
                            borderLeft: '1px solid rgba(212,185,127,0.7)',
                        }}
                    >
                        <div className="footer-info-title">{infoMap[selected].title}</div>
                        <div className="footer-info-desc">{infoMap[selected].desc}</div>
                    </div>
                </div>
            </div>

            {/* 하단 바 */}
            <nav
                className="navbar navbar-expand-lg py-0 d-flex justify-content-center align-items-center footer-navbar"
                style={{ height: '80px' }}
            >
                <div className="footer-copyright w-100">
                    © 2025 Resonos, All rights reserved.
                </div>
            </nav>
        </footer>
    );
};

export default Footer;
