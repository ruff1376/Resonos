import 'bootstrap/dist/css/bootstrap.min.css';
import './MainForm.css'
import ScrollToTop from '../ScrollToTop/ScrollToTop';
import useRatingCharts from './hooks/useRatingCharts';
import TrackGridSection from './section/TrackGridSection';

export default function HotTrackForm(props) {
    const {
        hotTrackList = [],
        hotTrackCount = 0,
        pagination = [],
        onPageChange = () => {}
    } = props;

    useRatingCharts([hotTrackList]);

    return (
        <div className="container-fluid d-flex flex-column align-items-center px-0" style={{ maxWidth: 1440, paddingTop: 50, gap: 50 }}>
            <TrackGridSection
                title="인기 트랙"
                trackList={hotTrackList}
                count={hotTrackCount}
                pagination={pagination}
                onPageChange={onPageChange}
            />

            <ScrollToTop />
        </div>
    );
}
