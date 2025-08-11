import React, { useEffect, useState } from 'react'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import api from '../../apis/api'
import { useSearchParams } from 'react-router-dom'
import HotAlbumForm from '../../components/List/HotAlbumForm'

const HotAlbum = () => {
    const [hotAlbumList, setHotAlbumList] = useState([]);
    const [hotAlbumCount, setHotAlbumCount] = useState({});
    const [pagination, setPagination] = useState({});
    const [searchParams, setSearchParams] = useSearchParams();

    const page = parseInt(searchParams.get('page')) || 1;

    useEffect(() => {
        api.get(`/list/hot-albums?page=${page}`)
            .then((res) => {
                const data = res.data;
                console.log('받은 데이터:', data);
                setHotAlbumList(data.hotAlbumList);
                setHotAlbumCount(data.hotAlbumCount);
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
            <HotAlbumForm
                hotAlbumList={hotAlbumList}
                hotAlbumCount={hotAlbumCount}
                pagination={pagination}
                onPageChange={handlePageChange}
            />
            <Footer />
        </>
    )
}

export default HotAlbum