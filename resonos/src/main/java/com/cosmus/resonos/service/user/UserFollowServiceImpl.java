package com.cosmus.resonos.service.user;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.user.UserFollow;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.mapper.user.UserFollowMapper;

@Service
public class UserFollowServiceImpl implements UserFollowService {

    @Autowired
    private UserFollowMapper userFollowMapper;

    @Override
    public List<UserFollow> list() throws Exception {
        return userFollowMapper.list();
    }

    @Override
    public UserFollow select(Long id) throws Exception {
        return userFollowMapper.select(id);
    }

    @Override
    public boolean insert(UserFollow userFollow) throws Exception {
        return userFollowMapper.insert(userFollow) > 0;
    }

    @Override
    public boolean update(UserFollow userFollow) throws Exception {
        return userFollowMapper.update(userFollow) > 0;
    }

    @Override
    public boolean delete(Long loginUserId, Long id) throws Exception {
        return userFollowMapper.delete(loginUserId, id) > 0;
    }

    @Override
    public int myFollowerCount(Long id) throws Exception {
        return userFollowMapper.myFollowerCount(id);
    }

    @Override
    public int myFollowCount(Long id) throws Exception {
        return userFollowMapper.myFollowCount(id);
    }

    @Override
    public List<Users> myFollower(Long id, String keyword, int offset, int limit) throws Exception {
        return userFollowMapper.myFollower(id, keyword, offset, limit);
    }

    @Override
    public List<Users> myFollow(Long id, String keyword, int offset, int limit) throws Exception {
        return userFollowMapper.myFollow(id, keyword, offset, limit);
    }

    @Override
    public boolean checkAlreadyFollow(Long loginUserId, Long id) throws Exception {
        return userFollowMapper.checkAlreadyFollow(loginUserId, id) > 0 ? true : false;
    }
}
