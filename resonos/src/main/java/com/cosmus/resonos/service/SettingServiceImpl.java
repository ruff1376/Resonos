package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.Setting;
import com.cosmus.resonos.mapper.SettingMapper;

@Service
public class SettingServiceImpl implements SettingService {

    @Autowired
    private SettingMapper settingMapper;

    @Override
    public List<Setting> list() throws Exception {
        return settingMapper.list();
    }

    @Override
    public Setting select(Long id) throws Exception {
        return settingMapper.select(id);
    }

    @Override
    public boolean insert(Setting setting) throws Exception {
        return settingMapper.insert(setting) > 0;
    }

    @Override
    public boolean update(Setting setting) throws Exception {
        return settingMapper.update(setting) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return settingMapper.delete(id) > 0;
    }
}
