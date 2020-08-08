package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.LoginException;
import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.dao.TAdminMapper;
import com.atguigu.atcrowdfunding.service.TadminService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.DateUtil;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class TadminServiceImpl implements TadminService {
    @Autowired
    private TAdminMapper tAdminMapper;

    @Override
    public TAdmin getAdminByLogin(String loginacct, String userpswd) throws LoginException {
        TAdminExample example = new TAdminExample();
        example.createCriteria().andLoginacctEqualTo(loginacct);
        List<TAdmin> tAdmins = tAdminMapper.selectByExample(example);

        if (tAdmins == null || tAdmins.size() == 0) {
            throw new LoginException(Const.LOGIN_LOGINACCT_ERROR);
        }

        TAdmin tAdmin = tAdmins.get(0);
        if (!tAdmin.getUserpswd().equals(MD5Util.digest(userpswd))) {
            throw new LoginException(Const.LOGIN_USERPSWD_ERROR);
        }
        return tAdmin;
    }

    @Override
    public PageInfo<TAdmin> listPage(Map<String,Object> map) {
        TAdminExample example=new TAdminExample();
        String condition = (String) map.get("condition");
        if(!StringUtils.isEmpty(condition)){
            example.createCriteria().andLoginacctLike("%"+condition+"%");

            TAdminExample.Criteria criteria2 = example.createCriteria();
            criteria2.andUsernameLike("%"+condition+"%");

            TAdminExample.Criteria criteria3 = example.createCriteria();
            criteria3.andEmailLike("%"+condition+"%");

            example.or(criteria2);
            example.or(criteria3);
        }

//        example.setOrderByClause("createtime desc");
        int navigatePages=5;
        List<TAdmin> list= tAdminMapper.selectByExample(example);
        PageInfo<TAdmin> pageInfo=new PageInfo<>(list,navigatePages);
        return pageInfo;
    }

    @Override
    public void saveAdmin(TAdmin tAdmin) {
        tAdmin.setUserpswd(MD5Util.digest(Const.DEFALUT_PASSWORD));
        tAdmin.setCreatetime(DateUtil.getFormatTime());
        tAdminMapper.insertSelective(tAdmin);
    }

    @Override
    public TAdmin getAdminById(Integer id) {
        return tAdminMapper.selectByPrimaryKey(id);
    }

    @Override
    public void upadteAdmin(TAdmin tAdmin) {
        tAdminMapper.updateByPrimaryKeySelective(tAdmin);
    }

    @Override
    public void deleteAdminById(Integer id) {
        tAdminMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteBatchById(String s) {
        if(!StringUtils.isEmpty(s)){
            List<Integer> list=new ArrayList<>();
            String[] split = s.split(",");
            for (String s1 : split) {
                list.add(Integer.parseInt(s1));
            }
            TAdminExample example = new TAdminExample();
            example.createCriteria().andIdIn(list);

            tAdminMapper.deleteByExample(example);
        }
    }
}
