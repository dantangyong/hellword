<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<style>
    .nav-guide li a:hover{
    color:#238be9;
}
.nav-guide li.active a{
 color:#238be9;
}
</style>
<div class="container-fluid " style="padding-left:0;padding-right:0">
    
    <div class="wrap-user-head">
    <img src="${ctxStatic }/user/images/userCenterBack2.png" style="width: 100%;height: 100%;position: relative;top: 0"/>
        <div class="show-user-info text-center">
            <div class="head-logo">
                <img src="${fns:getUserImage(ctxStatic)}" class="img-circle avatar modify-avatar" title="修改头像">
            </div>
            <ul>
                <li>
                   ${fns:getUser().name }
                </li>
                <li>学号/教工号：<span>${fns:getUser().no }</span></li>
            </ul>
        </div>
    </div>
</div>
<div class="container-fluid" style="padding:0;">
    <ul class="nav nav-guide" style="border-bottom:1px solid #eeeeee;">
        <li class="active user-menu" name="userCenter"><a href="javascript:void(0);" url="">个人中心</a></li>
        <li class="user-menu" name="importantRemind"><a href="javascript:void(0);" url="../../pluginpage/mymessage/index.html">重要提醒</a></li>
        <li class="user-menu" name="myApplication"><a href="javascript:void(0);" url="../../pluginpage/myapplication/index.html">我的申请</a></li>
        <li class="user-menu" name="myToDo"><a href="javascript:void(0);" url="../../pluginpage/mytodo/index.html">我的待办</a></li>
        <li class="user-menu" name="myCollection"><a href="javascript:void(0);" url="../../pluginpage/mycollection/index.html">我的收藏</a></li>
    </ul>
</div>
<!--修改密码-->
<div class="modal fade" id="show-avatar">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h5 class="modal-title">修改头像</h5>
            </div>
            <div class="modal-body" style="padding: 0px 0;">
                <!-- <a href="#">
                    <span class="glyphicon glyphicon-plus"></span>
                    <input type="file" id="select-skin">
                </a>
                <div class="preview-img">
                    <img src="">
                </div> -->
                <iframe src="${ctx}/sys/user/imageEdit" style="width: 100%;height: 500px;"></iframe>
            </div>
            <div class="modal-footer text-center">
                <!-- <button type="button" class="confirm">确认</button> -->
                <button type="button" class="cancel" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
