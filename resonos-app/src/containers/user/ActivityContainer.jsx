import React, { useEffect, useState } from 'react'
import Activity from '../../components/user/Activity'
import * as ur from '../../apis/user'
import {MySwal} from '../../apis/alert'
import Header from '../../components/Header/Header';
import Footer from '../../components/Footer/Footer';
import { useNavigate } from 'react-router-dom';

const ActivityContainer = () => {

  const [utl, setUtl] = useState({});
  const [countAReview, setCountAReview] = useState();
  const [countLaReview, setCountLaReview] = useState();
  const [countLtReview, setCountLtReview] = useState();
  const [countTReview, setCountTReview] = useState();
  const [aReviewList, setAReviewList] = useState([]);
  const [laReviewList, setLaReviewList] = useState([]);
  const [tReviewList, setTReviewList] = useState([]);
  const [ltReviewList, setLtReviewList] = useState([]);

  const [user, setUser] = useState({});
  const [lastPath, setLastPath] = useState();

  const navigate = useNavigate()


  // 리뷰 검색, 요청 함수
  const onSearchReview = async (keyword, offsetRef, limitRef, loadingRef, allLoadedRef, type) => {
    console.log(keyword)
    if (loadingRef.current || allLoadedRef.current) return

    loadingRef.current = true

    try {
      const { data } = await ur.loadMoreUserReviews({
        keyword,
        offset: offsetRef.current,
        limit: limitRef.current,
        type
      })

      switch(type) {
        case 'ar':
          setAReviewList(prev => {
            const existingIds = new Set(prev.map(t => t.id))
            const filteredData = data.filter(t => !existingIds.has(t.id))
            return [...prev, ...filteredData]
          })
          break;
        case 'lar':
          setLaReviewList(prev => {
            const existingIds = new Set(prev.map(t => t.id))
            const filteredData = data.filter(t => !existingIds.has(t.id))
            return [...prev, ...filteredData]
          })
          break;
        case 'tr':
          setTReviewList(prev => {
            const existingIds = new Set(prev.map(t => t.id))
            const filteredData = data.filter(t => !existingIds.has(t.id))
            return [...prev, ...filteredData]
          })
          break;
        case 'ltr':
          setLtReviewList(prev => {
            const existingIds = new Set(prev.map(t => t.id))
            const filteredData = data.filter(t => !existingIds.has(t.id))
            return [...prev, ...filteredData]
          })
          break;
        default:
          break;
      }

      offsetRef.current += limitRef.current

      console.log(offsetRef.current)

      if (data.length < limitRef.current) {
        allLoadedRef.current = true
      }
    } catch (err) {
      console.error(err)
    } finally {
      loadingRef.current = false
    }
  }

  // 마운트 시 초기 데이터 요청
  const getUsersActivity = async () => {
    try {
      const response = await ur.getUserActivity()
      const data = response.data
      console.log('data :', data)
      if(response.status === 200) {
        setUtl(data.utl);
        setCountAReview(data.countAReview);
        setCountLaReview(data.countLaReview);
        setCountLtReview(data.countLtReview);
        setCountTReview(data.countTReview);
        setAReviewList(data.aReviewList);
        setLaReviewList(data.laReviewList);
        setLtReviewList(data.ltReviewList);
        setTReviewList(data.tReviewList);
        setUser(data.user);
        setLastPath(data.lastPath);
      }
    } catch(e) {
      if(e.status === 401) {
        MySwal.fire({
          position: "center",
          icon: "warning",
          title: "로그인이 필요한 서비스입니다.",
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
        setTimeout(() => {
          navigate('/login')
        }, 900)
      }
      console.log('error :', e)
    }
  }

  // 마운트 시 초기 데이터 요청
  useEffect(() => {
    getUsersActivity()
  }, [])




  return (
    <div className="container">
      <Header />
      <Activity
        utl={utl}
        countAReview={countAReview}
        countLaReview={countLaReview}
        countLtReview={countLtReview}
        countTReview={countTReview}
        aReviewList={aReviewList}
        laReviewList={laReviewList}
        ltReviewList={ltReviewList}
        tReviewList={tReviewList}
        setAReviewList={setAReviewList}
        setLaReviewList={setLaReviewList}
        setLtReviewList={setLtReviewList}
        setTReviewList={setTReviewList}
        user={user}
        lastPath={lastPath}
        onSearchReview={onSearchReview}
      />
      <Footer />
    </div>
  )
}

export default ActivityContainer