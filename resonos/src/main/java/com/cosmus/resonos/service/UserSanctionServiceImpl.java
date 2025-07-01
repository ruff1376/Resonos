package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.UserSanction;
import com.cosmus.resonos.mapper.UserSanctionMapper;

@Service
public class UserSanctionServiceImpl implements UserSanctionService {

    @Autowired
    private UserSanctionMapper userSanctionMapper;

    @Override
    public List<UserSanction> list() throws Exception {
        return userSanctionMapper.list();
    }

    @Override
    public UserSanction select(Long id) throws Exception {
        return userSanctionMapper.select(id);
    }

    @Override
    public boolean insert(UserSanction sanction) throws Exception {
        return userSanctionMapper.insert(sanction) > 0;
    }

    @Override
    public boolean update(UserSanction sanction) throws Exception {
        return userSanctionMapper.update(sanction) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return userSanctionMapper.delete(id) > 0;
    }
}
