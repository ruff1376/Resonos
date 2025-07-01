package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.ChartEntry;
import com.cosmus.resonos.mapper.ChartEntryMapper;

@Service
public class ChartEntryServiceImpl implements ChartEntryService {

    @Autowired
    private ChartEntryMapper chartEntryMapper;

    @Override
    public List<ChartEntry> list() throws Exception {
        return chartEntryMapper.list();
    }

    @Override
    public ChartEntry select(Long id) throws Exception {
        return chartEntryMapper.select(id);
    }

    @Override
    public boolean insert(ChartEntry entry) throws Exception {
        return chartEntryMapper.insert(entry) > 0;
    }

    @Override
    public boolean update(ChartEntry entry) throws Exception {
        return chartEntryMapper.update(entry) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return chartEntryMapper.delete(id) > 0;
    }
}
