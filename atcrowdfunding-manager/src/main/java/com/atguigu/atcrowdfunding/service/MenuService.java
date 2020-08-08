package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TMenu;

import java.util.List;

public interface MenuService {

    //查询所有父，父含有children属性。
    //侧边栏，组装好父子关系后返回所有的父。
    List<TMenu> listAllMenus();

    //生成菜单树
    List<TMenu> listAllMenusTree();
}
