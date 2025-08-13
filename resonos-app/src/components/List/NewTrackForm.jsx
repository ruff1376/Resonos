import 'bootstrap/dist/css/bootstrap.min.css';
import './MainForm.css'
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import useRatingCharts from './hooks/useRatingCharts';
import TrackGridSection from './section/TrackGridSection';

export default function NewTrackForm(props) {
    const {
        newTrackList = [],
        newTrackCount = 0,
        pagination = [],
        onPageChange = () => {}
    } = props;

    useRatingCharts([newTrackList]);

    return (
        <div className="container-fluid d-flex flex-column align-items-center px-0" style={{ maxWidth: 1440, paddingTop: 50, gap: 50 }}>
            <TrackGridSection
                title="최신 트랙"
                trackList={newTrackList}
                count={newTrackCount}
                pagination={pagination}
                onPageChange={onPageChange}
            />

            <ScrollToTop />
        </div>
    );
}
