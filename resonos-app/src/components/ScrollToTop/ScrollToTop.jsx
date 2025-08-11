import React from "react";
import './ScrollToTop.css'

export default function ScrollToTop() {
    const scrollToTop = (e) => {
        e.preventDefault();
        window.scrollTo({
            top: 0,
            behavior: "smooth",
        });
    };

    return (
        <div className="floating">
            <a href="#!" onClick={scrollToTop}>
                <i className="bi bi-caret-up-fill"></i>
            </a>
        </div>
    );
}
