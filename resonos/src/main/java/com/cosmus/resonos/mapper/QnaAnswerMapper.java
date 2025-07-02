package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.QnaAnswer;

@Mapper
public interface QnaAnswerMapper {
    // 전체조회
    public List<QnaAnswer> list() throws Exception;
    // 조회
    public QnaAnswer select(Long id) throws Exception;
    // 삽입
    public int insert(QnaAnswer answer) throws Exception;
    // 수정
    public int update(QnaAnswer answer) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // Qna 원본
    public List<QnaAnswer> findByQnaId(Long qnaId) throws Exception;
}
