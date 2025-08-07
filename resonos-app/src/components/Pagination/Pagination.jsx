import React from 'react';
import './Pagination.css';

export default function Pagination({
    pageUri = '',
    pagination = {
        page: 1,
        size: 10,
        count: 10,
        total: 0,
        start: 1,
        end: 1,
        first: 1,
        last: 1,
        prev: 1,
        next: 1,
    },
    onPageChange = () => {}
}) {
    const {
        page,
        start,
        end,
        first,
        last,
        prev,
        next,
    } = pagination;

    const pageNumbers = [];
    for (let i = start; i <= end; i++) {
        pageNumbers.push(i);
    }

    const createLink = (pageNum) => `${pageUri}&page=${pageNum}`;

    return (
        <nav aria-label="Page navigation">
            <ul className="custom-pagination">
                {/* [첫] */}
                <li>
                    <button onClick={() => onPageChange(first)}>&laquo;</button>
                </li>

                {/* [이전] */}
                {page !== first && (
                    <li>
                        <button onClick={() => onPageChange(prev)}>&lsaquo;</button>
                    </li>
                )}

                {/* [번호] */}
                {pageNumbers.map((p) => (
                    <li key={p}>
                        <button onClick={() => onPageChange(p)}>{p}</button>
                    </li>
                ))}

                {/* [다음] */}
                {page !== last && (
                    <li>
                        <button onClick={() => onPageChange(next)}>&rsaquo;</button>
                    </li>
                )}

                {/* [마지막] */}
                <li>
                    <button onClick={() => onPageChange(last)}>&raquo;</button>
                </li>
            </ul>
        </nav>
    );
}
