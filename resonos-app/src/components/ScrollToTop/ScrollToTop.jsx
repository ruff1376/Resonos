import React from "react";
import { Link } from "react-router-dom";
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
            <Link to="#!" onClick={scrollToTop}>
                <i className="bi bi-caret-up-fill"></i>
            </Link>
        </div>
    );
}
