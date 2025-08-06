import React from 'react'

const Header = ({ isAuthenticated = false, currentUser = {} }) => {
    return (
        <header className="site-header">
            <nav className="navbar navbar-expand-lg py-0">
                <div className="container-fluid" style={{ maxWidth: '1440px' }}>
                    <div className="d-flex justify-content-start align-items-center">
                        <a className="navbar-brand d-flex align-items-center" href="/list/main">
                            <img src="/img/resonosPlusLogo.png" alt="Main Page Logo" className="header-logo-img" />
                        </a>
                        <a className="navbar-brand d-flex align-items-center" href="/list/main">
                            <img src="/img/resonosLogo.png" alt="Sub Page Logo" className="header-logo-img-sub" />
                        </a>
                        <div className="menu-group d-flex position-relative ms-5">

                            {/* 앨범 메뉴 + 하단 메뉴 */}
                            <div className="header-menu-wrapper position-relative">
                                <div className="d-flex justify-content-center align-items-center" style={{ width: '100px', height: '75px' }}>
                                    <a href="/list/new-albums" className="submenu-item" style={{ fontSize: '1.6rem', color: 'white' }}>앨범</a>
                                </div>
                                <div className="header-submenu-container">
                                    <ul className="header-submenu d-flex flex-column justify-content-center">
                                        <li><a href="/list/new-albums">최신 앨범</a></li>
                                        <li><a href="/list/hot-albums">인기 앨범</a></li>
                                    </ul>
                                </div>
                            </div>

                            {/* 트랙 메뉴 + 하단 메뉴 */}
                            <div className="header-menu-wrapper position-relative">
                                <div className="d-flex justify-content-center align-items-center" style={{ width: '100px', height: '75px' }}>
                                    <a href="/list/new-tracks" className="submenu-item" style={{ fontSize: '1.6rem', color: 'white' }}>트랙</a>
                                </div>
                                <div className="header-submenu-container">
                                    <ul className="header-submenu d-flex flex-column justify-content-center">
                                        <li><a href="/list/new-tracks">최신 트랙</a></li>
                                        <li><a href="/list/hot-tracks">인기 트랙</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div className="collapse navbar-collapse d-flex justify-content-end align-items-center header-gap mt-4 mb-4 gap-4" id="mainNav">

                        <form className="position-relative d-flex align-items-center mb-0" style={{ width: '300px' }} method="get" action="/search">
                            <input type="search" name="q" id="searchInput" className="form-control search-box" placeholder="앨범, 트랙, 아티스트..." />
                            <button type="submit" className="btn p-0 border-0 bg-transparent header-search-btn"
                                style={{ position: 'absolute', right: '10px', top: '50%', transform: 'translateY(-50%)' }} tabIndex="-1">
                                <i className="bi bi-search header-search-icon"></i>
                            </button>
                        </form>

                        <div className="navbar-nav d-flex flex-row justify-content-end align-items-center header-gap gap-3">
                            {!isAuthenticated ? (
                                // 로그인
                                <>
                                    <li className="nav-item ms-lg-2">
                                        <a id="login" href="/login" className="btn btn-outline-gold">로그인</a>
                                    </li>
                                    <li className="nav-item ms-2">
                                        <a href="/join" className="btn btn-outline-gold">회원가입</a>
                                    </li>
                                </>
                            ) : (
                                // 비로그인
                                <>
                                    <div className="dropdown">
                                        <a href="#" className="nav-link p-0" data-bs-toggle="dropdown" aria-expanded="false" style={{ lineHeight: 0 }}>
                                            <i className="bi bi-bell-fill" style={{ fontSize: '24px', color: '#B1B1B1' }}></i>
                                        </a>
                                        <ul className="dropdown-menu dropdown-menu-end" style={{ background: '#181C23' }}>
                                            <li><a className="dropdown-item" href="#">알림1</a></li>
                                            <li><a className="dropdown-item" href="#">알림2</a></li>
                                            <li><a className="dropdown-item" href="#">알림3</a></li>
                                            <li><hr className="dropdown-divider" /></li>
                                            <li><a className="dropdown-item" href="/users/notifications">전체 알림 보기</a></li>
                                        </ul>
                                    </div>
                                    <div className="flex-shrink-0 dropdown profile-dropdown">
                                        <a href="#" className="dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown" aria-expanded="false">
                                            <img src={currentUser.profileImage || "/img/default-profile.png"} alt="프로필 이미지" width="32" height="32" className="rounded-circle" />
                                        </a>
                                        <ul className="dropdown-menu text-small shadow" style={{ background: '#181C23' }}>
                                            <li><a className="dropdown-item" href="/users/mypage">마이페이지</a></li>
                                            <li><a className="dropdown-item" href="/users/notifications/status">환경설정</a></li>
                                            <li><hr className="dropdown-divider" /></li>
                                            <li>
                                                <form action="/logout" method="post">
                                                    <button type="submit" className="dropdown-item">로그아웃</button>
                                                </form>
                                            </li>
                                        </ul>
                                    </div>
                                </>
                            )}
                        </div>
                    </div>

                </div>
            </nav>
        </header>
    )
}

export default Header
