import 'bootstrap/dist/css/bootstrap.min.css';
import './MainForm.css'
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import AlbumSection from './section/AlbumSection';
import GridSection from './section/GridSection';
import useRatingCharts from './hooks/useRatingCharts';

export default function MainForm(props) {
    const {
        korHotReviewAlbumList = [],
        worldHotReviewAlbumList = [],
        newAlbumList = [],
        hotAlbumList = [],
        newTrackList = [],
        hotTrackList = [],
        newPlaylistList = [],
        hotPlaylistList = [],
        newAlbumCount = 0,
        hotAlbumCount = 0,
        newTrackCount = 0,
        hotTrackCount = 0,
        newPlaylistCount = 0,
        hotPlaylistCount = 0
    } = props;

    useRatingCharts([korHotReviewAlbumList, worldHotReviewAlbumList, newAlbumList, hotAlbumList, newTrackList, hotTrackList]);

    return (
        <div className="container-fluid d-flex flex-column align-items-center px-0" style={{ maxWidth: 1440, paddingTop: 50, gap: 50 }}>
            <div className="d-flex flex-row mb-5 w-100" style={{ maxWidth: 1440, margin: '10px auto', gap: 10 }}>
                <AlbumSection title="🔥🇰🇷리뷰 급상승 국내 앨범" albumList={korHotReviewAlbumList} />
                <AlbumSection title="🔥🌎리뷰 급상승 해외 앨범" albumList={worldHotReviewAlbumList} />
            </div>

            <GridSection title="최신 앨범" contentList={newAlbumList} count={newAlbumCount} moreLink="/list/new-albums" />
            <GridSection title="인기 앨범" contentList={hotAlbumList} count={hotAlbumCount} moreLink="/list/hot-albums" />
            <GridSection title="최신 트랙" contentList={newTrackList} count={newTrackCount} moreLink="/list/new-tracks" isTrack />
            <GridSection title="인기 트랙" contentList={hotTrackList} count={hotTrackCount} moreLink="/list/hot-tracks" isTrack />
            <GridSection title="최신 플레이리스트" contentList={newPlaylistList} count={newPlaylistCount} moreLink="/list/new-playlists" isPlaylist />
            <GridSection title="인기 플레이리스트" contentList={hotPlaylistList} count={hotPlaylistCount} moreLink="/list/hot-playlists" isPlaylist />

            <ScrollToTop />
        </div>
    );
}
