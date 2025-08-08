import React, { useEffect, useState } from 'react'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import api from '../../apis/api'
import { useNavigate, useSearchParams } from 'react-router-dom'
import NewPlaylistForm from '../../components/List/NewPlaylistForm '

const NewPlaylist = () => {
    const [newPlaylistList, setNewPlaylistList] = useState([]);
    const [newPlaylistCount, setNewPlaylistCount] = useState({});
    const [pagination, setPagination] = useState({});
    const [searchParams, setSearchParams] = useSearchParams();
    const navigate = useNavigate();

    const page = parseInt(searchParams.get('page')) || 1;

    useEffect(() => {
        api.get(`/list/new-playlists?page=${page}`)
            .then((res) => {
                const data = res.data;
                console.log('받은 데이터:', data);
                setNewPlaylistList(data.newPlaylistList);
                setNewPlaylistCount(data.newPlaylistCount);
                setPagination(data.pagination);
            })
            .catch((error) => {
                console.error('메인 데이터 불러오기 실패:', error);
            });
    }, [page]);

    const handlePageChange = (pageNum) => {
        setSearchParams({ page: pageNum });
    };

    return (
        <>
            <Header />
            <NewPlaylistForm
                newPlaylistList={newPlaylistList}
                newPlaylistCount={newPlaylistCount}
                pagination={pagination}
                onPageChange={handlePageChange}
            />
            <Footer />
        </>
    )
}

export default NewPlaylist