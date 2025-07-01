package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.ChartElement;
import com.cosmus.resonos.mapper.ChartElementMapper;

@Service
public class ChartElementServiceImpl implements ChartElementService {

    @Autowired
    private ChartElementMapper chartElementMapper;

    @Override
    public List<ChartElement> list() throws Exception {
        return chartElementMapper.list();
    }

    @Override
    public ChartElement select(Long id) throws Exception {
        return chartElementMapper.select(id);
    }

    @Override
    public boolean insert(ChartElement chartElement) throws Exception {
        return chartElementMapper.insert(chartElement) > 0;
    }

    @Override
    public boolean update(ChartElement chartElement) throws Exception {
        return chartElementMapper.update(chartElement) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return chartElementMapper.delete(id) > 0;
    }
}
