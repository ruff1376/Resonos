import React, { useEffect, useState } from 'react'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import MainForm from '../../components/List/MainForm'
import api from '../../apis/api'

const Main = () => {
    const [korHotReviewAlbumList, setKorHotReviewAlbumList] = useState([]);
    const [worldHotReviewAlbumList, setWorldHotReviewAlbumList] = useState([]);
    const [newAlbumList, setNewAlbumList] = useState([]);
    const [hotAlbumList, setHotAlbumList] = useState([]);
    const [newTrackList, setNewTrackList] = useState([]);
    const [hotTrackList, setHotTrackList] = useState([]);
    const [newPlaylistList, setNewPlaylistList] = useState([]);
    const [hotPlaylistList, setHotPlaylistList] = useState([]);
    const [topTracksByTag, setTopTracksByTag] = useState({});
    const [topTags, setTopTags] = useState([]);
    const [newAlbumCount, setNewAlbumCount] = useState({});
    const [hotAlbumCount, setHotAlbumCount] = useState({});
    const [newTrackCount, setNewTrackCount] = useState({});
    const [hotTrackCount, setHotTrackCount] = useState({});
    const [newPlaylistCount, setNewPlaylistCount] = useState({});
    const [hotPlaylistCount, setHotPlaylistCount] = useState({});

    useEffect(() => {
        api.get('/list/main')
            .then((res) => {
                const data = res.data;
                console.log('받은 데이터:', data);
                setKorHotReviewAlbumList(data.korHotReviewAlbumList);
                setWorldHotReviewAlbumList(data.worldHotReviewAlbumList);
                setNewAlbumList(data.newAlbumList);
                setHotAlbumList(data.hotAlbumList);
                setNewTrackList(data.newTrackList);
                setHotTrackList(data.hotTrackList);
                setNewPlaylistList(data.newPlaylistList);
                setHotPlaylistList(data.hotPlaylistList);
                setTopTracksByTag(data.topTracksByTag);
                setTopTags(data.topTags);
                setNewAlbumCount(data.newAlbumCount);
                setHotAlbumCount(data.hotAlbumCount);
                setNewTrackCount(data.newTrackCount);
                setHotTrackCount(data.hotTrackCount);
                setNewPlaylistCount(data.newPlaylistCount);
                setHotPlaylistCount(data.hotPlaylistCount);
            })
            .catch((error) => {
                console.error('메인 데이터 불러오기 실패:', error);
            });
    }, []);

    return (
        <>
            <Header />
            <MainForm
                korHotReviewAlbumList={korHotReviewAlbumList}
                worldHotReviewAlbumList={worldHotReviewAlbumList}
                newAlbumList={newAlbumList}
                hotAlbumList={hotAlbumList}
                newTrackList={newTrackList}
                hotTrackList={hotTrackList}
                newPlaylistList={newPlaylistList}
                hotPlaylistList={hotPlaylistList}
                topTracksByTag={topTracksByTag}
                topTags={topTags}
                newAlbumCount={newAlbumCount}
                hotAlbumCount={hotAlbumCount}
                newTrackCount={newTrackCount}
                hotTrackCount={hotTrackCount}
                newPlaylistCount={newPlaylistCount}
                hotPlaylistCount={hotPlaylistCount}
            />
            <Footer />
        </>
    )
}

export default Main