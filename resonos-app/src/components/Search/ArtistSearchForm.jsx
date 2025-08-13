import 'bootstrap/dist/css/bootstrap.min.css';
import '../List/MainForm.css'
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import ArtistSearchGridSection from './section/ArtistSearchGridSection';

export default function ArtistSearchForm(props) {
    const {
        keyword,
        artistSearchList = [],
        artistSearchCount = 0,
        pagination = [],
        onPageChange = () => {},
        showPagination = true
    } = props;

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
                    검색 결과 : "<span>{keyword || "검색어"}</span>" (<span>{artistSearchCount ?? 0}</span>건)
                </h1>
            </div>
            <ArtistSearchGridSection
                keyword={keyword}
                artistSearchList={artistSearchList}
                artistSearchCount={artistSearchCount}
                pagination={pagination}
                onPageChange={onPageChange}
                showPagination={showPagination}
            />
            <ScrollToTop />
        </div>
    );
}
