<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<nav class="navbar navbar-default" id="nav">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#my-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="#" class="navbar-brand"><img src="${ctxStatic }/user/images/schoolLogo.png"></a>
        </div>
        <div id="my-collapse" class="collapse navbar-collapse">
            <!--中间导航-->
            <ul class="nav navbar-nav" id="nav-info">
                <li><a href="${ctx}/backHomePage">首页</a></li>
                <li><a href="${ctx}/cms/newsCenter">新闻中心</a></li>
                <li><a href="${ctx}/cms/notice/notice?pageCode=">通知公告</a></li>
                <li><a href="/mht_service/f/service/serviceManage">服务大厅</a></li>
                <li><a href="${ctxFront }/cms/video">视频中心</a></li>
                <li><a href="${ctx }/cms/usercenter">个人中心</a></li>
            </ul>
            <ul class="nav navnar-nav navbar-right" id="login-head">
                <li class="pull-left"><a href="#"><img src="${ctxStatic }/portal/images/calendar.png">&ensp;<span id="time"></span></a></li>
                <li class="pull-left"><a href="#"><img src="${ctxStatic }/portal/images/weather.png">&ensp;<span id="weather"></span></a></li>
                <li class="pull-left">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <img src="${fns:getUserImage(ctxStatic)}" class="user-head avatar" style="width: 35px;border-radius: 50%;"> ${fns:getUser().name }
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
                </li>
            </ul>
        </div>
    </div>
</nav>
<script src="${ctxStatic }/portal/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
// 天气、日期接口 使用的免费天气接口，每小时只能访问500次
$.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js',function(){  
  //alert(remote_ip_info.country);//国家  
  //alert(remote_ip_info.province);//省份  
  //alert(remote_ip_info.city);//城市  
  $.ajax({
    url:'http://api.k780.com:88/?app=weather.today&weaid='+remote_ip_info.city+'&&appkey=27936&sign='
        +'f223782cff2126305a33f893065e820a&format=json&jsoncallback=?',
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

</script>
