<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head lang="zh-cn">
    <meta charset="UTF-8">
    <!--2 viewport-->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <!--3、x-ua-compatible-->
    <meta http-equiv="x-ua-compatible" content="IE=edge">
    <title>新闻详情页</title>
    <!--4、引入两个兼容文件-->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <!--6、引入 bootstrap.css-->
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/bootstrap.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/newsDetail.css">
</head>
<body>
<!--导航栏-->
<%@ include file="/webpage/define/portal/cms/front/include/navigation.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <ul class="breadcrumb" id="bread">
                <li><a href="${ctx}/cms/newsCenter">新闻中心</a></li>
                <li><a href="${ctx}/cms/solr/newsChannel?name=${requestScope.channel}&pageCode=">${requestScope.channel}</a></li>
                <li>详情</li>
            </ul>
        </div>
        <div class="col-xs-12">
            <ul class="nav nav-pills" id="channel-nav">
                <!-- <li class="active"><a href="teach.html">教育频道</a></li>
                <li><a href="social.html">社工频道</a></li>
                <li><a href="fireFighting.html">消防频道</a></li>
                <li><a href="logistics.html">后勤频道</a></li>
                <li><a href="political.html">政治频道</a></li> -->
                <jsp:include page="newsChannel.jsp"></jsp:include> 
            </ul>
            
            <!-- ------------------------------------------------------ -->
            <c:forEach items="${list03}" var="document">
			
            <div class="wrap-detail-content">
                <h3 class="text-center title-header">
                ${document["article"].title}
                         </h3>
                 <p class="text-right pub-time"><span>教务处</span>
                 <fmt:formatDate value="${document['article'].updateDate}" pattern="yyyy-MM-dd HH:mm"/>
<%--                 ${document["article"].updateDate} --%>
                </p>
                <p class="line-style">
                ${document.content}    
                </p>
                
            </div>
            </c:forEach> 
            <!-- ------------------------------------------------------ -->
            
        </div>
    </div>
</div>

<!--5、引入 jquery，bootstrap js-->
<script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
<script src="${ctxStatic }/portal/notice/js/bootstrap.js"></script>
<script>
</script>
</body>
</html>