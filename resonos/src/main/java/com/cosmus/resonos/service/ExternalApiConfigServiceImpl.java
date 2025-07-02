package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.ExternalApiConfig;
import com.cosmus.resonos.mapper.ExternalApiConfigMapper;

@Service
public class ExternalApiConfigServiceImpl implements ExternalApiConfigService {

    @Autowired
    private ExternalApiConfigMapper mapper;

    @Override
    public List<ExternalApiConfig> list() throws Exception {
        return mapper.list();
    }

    @Override
    public ExternalApiConfig select(Long id) throws Exception {
        return mapper.select(id);
    }

    @Override
    public boolean insert(ExternalApiConfig config) throws Exception {
        return mapper.insert(config) > 0;
    }

    @Override
    public boolean update(ExternalApiConfig config) throws Exception {
        return mapper.update(config) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return mapper.delete(id) > 0;
    }
    @Override
    public void toggleEnabled(Long id) throws Exception {
        ExternalApiConfig config = mapper.select(id);
        if (config != null) {
            config.setEnabled(!config.getEnabled());
            mapper.update(config);
        }
    }
}
