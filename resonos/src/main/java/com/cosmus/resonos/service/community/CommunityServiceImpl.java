package com.cosmus.resonos.service.community;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.community.Community;
import com.cosmus.resonos.mapper.community.CommunityMapper;

@Service
public class CommunityServiceImpl implements CommunityService {

    @Autowired
    private CommunityMapper communityMapper;

    @Override
    public List<Community> list() throws Exception {
        return communityMapper.list();
    }

    @Override
    public Community select(Long id) throws Exception {
        return communityMapper.select(id);
    }

    @Override
    public boolean insert(Community community) throws Exception {
        return communityMapper.insert(community) > 0;
    }

    @Override
    public boolean update(Community community) throws Exception {
        return communityMapper.update(community) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return communityMapper.delete(id) > 0;
    }
}
