import React, { useEffect, useState } from 'react'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import api from '../../apis/api'
import { useNavigate, useSearchParams } from 'react-router-dom'
import HotPlaylistForm from '../../components/List/HotPlaylistForm'

const HotPlsylist = () => {
    const [hotPlaylistList, setHotPlaylistList] = useState([]);
    const [hotPlaylistCount, setHotPlaylistCount] = useState({});
    const [pagination, setPagination] = useState({});
    const [searchParams, setSearchParams] = useSearchParams();
    const navigate = useNavigate();

    const page = parseInt(searchParams.get('page')) || 1;

    useEffect(() => {
        api.get(`/list/hot-playlists?page=${page}`)
            .then((res) => {
                const data = res.data;
                console.log('받은 데이터:', data);
                setHotPlaylistList(data.hotPlaylistList);
                setHotPlaylistCount(data.hotPlaylistCount);
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
            <HotPlaylistForm
                hotPlaylistList={hotPlaylistList}
                hotPlaylistCount={hotPlaylistCount}
                pagination={pagination}
                onPageChange={handlePageChange}
            />
            <Footer />
        </>
    )
}

export default HotPlsylist