package com.cosmus.resonos.service.admin;

import java.util.List;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.admin.QnaAnswer;
import com.cosmus.resonos.mapper.admin.QnaAnswerMapper;

@Service
public class QnaAnswerServiceImpl implements QnaAnswerService {

    private final QnaAnswerMapper qnaAnswerMapper;

    public QnaAnswerServiceImpl(QnaAnswerMapper qnaAnswerMapper) {
        this.qnaAnswerMapper = qnaAnswerMapper;
    }

    @Override
    public List<QnaAnswer> list() throws Exception {
        return qnaAnswerMapper.list();
    }

    @Override
    public QnaAnswer select(Long id) throws Exception {
        return qnaAnswerMapper.select(id);
    }

    @Override
    public boolean insert(QnaAnswer answer) throws Exception {
        return qnaAnswerMapper.insert(answer) > 0;
    }

    @Override
    public boolean update(QnaAnswer answer) throws Exception {
        return qnaAnswerMapper.update(answer) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return qnaAnswerMapper.delete(id) > 0;
    }

    @Override
    public List<QnaAnswer> findByQnaId(Long qnaId) throws Exception {
        return qnaAnswerMapper.findByQnaId(qnaId);
    }
}
