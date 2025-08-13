package com.cosmus.resonos.service.admin;

import java.util.List;

import com.cosmus.resonos.domain.admin.QnaAnswer;

public interface QnaAnswerService {
    // 전체 조회
    public List<QnaAnswer> list() throws Exception;
    // 조회
    public QnaAnswer select(Long id) throws Exception;
    // 삽입
    public boolean insert(QnaAnswer answer) throws Exception;
    // 수정
    public boolean update(QnaAnswer answer) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // Qna 원본
    public List<QnaAnswer> findByQnaId(Long qnaId) throws Exception;
}
