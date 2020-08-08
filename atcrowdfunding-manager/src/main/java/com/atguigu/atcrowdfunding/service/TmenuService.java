package com.atguigu.atcrowdfunding.service;


import com.atguigu.atcrowdfunding.bean.TMenu;

import java.util.List;

public interface TmenuService {
    List<TMenu> getAllMenuTree();

    void saveTMenu(TMenu tMenu);

    void deleteMenuById(Integer id);

    TMenu changeMenu(Integer id);

    void updateRole(TMenu tMenu);
}
