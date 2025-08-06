package com.cosmus.resonos.service.user;

import java.util.List;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.user.Qna;
import com.cosmus.resonos.mapper.user.QnaMapper;

@Service
public class QnaServiceImpl implements QnaService {

    private final QnaMapper qnaMapper;

    public QnaServiceImpl(QnaMapper qnaMapper) {
        this.qnaMapper = qnaMapper;
    }

    @Override
    public List<Qna> list() throws Exception {
        return qnaMapper.list();
    }

    @Override
    public Qna select(Long id) throws Exception {
        return qnaMapper.select(id);
    }

    @Override
    public boolean insert(Qna qna) throws Exception {
        return qnaMapper.insert(qna) > 0;
    }

    @Override
    public boolean update(Qna qna) throws Exception {
        return qnaMapper.update(qna) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return qnaMapper.delete(id) > 0;
    }

    @Override
    public List<Qna> listAnswered() throws Exception {
        return qnaMapper.listAnswered();
    }

    @Override
    public List<Qna> listNoAnswer() throws Exception {
        return qnaMapper.listNoAnswer();
    }
}
