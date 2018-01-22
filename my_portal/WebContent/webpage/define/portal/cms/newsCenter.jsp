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
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/commonChannel.min.css">
	<link rel="stylesheet" href="${ctxStatic }/portal/notice/css/commonHeader.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/newsCenter.min.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/newsDetail.min.css">
    <script src="${ctxStatic }/portal/notice/js/jquery.min.js"></script>
    <style type="text/css">
    .footer{
       display:block !important;
       position: absolute;
       bottom: 0;
    }
    </style>
</head>
<body>
<%@ include file="/webpage/define/portal/cms/front/include/commonHeader.jsp"%>
<!-- 头部菜单选中帮助隐藏域 -->
<input type="hidden" value="new-center" id="new-center-helper" />
<div class="container" id="channel-nav" style="margin-top:50px">
		<ul class="nav channel-nav">
		    <li class="active"><a href="${ctx }/cms/newsCenter">热门频道</a></li>
		    <c:forEach items="${firstHotChannel}" var="list" varStatus="state">
		    	
		    		<li><a onclick="news_channel('${list.name}')">
		                                <span>${list.name }</span>
		                             </a>
		                             </li>
		    	
		                             </c:forEach>
		</ul>
</div>
<div class="container" id = "secondHotChannel">
      <!-- 嵌入页面 -->
</div>

<script src="${ctxStatic }/portal/notice/js/bootstrap.js"></script>
<script>
    $(function () {
    	$.ajax({
    		type:"POST",
    		url:"${ctx}/cms/hotChannelRequest",
    		success:function(date){
    			$("#secondHotChannel").empty();
    			$("#secondHotChannel").html(date);
    			}
    		});
    })
    function news_channel(name){
    	//切换新闻栏目,去掉页脚固定到页面底部属性
    	$("#footer").removeClass("footer");
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
    	$("#channel-nav").on('click','li',function(){
    		$(this).addClass('active').siblings().removeClass('active');
    		
    	})
    	
}
    
    /*导航菜单高亮 */
    $(document).ready(function(){
    	$("#news-highlight").css({"background":"#64b8fd"});
    });
 </script>
<script src="${ctxStatic }/portal/notice/js/bootstrap.min.js"></script>
 <!-- footer -->
<%@ include file="/webpage/define/portal/cms/front/include/footer.jsp"%>
</body>
</html>