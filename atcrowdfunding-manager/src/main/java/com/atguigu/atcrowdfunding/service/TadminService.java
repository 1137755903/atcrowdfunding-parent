package com.atguigu.atcrowdfunding.service;



import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.github.pagehelper.PageInfo;

import javax.security.auth.login.LoginException;
import java.util.Map;

public interface TadminService {

    TAdmin getAdminByLogin(String loginacct, String userpswd) throws LoginException;

    PageInfo<TAdmin> listPage(Map<String,Object> map);

    void saveAdmin(TAdmin tAdmin);

    TAdmin getAdminById(Integer id);

    void upadteAdmin(TAdmin tAdmin);

    void deleteAdminById(Integer id);

    void deleteBatchById(String s);
}

