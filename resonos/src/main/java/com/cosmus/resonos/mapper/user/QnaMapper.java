package com.cosmus.resonos.mapper.user;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.user.Qna;

@Mapper
public interface QnaMapper {
    // 전체 조회
    public List<Qna> list() throws Exception;
    // 조회
    public Qna select(Long id) throws Exception;
    // 삽입
    public int insert(Qna qna) throws Exception;
    // 수정
    public int update(Qna qna) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 답변이 있는 QnA 목록
    public List<Qna> listAnswered() throws Exception;
    // 답변이 없는 QnA 목록
    public List<Qna> listNoAnswer() throws Exception;
}
