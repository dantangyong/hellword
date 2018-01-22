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
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/newsCenter.min.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/commonChannel.min.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/newsDetail.min.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/commonHeader.css">
    <script src="${ctxStatic }/portal/notice/js/jquery.min.js"></script>
</head>
<body>
<!--     <div id="header"> -->
<%--     <%@ include file="/webpage/define/portal/cms/front/include/navigation.jsp"%> --%>
<!--     </div> -->
<%@ include file="/webpage/define/portal/cms/front/include/commonHeader.jsp"%>
    <div class="container" id="channel-nav">
<ul class="nav channel-nav">
    <li class="active"><a href="${ctx }/cms/newsCenter">热门频道</a></li>
    <c:forEach items="${firstHotChannel}" var="list">
                             <li><a onclick="news_channel('${list.name}')">
                                <span>${list.name }</span>
                             </a></li>
                             </c:forEach>
</ul>
    </div>
    <div class="container" id = "secondHotChannel">
          <div class="row">
            <div class="col-xs-12">
            	 <c:forEach items="${list03}" var="document">
                <div class="wrap-detail-content">
                    <h3 class="text-center title-header">${document["article"].title}</h3>
                    <p class="text-right pub-time"><span>${document.copyfrom}</span><fmt:formatDate value="${document['article'].updateDate}" pattern="yyyy-MM-dd HH:mm"/></p>
                    <%-- <p class="line-style">
                     ${document.article.description}
                    </p> --%>
                    <p class="line-style">
                         ${document.content} 
                    </p>
                </div>
                </c:forEach>
            </div>
        </div>
        </div>
<!-- <script src="js/jquery.min.js"></script> -->
<!-- <script src="js/bootstrap.min.js"></script> -->
<script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
<script src="${ctxStatic }/portal/notice/js/bootstrap.js"></script>
<script>
/*导航菜单高亮 */
$(document).ready(function(){
	$("#news-highlight").css({"background":"#64b8fd"});
})

$("#channel-nav").on('click','li',function(){
    		$(this).addClass('active').siblings().removeClass('active');
    	})
    function news_channel(name){
    	$.ajax({
    		type:"POST",
    		url:"${ctx}/cms/solr/otherChannel",
    		data:{
    			name:name
    			},
    		success:function(date){
    			$("#secondHotChannel").empty();
    			$("#secondHotChannel").html(date);
    			}
    		});
}
</script>

<script src="${ctxStatic }/portal/notice/js/bootstrap.min.js"></script>
</body>
</html>