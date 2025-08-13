import React, { useEffect, useState } from 'react'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import api from '../../apis/api'
import { useSearchParams } from 'react-router-dom'
import PlaylistSearchForm from '../../components/Search/PlaylistSearchForm'

const PlaylistSearch = () => {
    const [playlistSearchList, setPlaylistSearchList] = useState([]);
    const [playlistSearchCount, setPlaylistSearchCount] = useState(0);
    const [pagination, setPagination] = useState({});
    const [searchParams, setSearchParams] = useSearchParams();

    const q = searchParams.get('q');
    const page = parseInt(searchParams.get('page')) || 1;

    useEffect(() => {
        api.get(`/search/playlists?q=${q}&page=${page}`)
            .then((res) => {
                const data = res.data;
                console.log('받은 데이터:', data);
                setPlaylistSearchList(data.playlistSearchList);
                setPlaylistSearchCount(data.playlistSearchCount);
                setPagination(data.pagination);
            })
            .catch((error) => {
                console.error('메인 데이터 불러오기 실패:', error);
            });
    }, [q, page]);

    const handlePageChange = (pageNum) => {
        setSearchParams({ q, page: pageNum });
    };

    return (
        <>
            <Header />
            <PlaylistSearchForm
                keyword={q}
                playlistSearchList={playlistSearchList}
                playlistSearchCount={playlistSearchCount}
                pagination={pagination}
                onPageChange={handlePageChange}
            />
            <Footer />
        </>
    )
}

export default PlaylistSearch