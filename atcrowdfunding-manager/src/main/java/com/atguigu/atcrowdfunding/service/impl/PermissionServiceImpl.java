package com.atguigu.atcrowdfunding.service.impl;




import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.dao.TPermissionMapper;
import com.atguigu.atcrowdfunding.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class PermissionServiceImpl implements PermissionService {
    @Autowired
    private TPermissionMapper tPermissionMapper;
    @Override
    public List<TPermission> getAllPermission() {
        return tPermissionMapper.selectByExample(null);
    }

    @Override
    public void savePermission(TPermission tPermission) {
        tPermissionMapper.insertSelective(tPermission);
    }

    @Override
    public void deletePermission(Integer id) {
        tPermissionMapper.deleteByPrimaryKey(id);
    }

    @Override
    public TPermission changePermission(Integer id) {
        return tPermissionMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updatePermission(TPermission tPermission) {
        tPermissionMapper.updateByPrimaryKeySelective(tPermission);
    }
}
