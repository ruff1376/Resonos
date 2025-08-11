import React, { useEffect, useState } from 'react'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import api from '../../apis/api'
import { useSearchParams } from 'react-router-dom'
import AlbumSearchForm from '../../components/Search/AlbumSearchForm'

const AlbumSearch = () => {
    const [albumSearchList, setAlbumSearchList] = useState([]);
    const [albumSearchCount, setAlbumSearchCount] = useState(0);
    const [pagination, setPagination] = useState({});
    const [searchParams, setSearchParams] = useSearchParams();

    const q = searchParams.get('q');
    const page = parseInt(searchParams.get('page')) || 1;
    const sort = searchParams.get('sort');

    useEffect(() => {
        api.get(`/search/albums?q=${q}&page=${page}&sort=${sort}`)
            .then((res) => {
                const data = res.data;
                console.log('받은 데이터:', data);
                setAlbumSearchList(data.albumSearchList);
                setAlbumSearchCount(data.albumSearchCount);
                setPagination(data.pagination);
            })
            .catch((error) => {
                console.error('메인 데이터 불러오기 실패:', error);
            });
    }, [q, page, sort]);

    // 페이지 변경 핸들러
    const handlePageChange = (pageNum) => {
        const params = Object.fromEntries(searchParams.entries());
        params.page = pageNum;
        setSearchParams(params);
    };

    // 정렬 변경 핸들러
    const handleSortChange = (e) => {
        const params = Object.fromEntries(searchParams.entries());
        params.sort = e.target.value;
        params.page = 1; // 정렬 변경 시 페이지 초기화
        setSearchParams(params);
    };

    return (
        <>
            <Header />
            <AlbumSearchForm
                keyword={q}
                albumSearchList={albumSearchList}
                albumSearchCount={albumSearchCount}
                pagination={pagination}
                sort={sort || "relevance"}
                onPageChange={handlePageChange}
                handleSortChange={handleSortChange}
            />
            <Footer />
        </>
    )
}

export default AlbumSearch