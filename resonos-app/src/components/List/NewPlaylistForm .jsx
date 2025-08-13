import 'bootstrap/dist/css/bootstrap.min.css';
import './MainForm.css'
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import PlaylistGridSection from './section/PlaylistGridSection';

export default function NewPlaylistForm(props) {
    const {
        newPlaylistList = [],
        newPlaylistCount = 0,
        pagination = [],
        onPageChange = () => {}
    } = props;

    return (
        <div className="container-fluid d-flex flex-column align-items-center px-0" style={{ maxWidth: 1440, paddingTop: 50, gap: 50 }}>
            <PlaylistGridSection
                title="최신 플레이리스트"
                playlistList={newPlaylistList}
                count={newPlaylistCount}
                pagination={pagination}
                onPageChange={onPageChange}
            />

            <ScrollToTop />
        </div>
    );
}
