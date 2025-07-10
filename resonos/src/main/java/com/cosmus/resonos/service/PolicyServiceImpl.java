package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Policy;
import com.cosmus.resonos.mapper.PolicyMapper;

@Service
public class PolicyServiceImpl implements PolicyService {
    @Autowired
    private PolicyMapper policyMapper;

    @Override
    public List<Policy> list() throws Exception {
        return policyMapper.list();
    }

    @Override
    public Policy select(Long id) throws Exception {
        return policyMapper.select(id);
    }

    @Override
    public boolean insert(Policy policy) throws Exception {
        // version 자동 생성
        policy.setVersion("v" + System.currentTimeMillis());
        return policyMapper.insert(policy) > 0;
    }

    @Override
    public boolean update(Policy policy) throws Exception {
        // version 자동 갱신
        policy.setVersion("v" + System.currentTimeMillis());
        return policyMapper.update(policy) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return policyMapper.delete(id) > 0;
    }
    @Override
    public Policy selectByType(String type) throws Exception {
        return policyMapper.selectByType(type);
    }

}
