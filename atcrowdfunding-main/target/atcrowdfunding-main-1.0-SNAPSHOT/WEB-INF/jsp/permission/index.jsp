<%--
  Created by IntelliJ IDEA.
  User: 11377
  Date: 2020/7/30
  Time: 7:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="GB18030">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@include file="/WEB-INF/common/css.jsp"%>

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/common/top.jsp"></jsp:include>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/common/menu.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 添加permission -->
<div class="modal fade" id="addPermission" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加</h4>
            </div>
            <div class="modal-body">
                <form id="addForm" role="form">
                    <div class="form-group">
                        <label>名称</label>
                        <input type="text" class="form-control"  name="name" placeholder="请输入权限名称">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="saveBtn" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>



<!-- 修改permission -->
<div class="modal fade" id="updatePermission" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">修改</h4>
            </div>
            <div class="modal-body">
                <form id="updateForm" role="form">
                    <div class="form-group">
                        <label>名称</label>
                        <input type="hidden" name="id">
                        <input type="text" class="form-control"  name="title" placeholder="请输入权限名称">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateBtn" type="button" class="btn btn-primary">修改</button>
            </div>
        </div>
    </div>
</div>


<%@include file="/WEB-INF/common/js.jsp"%>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
        showTree();
    });


    function showTree() {
        var setting = {
            data: {
                simpleData: {
                    enable: true,
                    pIdKey: "pid",
                },
                key:{
                    name: "title"
                }
            },
            view: {
                addDiyDom: customeIcon,//显示自定义图标
                addHoverDom: addHoverDom, //显示按钮
                removeHoverDom: removeHoverDom //移除按钮
            }
        };
        var zNodes =[];
        $.get("${PATH}/permission/loadTree",{},function(result) {
            zNodes=result;
            zNodes.push({"id":0,"title":"系统维护菜单","icon":"glyphicon glyphicon-th-list","children":[]});
            $.fn.zTree.init($("#treeDemo"), setting, zNodes);


            var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            treeObj.expandAll(true);
        });
    }

    function customeIcon(treeId,treeNode) {
        $("#"+treeNode.tId+"_ico").removeClass();//.addClass();
        $("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>")
    }

    function addHoverDom(treeId, treeNode){
        var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
        aObj.attr("href", "javascript:;");
        aObj.attr("onclick", "return false;");


        if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
        var s = '<span id="btnGroup'+treeNode.tId+'">';
        if ( treeNode.level == 0 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="addBtnClass fa fa-fw fa-plus rbg " permissionPid="'+treeNode.id+'"></i></a>';
        } else if ( treeNode.level == 1 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="updateBtnClass fa fa-fw fa-edit rbg "  permissionId="'+treeNode.id+'"></i></a>';
            if (treeNode.children.length == 0) {
                s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="deleteBtnClass fa fa-fw fa-times rbg " permissionTitle="'+treeNode.title+'" permissionId="'+treeNode.id+'"></i></a>';
            }
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="addBtnClass fa fa-fw fa-plus rbg "permissionPid="'+treeNode.id+'"></i></a>';
        } else if ( treeNode.level == 2 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="updateBtnClass fa fa-fw fa-edit rbg "permissionId="'+treeNode.id+'"></i></a>';
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#">&nbsp;&nbsp;<i class="deleteBtnClass fa fa-fw fa-times rbg " permissionTitle="'+treeNode.title+'"  permissionId="'+treeNode.id+'"></i></a>';
        }

        s += '</span>';
        aObj.after(s);
    }

    function removeHoverDom(treeId, treeNode){
        $("#btnGroup"+treeNode.tId).remove();
    }

   $(".panel-body").on("click",".addBtnClass",function() {
        $("#addPermission").modal({
            show:true,
            backdrop:"static",
            keyBoard:false
        });
    });
    $("#saveBtn").click(function() {
        let name = $("#addPermission input[name='name']").val();
        let id = $(".addBtnClass").attr("permissionPid");
        $.ajax({
            type: "POST",

            data: {
                title:name,
                pid:id,
                icon:"glyphicon glyphicon-ok"
            },
            url: "${PATH}/permission/doAdd",
            success: function (result) {
                $("#addPermission").modal("hide");
                if (result == "ok") {
                    $("#addPermission input[name='name']").val("");
                    layer.msg("添加成功");
                    showTree();
                } else {
                    layer.msg("添加失败");
                }
            }
        });
    });


    $(".panel-body").on("click",".deleteBtnClass",function() {
        let id = $(this).attr("permissionId");
        let title = $(this).attr("permissionTitle");
        layer.confirm("您确定要删除【"+title+"】吗？",[],
            function() {
                $.post("${PATH}/permission/deletePermissionById",{id:id},function (result) {
                    if (result == "ok") {
                        layer.msg("删除成功");
                        showTree();
                    } else {
                        layer.msg("删除失败");
                    }
                });
            },
            function() {});
    });

    $(".panel-body").on("click",".updateBtnClass",function() {
        let id = $(this).attr("permissionId");
        $.get("${PATH}/permission/getPermissionById",{id:id},function (result) {
            $("#updatePermission input[name='title']").val(result.title);
            $("#updatePermission input[name='id']").val(result.id);
            $("#updatePermission").modal({
                show:true,
                backdrop:"static",
                keyBoard:false
            });
        });
    });

    $("#updateBtn").click(function () {
        let title = $("#updatePermission input[name='title']").val();
        let id = $("#updatePermission input[name='id']").val();
        $.post("${PATH}/permission/doUpdate",{id:id,title:title},function (result) {
            $("#updatePermission").modal("hide");
            if (result == "ok") {
                $("#updatePermission input[name='title']").val("");
                layer.msg("修改成功");
                showTree();
            } else {
                layer.msg("修改失败");
            }
        });
    });
</script>
</body>
</html>