package com.atguigu.atcrowdfunding.service.impl;



import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.dao.TMenuMapper;
import com.atguigu.atcrowdfunding.service.TmenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TmenuServiceImpl implements TmenuService {
    @Autowired
    private TMenuMapper tMenuMapper;


    @Override
    public List<TMenu> getAllMenuTree() {
        return tMenuMapper.selectByExample(null);
    }

    @Override
    public void saveTMenu(TMenu tMenu) {
        tMenuMapper.insertSelective(tMenu);
    }

    @Override
    public void deleteMenuById(Integer id) {
        tMenuMapper.deleteByPrimaryKey(id);
    }

    @Override
    public TMenu changeMenu(Integer id) {
        return tMenuMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateRole(TMenu tMenu) {
        tMenuMapper.updateByPrimaryKeySelective(tMenu);
    }
}
