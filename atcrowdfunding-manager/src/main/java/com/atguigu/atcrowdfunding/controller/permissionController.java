package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class permissionController {
    @Autowired
    private PermissionService permissionService;

    @RequestMapping("/permission/index")
    public String index() {
        return "permission/index";
    }

    @ResponseBody
    @RequestMapping("permission/loadTree")
    public List<TPermission> loadTree() {
        return permissionService.getAllPermission();
    }

    @ResponseBody
    @RequestMapping("/permission/doAdd")
    public String doAdd(TPermission tPermission) {
        permissionService.savePermission(tPermission);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/permission/deletePermissionById")
    public String deletePermissionById(Integer id) {
        permissionService.deletePermission(id);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/permission/getPermissionById")
    public TPermission getPermissionById(Integer id) {
        return permissionService.changePermission(id);
    }

    @ResponseBody
    @RequestMapping("permission/doUpdate")
    public String doUpdate(TPermission tPermission){
        permissionService.updatePermission(tPermission);
        return "ok";
    }
}
