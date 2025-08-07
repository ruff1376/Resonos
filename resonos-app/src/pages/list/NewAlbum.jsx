import React, { useEffect, useState } from 'react'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import api from '../../apis/api'
import NewAlbumForm from '../../components/List/NewAlbumForm'
import { useNavigate, useSearchParams } from 'react-router-dom'

const Main = () => {
    const [newAlbumList, setNewAlbumList] = useState([]);
    const [newAlbumCount, setNewAlbumCount] = useState({});
    const [pagination, setPagination] = useState({});
    const [searchParams, setSearchParams] = useSearchParams();
    const navigate = useNavigate();

    const page = parseInt(searchParams.get('page')) || 1;

    useEffect(() => {
        api.get(`/list/new-albums?page=${page}`)
            .then((res) => {
                const data = res.data;
                console.log('받은 데이터:', data);
                setNewAlbumList(data.newAlbumList);
                setNewAlbumCount(data.newAlbumCount);
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
            <NewAlbumForm
                newAlbumList={newAlbumList}
                newAlbumCount={newAlbumCount}
                pagination={pagination}
                onPageChange={handlePageChange}
            />
            <Footer />
        </>
    )
}

export default Main