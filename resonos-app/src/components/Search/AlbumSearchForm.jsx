import 'bootstrap/dist/css/bootstrap.min.css';
import '../List/MainForm.css'
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import useRatingCharts from '../List/hooks/useRatingCharts';
import AlbumSearchGridSection from './section/AlbumSearchGridSection';

export default function AlbumSearchForm(props) {
    const {
        keyword,
        albumSearchList = [],
        albumSearchCount = 0,
        pagination = [],
        onPageChange = () => {},
        handleSortChange = () => {},
        sort = "relevance",
        showPagination = true
    } = props;

    useRatingCharts([albumSearchList]);

    return (
        <div className="container-fluid d-flex flex-column align-items-center px-0" style={{ maxWidth: 1440, paddingTop: 150, gap: 50 }}>
            <div
                className="d-flex flex-row mb-5 w-100"
                style={{ maxWidth: 1440, margin: "10px auto", gap: 10 }}
            >
                <h1 style={{ color: "white", marginLeft: "3rem" }}>
                    검색 결과 : "<span>{keyword || "검색어"}</span>" (<span>{albumSearchCount ?? 0}</span>건)
                </h1>
            </div>
            <AlbumSearchGridSection
                keyword={keyword}
                albumSearchList={albumSearchList}
                albumSearchCount={albumSearchCount}
                pagination={pagination}
                onPageChange={onPageChange}
                handleSortChange={handleSortChange}
                sort={sort}
                showPagination={showPagination}
            />
            <ScrollToTop />
        </div>
    );
}
