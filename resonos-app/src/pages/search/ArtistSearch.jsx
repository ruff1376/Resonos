import React, { useEffect, useState } from 'react'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import api from '../../apis/api'
import { useSearchParams } from 'react-router-dom'
import ArtistSearchForm from '../../components/Search/ArtistSearchForm'

const ArtistSearch = () => {
    const [artistSearchList, setArtistSearchList] = useState([]);
    const [artistSearchCount, setArtistSearchCount] = useState(0);
    const [pagination, setPagination] = useState({});
    const [searchParams, setSearchParams] = useSearchParams();

    const q = searchParams.get('q');
    const page = parseInt(searchParams.get('page')) || 1;

    useEffect(() => {
        api.get(`/search/artists?q=${q}&page=${page}`)
            .then((res) => {
                const data = res.data;
                console.log('받은 데이터:', data);
                setArtistSearchList(data.artistSearchList);
                setArtistSearchCount(data.artistSearchCount);
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
            <ArtistSearchForm
                keyword={q}
                artistSearchList={artistSearchList}
                artistSearchCount={artistSearchCount}
                pagination={pagination}
                onPageChange={handlePageChange}
            />
            <Footer />
        </>
    )
}

export default ArtistSearch