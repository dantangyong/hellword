	<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/webpage/include/taglib.jsp"%>

<ul class="nav navbar-nav" id="nav-info">
                <li><a href="${ctx}/backHomePage"><img src="${ctxStatic }/portal/notice/images/index.png"> 首页</a></li>
                <li class="active"><a href="javaScript:" onclick="news()"><img src="${ctxStatic }/portal/notice/images/news.png"> 新闻中心</a></li>
                <li><a href="javaScript:" onclick="notice()"><img src="${ctxStatic }/portal/notice/images/notice.png" alt=""> 通知公告</a></li>
                <li><a href="infoVisitor.html"><img src="${ctxStatic }/portal/notice/images/file.png" alt=""> 服务大厅</a></li>
                <li><a href="javaScript:" onclick="video()"><img src="${ctxStatic }/portal/notice/images/video.png" alt=""> 视频中心</a></li>
                <li><a href="javaScript:" onclick="infoUsercenter()"><img src="${ctxStatic }/portal/notice/images/usercenter2.png"> 个人中心</a></li>
</ul>

<script>

function news(){
	window.location.href="${ctx}/cms/newsCenter";
}

function notice(){
	window.location.href="${ctx}/cms/notice/notice";
}

function video(){
	window.location.href="${ctx}/cms/solr/videoee";
}

function infoUsercenter(){
	window.location.href="${ctx}/cms/solr/infoUsercenter";
}
</script>