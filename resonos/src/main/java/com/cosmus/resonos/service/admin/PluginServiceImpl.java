package com.cosmus.resonos.service.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.admin.Plugin;
import com.cosmus.resonos.mapper.admin.PluginMapper;

@Service
public class PluginServiceImpl implements PluginService {

    @Autowired
    private PluginMapper pluginMapper;

    @Override
    public List<Plugin> list() throws Exception {
        return pluginMapper.list();
    }

    @Override
    public Plugin select(Long id) throws Exception {
        return pluginMapper.select(id);
    }

    @Override
    public boolean insert(Plugin plugin) throws Exception {
        return pluginMapper.insert(plugin) > 0;
    }

    @Override
    public boolean update(Plugin plugin) throws Exception {
        return pluginMapper.update(plugin) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return pluginMapper.delete(id) > 0;
    }
    @Override
    public void toggleEnabled(Long id) throws Exception {
        Plugin plugin = pluginMapper.select(id);
        if (plugin != null) {
            plugin.setEnabled(!plugin.getEnabled());
            pluginMapper.update(plugin);
        }
    }

}
