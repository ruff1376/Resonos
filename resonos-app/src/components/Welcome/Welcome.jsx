import React, { useEffect } from 'react';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import './Welcome.css';

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

    const isAuthenticated = false; // Replace with real auth logic

    return (
        <div className="bg">
            <main>
                <section className="hero">
                    <h1>음악의 우주, 커뮤니티의 연결</h1>
                    <p>별처럼 빛나는 음악과 사람들의 소통 공간</p>
                    <div className="d-flex justify-content-center gap-4">
                        {!isAuthenticated && (
                            <>
                                <a href="/login">
                                    <button className="btn-gold">로그인</button>
                                </a>
                                <a href="/join">
                                    <button className="btn-gold">회원가입</button>
                                </a>
                            </>
                        )}
                    </div>
                </section>

                <section className="main-cards">
                    <a id="free" href="/list/main" style={{ textDecoration: 'none', color: 'inherit' }} onClick={handleFreeClick}>
                        <div className="main-card">
                            <img src="/img/resonosLogo.png" alt="main" />
                            <h2>자유 커뮤니티</h2>
                            <p>좋아하는 음악, 아티스트를 주제로 이야기를 나눠보세요.</p>
                        </div>
                    </a>

                    <a href="/list/main" style={{ textDecoration: 'none', color: 'inherit' }}>
                        <div className="main-card">
                            <img src="/img/resonosPlusLogo.png" alt="sub" />
                            <h2>리뷰 커뮤니티</h2>
                            <p>음악에 대한 진정성있는 이야기들.</p>
                        </div>
                    </a>
                </section>
            </main>

            <footer>
                <div className="footer-copyright w-100">
                    © 2025 Resonos, All rights reserved.
                </div>
            </footer>
        </div>
    );
};

export default Welcome;
