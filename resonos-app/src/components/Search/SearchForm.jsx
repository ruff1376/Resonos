import { Link } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../List/MainForm.css'
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import useRatingCharts from '../List/hooks/useRatingCharts';
import ArtistSearchGridSection from './section/ArtistSearchGridSection';
import AlbumSearchGridSection from './section/AlbumSearchGridSection';
import TrackSearchGridSection from './section/TrackSearchGridSection';
import UserSearchGridSection from './section/UserSearchGridSection';
import PlaylistSearchGridSection from './section/PlaylistSearchGridSection';

export default function SearchForm(props) {
    const {
        keyword,
        artistSearchList = [],
        albumSearchList = [],
        trackSearchList = [],
        userSearchList = [],
        playlistSearchList = [],
        searchTracksByTagList = [],
        artistSearchCount = 0,
        albumSearchCount = 0,
        trackSearchCount = 0,
        userSearchCount = 0,
        playlistSearchCount = 0
    } = props;

    useRatingCharts([albumSearchList, trackSearchList]);

    const isTagSearch = keyword?.startsWith("#");

    return (
        <div
            className="container-fluid d-flex flex-column align-items-center px-0"
            style={{ maxWidth: 1440, paddingTop: 150, gap: 50 }}
        >
            {/* 검색 결과 제목 */}
            <div
                className="d-flex flex-row mb-5 w-100"
                style={{ maxWidth: 1440, margin: "10px auto", gap: 10 }}
            >
                <h1 style={{ color: "white", marginLeft: "3rem" }}>
                    검색 결과 : "<span>{keyword || "검색어"}</span>"
                </h1>
            </div>

            {/* 아티스트 */}
            {!isTagSearch && (
                <ArtistSearchGridSection
                    keyword={keyword}
                    artistSearchList={artistSearchList}
                    artistSearchCount={artistSearchCount}
                />
            )}

            {/* 앨범 */}
            {!isTagSearch && (
                <AlbumSearchGridSection
                    keyword={keyword}
                    albumSearchList={albumSearchList}
                    albumSearchCount={albumSearchCount}
                />
            )}

            {/* 트랙 */}
            {!isTagSearch && (
                <TrackSearchGridSection
                    keyword={keyword}
                    trackSearchList={trackSearchList}
                    trackSearchCount={trackSearchCount}
                />
            )}

            {/* 회원 */}
            {!isTagSearch && (
                <UserSearchGridSection
                    keyword={keyword}
                    userSearchList={userSearchList}
                    userSearchCount={userSearchCount}
                />
            )}

            {/* 플레이리스트 */}
            {!isTagSearch && (
                <PlaylistSearchGridSection
                    keyword={keyword}
                    playlistSearchList={playlistSearchList}
                    playlistSearchCount={playlistSearchCount}
                />
            )}

            {/* 태그 */}
            {isTagSearch && (
                <section className="main-section-bg w-100 py-4 mb-5">
                    {!searchTracksByTagList || searchTracksByTagList.length === 0 ? (
                        <div
                            style={{
                                borderTop: "1px solid #D4B97F",
                                borderBottom: "1px solid #D4B97F",
                                padding: "40px 0",
                            }}
                        >
                            <div className="d-flex justify-content-center align-items-center">
                                <h3 style={{ color: "#B1B1B1" }}>검색된 태그가 없습니다.</h3>
                            </div>
                        </div>
                    ) : (
                        <div className="album-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-6 g-0 m-0 justify-content-start">
                            {searchTracksByTagList.map((track) => (
                                <div className="col d-flex justify-content-center" key={track.id}>
                                    <div
                                        className="card align-items-center gap-2 mt-3"
                                        style={{ width: 228 }}
                                    >
                                        <Link to={`/tracks?id=${track.id}`}>
                                            <img
                                                src={track.coverImage}
                                                className="card-img-top"
                                                alt="앨범커버"
                                            />
                                        </Link>
                                        <div className="card-body d-flex flex-column align-items-center">
                                            <Link to={`/tracks?id=${track.id}`} className="card-title">
                                                {track.title}
                                            </Link>
                                            <Link to={`/artists?id=${track.artistId}`} className="card-artist">
                                                {track.artistName}
                                            </Link>
                                            <span
                                                className="card-artist"
                                                style={{ textDecoration: "none", cursor: "default" }}
                                            >
                                                {track.voteCount}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    )}
                </section>
            )}

            <ScrollToTop />
        </div>
    );
}
