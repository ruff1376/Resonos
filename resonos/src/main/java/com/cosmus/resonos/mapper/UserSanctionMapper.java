package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.UserSanction;

@Mapper
public interface UserSanctionMapper {
    // 전체 조회
    public List<UserSanction> list() throws Exception;
    // 조회
    public UserSanction select(Long id) throws Exception;
    // 삽입
    public int insert(UserSanction sanction) throws Exception;
    // 수정
    public int update(UserSanction sanction) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}
