import 'bootstrap/dist/css/bootstrap.min.css';
import './MainForm.css'
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import PlaylistGridSection from './section/PlaylistGridSection';

export default function HotPlaylistForm(props) {
    const {
        hotPlaylistList = [],
        hotPlaylistCount = 0,
        pagination = [],
        onPageChange = () => {}
    } = props;

    return (
        <div className="container-fluid d-flex flex-column align-items-center px-0" style={{ maxWidth: 1440, paddingTop: 50, gap: 50 }}>
            <PlaylistGridSection
                title="인기 플레이리스트"
                playlistList={hotPlaylistList}
                count={hotPlaylistCount}
                pagination={pagination}
                onPageChange={onPageChange}
            />

            <ScrollToTop />
        </div>
    );
}
