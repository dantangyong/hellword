<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ include file="/webpage/define/portal/cms/front/include/head.jsp"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>新信息</title>
    <!--4、引入两个兼容文件-->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
  <![endif]-->
    <!--6、引入 bootstrap.css-->
    <link rel="stylesheet" href="${ctxStatic }/portal/solrShow/css/bootstrap.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/solrShow/css/searchResult.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/solrShow/css/animate.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/css/bi_menu.css">
</head>
<body>
    <!--导航栏-->
    <nav class="navbar navbar-default navbar-fixed-top" id="nav">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#my-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="#" class="navbar-brand"><img src="${ctxStatic }/portal/solrShow/images/logo.png" alt=""></a>
        </div>
        <div id="my-collapse" class="collapse navbar-collapse">
            <!--中间导航-->
            <ul class="nav navbar-nav" id="nav-info">
                <li><a href="${ctx}/backHomePage"><img src="${ctxStatic }/portal/solrShow/images/index.png"> 首页</a></li>
                <li><a href="#" data-toggle="tab"><img src="${ctxStatic }/portal/solrShow/images/news.png"> 新闻中心</a></li>
                <li><a href="#" data-toggle="tab"><img src="${ctxStatic }/portal/solrShow/images/notice.png"> 通知公告</a></li>
                <li><a href="visitor.html"><img src="${ctxStatic }/portal/solrShow/images/file.png"> 服务大厅</a></li>
                <li><a href="#" data-toggle="tab"><img src="${ctxStatic }/portal/solrShow/images/video.png"> 视频中心</a></li>
            </ul>
            <ul class="nav navnar-nav navbar-right" id="login-head">
                <li class="pull-left"><a href="#"><img src="${ctxStatic }/portal/solrShow/images/calendar.png"> 04-12</a></li>
                <li class="pull-left"><a href="#"><img src="${ctxStatic }/portal/solrShow/images/weather.png"> 14℃~20℃</a></li>
                <li class="pull-left"><a href="#"><img src="${ctxStatic }/portal/solrShow/images/headLog.png"> 点击登录</a></li>
            </ul>
        </div>
    </div>
</nav>
<div>
<div class="nav-bak-inner col-sm-2">
	<c:forEach items="${bis }" var="bi">
		<div class="nav-item"><span class="nav-text">${bi.name }</span>
			<div class="nav-link">
				<c:forEach items="${bi.boards }" var="kid">
					<div class="nav-item-link">
						<div class="nav-bg-link"><span class="nav-text-link" onclick="board(${kid.boardId})">${kid.boardName }</span></div>
					</div>
				</c:forEach>
			</div>
		</div>		
	</c:forEach>
	<div class="nav-center"></div>
</div>
<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
	<div class="col-sm-8">
		<iframe id="myIframe" width="100%" height="100%" src=""></iframe>
	</div>
</div>
<script type="text/javascript">
function board(id){
	var id="http://120.26.49.110:8098/mht_bi/a/starter/#/mine/"+id;
	$("#myIframe").attr("src",id);
}


</script>
</body>
</html>
