<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ include file="/webpage/define/portal/cms/front/include/modifyPassword.jsp"%>
<style>
#nav-info li a:hover {
   background: #64b8fd;
}
 .pull-left a img{
    width:18px;
    height:18px;
    }
</style>
<nav class="navbar navbar-default navbar-fixed-top" id="nav">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#my-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
<%--             <a href="#" class="navbar-brand"><img src="${fns:getTagManage().logoUrl}" alt="西南交通大学"></a> --%>
            <a href="#" class="navbar-brand"><img src="${ctxStatic }/portal/images/logo.png" alt="西南交通大学"></a>
        </div>
        <div id="my-collapse" class="collapse navbar-collapse">
            <!--中间导航-->
            <ul class="nav navbar-nav" id="nav-info">
                <li><a href="${ctx}/backHomePage">首页</a></li>
                <li id="news-highlight"><a href="${ctx}/cms/newsCenter" >新闻中心</a></li>
                <li id="notice-highlight"><a href="${ctx}/cms/notice/notice?pageCode=" >通知公告</a></li>
                <li ><a href="javascript:void(0);" onclick="record('服务大厅')">服务大厅</a></li>
                <li id="video-highlight"><a href="${ctxFront }/cms/video" >视频中心</a></li>
                <li id="personal-highlight"><a href="${ctx }/cms/usercenter" >个人中心</a></li>
            </ul>
            <ul class="nav navnar-nav navbar-right" id="login-head">
                <li class="pull-left"><a href="#"><img src="${ctxStatic }/portal/images/calendar.png">&ensp;<span id="time"></span></a></li>
                <li class="pull-left"><a href="#"><img src="${ctxStatic }/portal/images/weather.png">&ensp;<span id="weather"></span></a></li>
                <li class="pull-left">
                
                    <c:if test="${empty fns:getUser().name }">
						  <a href="${ctx}/" class="modify-password">登录</a>
				    </c:if>
				    
                    <c:if test="${!empty fns:getUser().name }">
                    
	                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                        <img src="${fns:getUserImage(ctxStatic)}" class="user-head avatar" style="width: 25px;height:25px;border-radius: 50%;"> ${fns:getUser().name }
	                    </a>
                    		<ul class="dropdown-menu">
		                        <li>
		                            <a href="#" class="modify-password">
		                                <span class="glyphicon glyphicon-lock"></span> 修改密码
		                            </a>
		                        </li>
	                        
		                        <li>
		                            <a href="${ctx}/logout">
		                                <span class="glyphicon glyphicon-remove"></span> 安全退出
		                            </a>
		                        </li>
                   		 </ul>
                    </c:if>
                </li>
            </ul>
        </div>
    </div>
</nav>
<script src="${ctxStatic }/user/js/judgeBrowser.js"></script>
<script type="text/javascript">
// 天气、日期接口 使用的免费天气接口，每小时只能访问500次
$.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js',function(){  
  //alert(remote_ip_info.country);//国家  
  //alert(remote_ip_info.province);//省份  
  //alert(remote_ip_info.city);//城市  
  $.ajax({
   	url:'http://api.k780.com:88/?app=weather.today&weaid='+remote_ip_info.city+'&&appkey=27936&sign='
   		+'f223782cff2126305a33f893065e820a&format=json&jsoncallback=?',
// 	url:'http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theCityCode='+remote_ip_info.city+'&theUserID=',	
    type: "get",
    dataType:"jsonp",
    jsonp:"callback",
    jsonpCallback:"success_jsonpCallback",
    success:function(data){
        $("#time").html(data.result.days.slice(5,10));
        $("#weather").html(remote_ip_info.city+data.result.temperature_curr);
    }
})
});  

/* 记录访问服务大厅 */
function record(appName){
	   $.ajax({
			type : "post",
			url : "${ctx}/portalapp/blocksvisit/record",
			data : {appName : appName}, 
			success : function(data) {
				window.open("/mht_service/a/service/serviceFrontManage");
			}
		});
}
 
</script>
