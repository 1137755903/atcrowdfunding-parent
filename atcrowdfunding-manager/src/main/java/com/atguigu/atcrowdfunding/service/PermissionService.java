package com.atguigu.atcrowdfunding.service;



import com.atguigu.atcrowdfunding.bean.TPermission;

import java.util.List;

public interface PermissionService {
    List<TPermission> getAllPermission();

    void savePermission(TPermission tPermission);

    void deletePermission(Integer id);

    TPermission changePermission(Integer id);

    void updatePermission(TPermission tPermission);
}
