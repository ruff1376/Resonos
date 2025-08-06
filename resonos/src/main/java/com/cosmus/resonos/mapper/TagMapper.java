package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Vote.Tag;

@Mapper
public interface TagMapper {
    // 전체 조회
    public List<Tag> list() throws Exception;
    // 조회
    public Tag select(Long id) throws Exception;
    // 삽입
    public int insert(Tag tag) throws Exception;
    // 수정
    public int update(Tag tag) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 검색 searchByName
    public List<Tag> searchByName(String keyword);
    public long countAll(); // 전체 태그 개수 반환
    public long countByKeyword(String keyword); // 키워드별 태그 개수 반환
    public List<Tag> listPaging(@Param("offset") long offset,@Param("size") long size); // 페이징된 태그 리스트
    public List<Tag> searchByNamePaging(@Param("keyword") String keyword,@Param("offset") long offset,@Param("size") long size); // 키워드 기반 
}
