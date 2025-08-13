import React, { useContext, useEffect } from 'react';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import './Welcome.css';
import { LoginContext } from '../../contexts/LoginContextProvider';
import { Link } from 'react-router-dom';
import Galaxy from '../../assets/Galaxy';

const Welcome = () => {
    useEffect(() => {
        const returnTo = sessionStorage.getItem('returnTo');
        if (returnTo) {
            sessionStorage.removeItem('returnTo');
            window.location.href = returnTo;
        }
    }, []);

    const handleFreeClick = (e) => {
        e.preventDefault();
        Swal.fire({
            position: 'center',
            icon: 'warning',
            title: '준비중인 페이지입니다.',
            showConfirmButton: false,
            timer: 1000,
            customClass: {
                popup: 'follow-popup',
                icon: 'success-icon',
                title: 'alert-title',
            },
        });
    };

    const { isLogin, userInfo } = useContext(LoginContext)

    return (
        <div className="welcome" style={{ position: 'relative' }}>
            <div style={{ width: '100%', height: '100%', 
                position: 'absolute', zIndex: -1, top: 0 }}>
                <Galaxy
                    density={1}
                    glowIntensity={1}
                    saturation={1}
                    rotationSpeed={0.1}
                    hueShift={150}
                    starSpeed={0.2}
                />
            </div>
            <div className="bg">
                <main>
                    <section className="hero">
                        <h1>음악의 우주, 커뮤니티의 연결</h1>
                        <p>별처럼 빛나는 음악과 사람들의 소통 공간</p>
                        <div className="d-flex justify-content-center gap-4">
                            {!isLogin ? (
                                <>
                                    <Link to="/login">
                                        <button className="btn-gold">로그인</button>
                                    </Link>
                                    <Link to="/join">
                                        <button className="btn-gold">회원가입</button>
                                    </Link>
                                </>
                            ) : (
                                <span className="nickname-welcome">
                                    {userInfo.nickname} 님, 환영합니다.
                                </span>
                            )}
                        </div>
                    </section>

                    <section className="main-cards">
                        <Link id="free" to="/list/main" style={{ textDecoration: 'none', color: 'inherit' }} onClick={handleFreeClick}>
                            <div className="main-card">
                                <img src="/img/resonosLogo.png" alt="main" />
                                <h2>자유 커뮤니티</h2>
                                <p>좋아하는 음악, 아티스트를 주제로 이야기를 나눠보세요.</p>
                            </div>
                        </Link>

                        <Link to="/list/main" style={{ textDecoration: 'none', color: 'inherit' }}>
                            <div className="main-card">
                                <img src="/img/resonosPlusLogo.png" alt="sub" />
                                <h2>리뷰 커뮤니티</h2>
                                <p>음악에 대한 진정성있는 이야기들.</p>
                            </div>
                        </Link>
                    </section>
                </main>

                <footer>
                    <div className="footer-copyright w-100">
                        © 2025 Resonos, All rights reserved.
                    </div>
                </footer>
            </div>
        </div>
    );
};

export default Welcome;
