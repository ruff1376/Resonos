// package com.cosmus.resonos.mapper;

// import java.util.List;

// import org.apache.ibatis.annotations.Mapper;
// import org.apache.ibatis.annotations.Param;

// import com.cosmus.resonos.domain.User;
// import com.cosmus.resonos.domain.UserAuth;


// @Mapper
// public interface UserMapper {

//     // 회원 가입
//     public int join(User user) throws Exception;

//     // 회원 권한 등록
//     public int insertAuth(UserAuth userAuth) throws Exception;

//     // 회원 조회
//     public User select(@Param("username") String username) throws Exception;

//     // 전체 조회
//     public List<User> list() throws Exception;
//     // 아이디 조회
//     public User selectById(Long id) throws Exception;
//     // 수정
//     public int update(User user) throws Exception;
//     // 삭제
//     public int delete(Long id) throws Exception;
// }
