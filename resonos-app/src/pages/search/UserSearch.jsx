import React, { useEffect, useState } from 'react'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'
import api from '../../apis/api'
import { useSearchParams } from 'react-router-dom'
import UserSearchForm from '../../components/Search/UserSearchForm'

const UserSearch = () => {
    const [userSearchList, setUserSearchList] = useState([]);
    const [userSearchCount, setUserSearchCount] = useState(0);
    const [pagination, setPagination] = useState({});
    const [searchParams, setSearchParams] = useSearchParams();

    const q = searchParams.get('q');
    const page = parseInt(searchParams.get('page')) || 1;

    useEffect(() => {
        api.get(`/search/users?q=${q}&page=${page}`)
            .then((res) => {
                const data = res.data;
                console.log('받은 데이터:', data);
                setUserSearchList(data.userSearchList);
                setUserSearchCount(data.userSearchCount);
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
            <UserSearchForm
                keyword={q}
                userSearchList={userSearchList}
                userSearchCount={userSearchCount}
                pagination={pagination}
                onPageChange={handlePageChange}
            />
            <Footer />
        </>
    )
}

export default UserSearch