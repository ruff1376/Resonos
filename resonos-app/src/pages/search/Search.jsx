import React, { useEffect, useState } from 'react'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import api from '../../apis/api'
import SearchForm from '../../components/Search/SearchForm'
import { useSearchParams } from 'react-router-dom'

const Search = () => {
    const [artistSearchList, setArtistSearchList] = useState([]);
    const [albumSearchList, setAlbumSearchList] = useState([]);
    const [trackSearchList, setTrackSearchList] = useState([]);
    const [userSearchList, setUserSearchList] = useState([]);
    const [playlistSearchList, setPlaylistSearchList] = useState([]);
    const [searchTracksByTagList, setSearchTracksByTagList] = useState([]);
    const [artistSearchCount, setArtistSearchCount] = useState({});
    const [albumSearchCount, setAlbumSearchCount] = useState({});
    const [trackSearchCount, setTrackSearchCount] = useState({});
    const [userSearchCount, setUserSearchCount] = useState({});
    const [playlistSearchCount, setPlaylistSearchCount] = useState({});
    const [searchParams, setSearchParams] = useSearchParams();

    const q = searchParams.get('q');

    useEffect(() => {
        api.get(`/search?q=${q}`)
            .then((res) => {
                const data = res.data;
                console.log('받은 데이터:', data);
                setArtistSearchList(data.artistSearchList);
                setAlbumSearchList(data.albumSearchList);
                setTrackSearchList(data.trackSearchList);
                setUserSearchList(data.userSearchList);
                setPlaylistSearchList(data.playlistSearchList);
                setSearchTracksByTagList(data.searchTracksByTagList);
                setArtistSearchCount(data.artistSearchCount);
                setAlbumSearchCount(data.albumSearchCount);
                setTrackSearchCount(data.trackSearchCount);
                setUserSearchCount(data.userSearchCount);
                setPlaylistSearchCount(data.playlistSearchCount);
            })
            .catch((error) => {
                console.error('메인 데이터 불러오기 실패:', error);
            });
    }, [q]);

    const handleKeywordSearch = (keyword) => {
        setSearchParams({ q: keyword })
    };

    return (
        <>
            <Header />
            <SearchForm
                keyword={q}
                artistSearchList={artistSearchList}
                albumSearchList={albumSearchList}
                trackSearchList={trackSearchList}
                userSearchList={userSearchList}
                playlistSearchList={playlistSearchList}
                searchTracksByTagList={searchTracksByTagList}
                artistSearchCount={artistSearchCount}
                albumSearchCount={albumSearchCount}
                trackSearchCount={trackSearchCount}
                userSearchCount={userSearchCount}
                playlistSearchCount={playlistSearchCount}
                handleKeywordSearch={handleKeywordSearch}
            />
            <Footer />
        </>
    )
}

export default Search