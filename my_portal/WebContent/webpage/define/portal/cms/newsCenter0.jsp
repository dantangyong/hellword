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
    <title>新闻中心</title>
    <!--4、引入两个兼容文件-->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <!--6、引入 bootstrap.css-->
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/bootstrap.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/newsCenter.css">
</head>
<body>
	<!--导航栏-->
	<%@ include file="/webpage/define/portal/cms/front/include/navigation.jsp"%>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 header-title">
                <h4 class="text-center"><span></span> CHANNEL <span></span></h4>
                <h6 class="text-center">热门频道</h6>
            </div>
            <div class="col-xs-12">
                <div id="car1" class="carousel slide banner" data-ride="carousel" data-interval="10000000">
                    <!--轮播区域-->
                    <div class="carousel-inner" style="background:url(${ctxStatic }/portal/images/back-banner.png)  0 0 no-repeat;background-size:cover;">
                        <!--具体轮播项-->
                        <div class="item active">
                            <div class="wrap-channel">
                             <c:forEach items="${firstHotChannel}" var="list">
                             <a onclick="news_channel('${list.name}')">
                                <img src="${ctxStatic }${list.image}" alt="">
                                <br>
                                <span>${list.name }</span>
                             </a>
                             </c:forEach>
                            </div>
                        </div>
                        <div class="item">
                        <div class="wrap-channel" id="secondHotChannel">
                        
                        </div>
                        </div>
                    </div>
                    <!-- 增加导航圆点 -->
                    <ul class="carousel-indicators">
                        <li class="active" data-target="#car1" data-slide-to="0"></li>
                        <li data-target="#car1" data-slide-to="1" onclick="changePage()"></li>
                    </ul>
                </div>
            </div>
            <div class="col-xs-12">
                <h4 class="first-news">头条新闻/news</h4>
            </div>
            <div class="col-xs-12">
            <c:forEach items="${requestScope.hotNews}" var="list" begin="0" end="2">
            <div class="wrap-news">
                    <div class="date">
                        <h3 class="day text-center">
                        <fmt:formatDate value="${requestScope.nowDate}" pattern="dd"/>
                        </h3>
                        <p class="divider"></p>
                        <h4 class="date-detail text-center">
                        <fmt:formatDate value="${requestScope.nowDate}" pattern="yyyy/MM"/>
                        </h4>
                    </div>
                    <div class="news-content">
                        <h5>
                            <a href="${ctx}/cms/solr/newsDetailJsp?name=${list.id}">${list.article.title }</a>
                        </h5>
                        <p>
                        ${list.article.description }
                        </p>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
    </div>
<!--5、引入 jquery，bootstrap js-->
<script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
<script src="${ctxStatic }/portal/notice/js/bootstrap.js"></script>
<script>
function changePage(){
	$.ajax({
		type:"POST",
		url:"${ctx}/cms/secondHotChannel",
		success:function(date){
			$("#secondHotChannel").empty();
			$("#secondHotChannel").html(date);
			}
		});
}
function news_channel(name){
	window.location.href="${ctx}/cms/solr/newsChannel?name="+name+"&pageCode=";
}

function news_headNews(type){
	alert(type);
	data : {
	   solr : type;
	}
	window.location.href="${ctx}/cms/solr/news_headNews";
}

</script>
</body>
</html>