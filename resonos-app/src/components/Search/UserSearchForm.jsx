import 'bootstrap/dist/css/bootstrap.min.css';
import '../List/MainForm.css'
import Pagination from '../Pagination/Pagination';
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import { Link } from 'react-router-dom';
import useRatingCharts from '../List/hooks/useRatingCharts';
import UserSearchGridSection from './section/UserSearchGridSection';

export default function UserSearchForm(props) {
    const {
        keyword,
        userSearchList = [],
        userSearchCount = 0,
        pagination = [],
        onPageChange = () => {},
        showPagination = true
    } = props;

    useRatingCharts([userSearchList])

    return (
        <div
            className="container-fluid d-flex flex-column align-items-center px-0"
            style={{ maxWidth: 1440, paddingTop: 150, gap: 50 }}
        >
            <div
                className="d-flex flex-row mb-5 w-100"
                style={{ maxWidth: 1440, margin: "10px auto", gap: 10 }}
            >
                <h1 style={{ color: "white", marginLeft: "3rem" }}>
                    검색 결과 : "<span>{keyword || "검색어"}</span>" (<span>{userSearchCount ?? 0}</span>건)
                </h1>
            </div>
            <UserSearchGridSection
                keyword={keyword}
                userSearchList={userSearchList}
                userSearchCount={userSearchCount}
                pagination={pagination}
                onPageChange={onPageChange}
                showPagination={showPagination}
            />
            <ScrollToTop />
        </div>
    );
}
