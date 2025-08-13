import 'bootstrap/dist/css/bootstrap.min.css';
import './MainForm.css'
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import useRatingCharts from './hooks/useRatingCharts';
import AlbumGridSection from './section/AlbumGridSection';

export default function NewAlbumForm(props) {
    const {
        newAlbumList = [],
        newAlbumCount = 0,
        pagination = [],
        onPageChange = () => {}
    } = props;

    useRatingCharts([newAlbumList]);

    return (
        <div className="container-fluid d-flex flex-column align-items-center px-0" style={{ maxWidth: 1440, paddingTop: 50, gap: 50 }}>
            <AlbumGridSection
                title="최신 앨범"
                albumList={newAlbumList}
                count={newAlbumCount}
                pagination={pagination}
                onPageChange={onPageChange}
            />

            <ScrollToTop />
        </div>
    );
}
