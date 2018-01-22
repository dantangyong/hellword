<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head lang="zh-cn">
<meta charset="UTF-8">
<!--2 viewport-->
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<!--3、x-ua-compatible-->
<meta http-equiv="x-ua-compatible" content="IE=edge">
<title>首页</title>
<!--4、引入两个兼容文件-->
<!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
  <![endif]-->
<!--6、引入 相关css-->
<link rel="stylesheet" href="${ctxStatic }/portal/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctxStatic }/portal/css/index.min.css">
<link rel="stylesheet" href="${ctxStatic }/portal/css/popup.min.css">
<link rel="stylesheet" href="${ctxStatic }/portal/css/animate.min.css">
<link rel="stylesheet" href="${ctxStatic }/portal/jrange/jquery.range.css">
 <script src="${ctxStatic }/portal/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
    $(function(){
       $.ajax({
            url:"${ctx}/backHomePage/cas",
            type:"POST",
            success:function(data){
            // alert(111111111);
            }
        })
    })
    
</script>
<style>
.span_tips {
    width: 160px;
    height: 30px;
    position: absolute;
    left: 72%;
    top: 30%;
    color:gray
}

 .slider-container{
     width: 100px;
    display: inline-block;
    margin-top: 18px;
 }
</style>

<!-- 右侧插件 -->
</head>
<body class="popup-container">

    <div class="img-flex"></div>
    <!--导航栏-->
    <nav class="navbar navbar-default navbar-fixed-top" id="nav">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed"
                    data-toggle="collapse" data-target="#my-collapse">
                    <span class="icon-bar"></span> <span class="icon-bar"></span> <span
                        class="icon-bar"></span>
                </button>
            </div>
            <div id="my-collapse" class="collapse navbar-collapse">
                <!--左边导航-->
                <input type="hidden" id="skinId">
                <ul class="nav navnar-nav navbar-left" id="login-head">
                    <li class="pull-left"><a href="#"><img src="${ctxStatic }/portal/images/calendar.png">&emsp;
                        <span id="time"></span></a></li>
                    <li class="pull-left"><a href="#"><img src="${ctxStatic }/portal/images/weather.png">&emsp;
                        <span id="weather"></span></a></li>
                       <c:if test="${!empty fns:getUser().name }">
                          <li class="pull-left"><a href="#" class="change-skin"><img
                                src="${ctxStatic }/portal/images/skin.png" style="margin-right:15px;margin-top: -3px;"> 换肤</a></li>
                      </c:if>
                </ul>
                <ul class="nav navbar-nav navbar-right" id="nav-info">
                    <li>
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                             ${empty fns:getUser().name ? '登录' : fns:getUser().name}
                        </a>
                        <ul class="dropdown-menu">

                            <li>
                                <a href="${ctx}/self/logout">
                                    <span class="glyphicon glyphicon-remove"> </span> 安全退出
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li id="divider"></li>
                     <c:if test="${not empty fns:getUser().name}">
                           <li class="PR">
                        <a href="#" class="myApplication">我的应用</a>
                        <ul class="appContainer">
                            <li class="dataContainer"></li>
                        </ul>
                    </li>
                        </c:if>
                   
                    <li><a href="${ctx }/cms/usercenter">个人中心</a></li>
                       <!-- <li><a href="javascript:void(0);" onclick="window.open('/mht_service/f/service/serviceManage')" target="_blank">服务大厅</a></li>-->
                    <li><a href="javascript:void(0);"  onclick="record('服务大厅')">服务大厅</a></li>
                    <li><a href="${ctx }/cms/newsCenter">新闻中心</a></li>
                    <li><a href="#" class="hover-show"><img
                            src="${ctxStatic }/portal/images/more.png"></a></li>
                </ul>
            </div>
        </div>
    </nav>
    <!--换肤栏-->
    <div id="wrap-skin">
        <div class="container" id="show-skin">
            <div class="row">
                <div class="col-xs-12">
                   <%--                     <input type="hidden" id="roleType" value="${fns:getUser().getRoleType() }"> --%>
                     <input type="hidden" id="userId" value="${fns:getUser().id }">
                    <input type="hidden" id="userName" value="${fns:getUser().name }">
                    <ul class="nav nav-pills">
                        <li class="active"><a href="#recommend" data-toggle="tab">推荐背景</a></li>
                     
                        <li><a href="#user-defined" data-toggle="tab">自定义背景</a></li>
                        
                        <li>
<!--  	                         <input type="range" min="0" max="100" value="0" step="1" id="range">  -->
                               <input type="hidden" class="slider-input" value="${ roleSkin.num}" id="range"/> 
	                         <span id="opacity">透明度:</span>
                         </li>
                        <li><a href="#" class="no-skin">&times; 不使用皮肤</a></li>
                        <li><a href="#" class="skin-up"><img
                                src="${ctxStatic }/portal/images/skin-up.png">收起</a></li>
                    </ul>
                    <div class="row">
                        <div class="col-xs-12 tab-content" id="all-skin">
                            <div id="recommend" class="tab-pane active">
                                <div id="car1" class="carousel banner">
                                    <!--轮播区域-->
                                    <div class="carousel-inner">
                                        <!--具体轮播项-->
                                        <div class="item active">
                                            <!--注意！！！一页最多放5张图片 一页最多放5张图片一页最多放5张图片！！！！重要的事情说三遍-->
                                            <a href="#"><img
                                                src="${ctxStatic }/portal/images/back_img_one.png" /></a> <a
                                                href="#"><img
                                                src="${ctxStatic }/portal/images/back_img_two.png" /></a> <a
                                                href="#"><img
                                                src="${ctxStatic }/portal/images/back_img_three.png" /></a> <a
                                                href="#"><img
                                                src="${ctxStatic }/portal/images/back_img_four.png" /></a> <a
                                                href="#"><img
                                                src="${ctxStatic }/portal/images/back_img_five.png" /></a>
                                        </div>
                                        <div class="item">
                                            <!--注意！！！一页最多放5张图片 一页最多放5张图片一页最多放5张图片！！！！重要的事情说三遍-->
                                            <a href="#"><img
                                                src="${ctxStatic }/portal/images/back_img_six.png" /></a> <a
                                                href="#"><img
                                                src="${ctxStatic }/portal/images/back_img_seven.png" /></a> <a
                                                href="#"><img
                                                src="${ctxStatic }/portal/images/back_img_eight.png" /></a> <a
                                                href="#"><img
                                                src="${ctxStatic }/portal/images/back_img_night.png" /></a> <a
                                                href="#"><img
                                                src="${ctxStatic }/portal/images/back_img_ten.png" /></a>
                                        </div>
                                    </div>
                                    <!-- 增加导航圆点 -->
                                    <ul class="carousel-indicators">
                                        <li class="active" data-target="#car1" data-slide-to="0"></li>
                                        <li data-target="#car1" data-slide-to="1"></li>
                                    </ul>
                                </div>
                            </div>
                            <div id="user-defined" class="tab-pane">
                                <a href="javascript:void(0);" class="file" >选择文件 <input
                                    type="file" name="file" id="file">
                                </a>
                                <div class="preview-skin" id="preview-skin-box">
                                    <img src="" id="preview-skin">
                                </div>
                                <span class="span_tips">请上传小于5M的图片</span>
                                <button type="button" id="selfSkin">保存</button>
                                <button id="cancel" type="button">取消</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--右上角隐藏导航-->
    <ul class="hover-window navbar-nav navbar-right" id="navUl" style="padding-top: 30px;"> </ul>
    <!--中间搜索部分-->
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <div class="wrap-box wow rotateIn" data-wow-delay="2s"
                    data-wow-duration=".5s">
                    <div class="wrap-img wow rollIn" data-wow-duration=".8s"
                        data-wow-delay="2s">
                        <h1>
<%--                             <img src="${fns:getTagManage().logoUrl}" alt="西南交通大学"> --%>
 						<img src="${ctxStatic }/portal/images/logo.png" alt="西南交通大学">
                        </h1>
                    </div>
                    <div class="search wow rotateInDownRight" data-wow-duration=".8s"
                        data-wow-delay="3.5s">
                        <!--                         <input type="text">
                        <button type="button">搜索</button> -->
                        <form:form action="${ctx}/cms/solr/search" method="get" onsubmit="return check()">
                            <input type="text" name="search" id="solr">
                             <input type="hidden" name="service" id="service">
                            <button type="submit">搜索</button>
                        </form:form>
                    </div>
                    <div class="hot-words wow zoomInRight" data-wow-duration=".8s"
                        data-wow-delay="3s">
                        <ul class="service-right">
                        </ul>
                    </div>
                    <div class="services wow zoomInRight" data-wow-duration=".8s"
                        data-wow-delay="3s">
                        <ul>
                                <li><a href="javascript:void(0);"  onclick="record('服务大厅')"
                                    style="display: inline-block;"> <img
                                        src="${ctxStatic }/portal/images/system.png" alt=""> <br>
                                    <span>服务大厅</span>
                                </a></li>
                                <li><a href="${ctx }/cms/usercenter" style="display: inline-block;"> <img
                                        src="${ctxStatic }/portal/images/personal.png" alt=""> <br>个人中心
                                </a></li>
                                <li><a style="display: inline-block;"
                                    href="${ctx}/cms/notice/notice?pageCode="> <img
                                        src="${ctxStatic }/portal/images/noticeIcon.png" alt="">
                                        <br>通知公告
                                </a></li>
                                <li><a style="display: inline-block;"
                                    href="${ctx }/cms/newsCenter"> <img
                                        src="${ctxStatic }/portal/images/news.png" alt=""> <br>新闻中心
                                </a></li>
      
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="container" id="footer">
        <div class="wow rollIn" data-wow-duration=".8s" data-wow-delay="3.5s">
            
            <p>版权所有 ©2016 西南科技大学   |   地址：四川省绵阳市涪城区青龙大道中段59号   |   邮编:621010   |   蜀ICP备13012090号</p>
        </div>
    </footer>
    <!--5、引入  jquery，bootstrap js-->
    <script src="${ctxStatic}/common/ajaxfileupload.js"></script>
    <script src="${ctxStatic}/js/judgeBrowser.js"></script>
    <%@ include file="/webpage/define/portal/cms/front/include/modifyPassword.jsp"%>
    <%-- <script src="${ctxStatic }/portal/js/wow.min.js"></script> --%>
    <script src="${ctxStatic }/portal/js/fragment.js"></script>
    <script src="${ctxStatic }/portal/js/bootstrap.min.js"></script>
    <script src="${ctxStatic }/portal/js/index.js"></script>
    <script src="${ctxStatic }/portal/jrange/jquery.range.js"></script>
    <script type="text/javascript">
    /*换肤全局变量*/
    var skinUrl = "";
    var fragmentConfig = {};
    
    $(document).ready(function(){
    	notLoginbackground();
    	loginedBackground();
        myApps();
        hotSearch();
        rightHiddenApps();
        initJrange();
        weather();
        
    });
       
    $('.dataContainer').on('click','a',function(){
    	// debugger;
        var targetUrl=$(this).attr('data-url');
        $(this).attr('href',targetUrl);
    });
     
    /* 未登录首页默认背景   */
      function notLoginbackground(){
    	  if(!userName.value){
              $(".img-flex").hide();
              var portalS=1;
              $('body').css({
                  'background-image':'url(../static/portal/images/back_img_four.png)',
                  'background-position':'center',
                  'background-attachment':'fixed',
                  'background-size':'cover',
                  'background-repeat':'no-repeat'
              });
              document.cookie="userId_partal=1"; 
              $(".dropdown-toggle").attr("data-toggle","");
              $(".dropdown-toggle").attr("href","${ctx}/backHomePage/cas");
          }
    	  
      }
      /* 登录用户首页背景   */
    function loginedBackground(){
    	 //    图片动态
        if(userName.value){
            $.ajax({
                url : '${ctx}/skin',
                type : "get",
                data : {
                	roleId : $("#userId").val()
                },
                success : function(data) {
                	if(null==data.body.skin){
                		 $(".img-flex").hide();
                         $('body').css({
                             'background-image':'url(${ctxStatic}/portal/images/back_img_four.png)',
                             'background-position':'center',
                             'background-attachment':'fixed',
                             'background-size':'cover',
                             'background-repeat':'no-repeat'
                         });
                		return ;
                	}
                	console.log("data:"+(data.body.skin));
                    var skin = data.body.skin;
                    var num = data.body.skin.num;
                    $("#skinId").val(skin.id);
                    $("#opacity").html('透明度:' + num + '%');
                    $("#range").val(num);
                    $('.slider-input').jRange('setValue', $("#range").val());
                    $(".wrap-box").css("background",
                            "rgba(0,0,0," + num / 100 + ")");
                    skinUrl = skin.imageUrl;
                    if(skinUrl==null ||skinUrl==''){
                    	console.log("skinUrl:"+skinUrl);
                    	skinUrl = "../static/portal/images/back_img_four.png";
                    	console.log("skinUrl:"+skinUrl);
                    }
                    var value = sessionStorage.getItem("flag");
                    if (skinUrl.indexOf('back_img_default.png') !== -1) {
                        $('body').css({
                            'background-image':'url('+skinUrl+')',
                            'background-position':'center',
                            'background-attachment':'fixed',
                            'background-size':'cover',
                            'background-repeat':'no-repeat'
                        });
//                         fragmentConfig = {
//                             container : '.img-flex',//显示容器
//                             line : 10,//多少行
//                             column : 24,//多少列
//                             width : 1920,//显示容器的宽度
//                             animeTime : 0,//最长动画时间,图片的取值将在 animeTime*0.33 + animeTime*0.66之前取值
//                             img : skinUrl
//                         //图片路径    
//                         };
//                         fragmentImg(fragmentConfig);
                    } else {
                        if (!value) {
                            $('body').css({
                                'background-image':'url('+skinUrl+')',
                                'background-position':'center',
                                'background-attachment':'fixed',
                                'background-size':'cover',
                                'background-repeat':'no-repeat'
                            });
//                             fragmentConfig = {
//                                 container : '.img-flex',//显示容器
//                                 line : 10,//多少行
//                                 column : 24,//多少列
//                                 width : 1920,//显示容器的宽度
//                                 animeTime : 2000,//最长动画时间,图片的取值将在 animeTime*0.33 + animeTime*0.66之前取值
//                                 img : skinUrl
//                             //图片路径    
//                             };
//                             fragmentImg(fragmentConfig);
                            sessionStorage.setItem("flag", true);
                        } else {
                            $("body div").removeClass("wow");
                            $('body').css({
                                'background-image':'url('+skinUrl+')',
                                'background-position':'center',
                                'background-attachment':'fixed',
                                'background-size':'cover',
                                'background-repeat':'no-repeat'
                            });
//                             fragmentConfig = {
//                                 container : '.img-flex',//显示容器
//                                 line : 10,//多少行
//                                 column : 24,//多少列
//                                 width : 1920,//显示容器的宽度
//                                 animeTime : 0,//最长动画时间,图片的取值将在 animeTime*0.33 + animeTime*0.66之前取值
//                                 img : skinUrl
//                             //图片路径    
//                             };
//                             fragmentImg(fragmentConfig);
                        }
                    }
                }
            })
        }
    }
      /* 热门搜索 推荐 */
      function hotSearch(){
    	  $.ajax({
              url : "${ctx}/cms/solr/hotName",
              type : "GET",
              success : function(data) {
                  $(".service-right").empty;
                  var compos = data.body.composes;
                  for (var i = 0; i < 8; i++) {
                      var url = compos[i].name == null ? "" : compos[i].name;
                      $(".service-right").prepend(
                              "<li><a id=li"+compos[i].id+" >"
                                      + compos[i].name + "</a></li>");
                      $("#li" + compos[i].id).attr("href", "#");
                      $("#li" + compos[i].id).attr(
                              "onclick",
                              "myAjax('" + compos[i].name + "','"
                                      + compos[i].service + "')");
                      /* $(".service-right").prepend("<a href='"+url+"'><div ><p><img src='"+src+"' style='width: 50px;height: 50px;'></p>
                      <p>"+compos[i].composingName+"</p></div></a>"); */
                  }
                  $(".service-right").prepend("<li>热门搜索</li>");
              }
          })
    	  
      }
      /* 右边隐藏版块*/
      function rightHiddenApps(){
    	  $.ajax({
              url:"${ctx}/portal/frontApp/showApps",
              type:"POST",
              success:function(data){
                  var app = data.body.apps;
                  for(var i=0; i<app.length; i++){
                	  if(app[i].appName !='服务大厅'){
                		  $("#navUl").append(
                                  "<li><a href='"+app[i].appUrl+"' target='_blank'>"
                                  +"<img src='"+app[i].appImg+"' /><span>"+app[i].appName+"</span></a></li>"
                           )
                	  } else{
                		  $("#navUl").append(
                                  "<li><a href='javascript:void(0);' onclick="+"record('服务大厅')>"
                                  +"<img src='"+app[i].appImg+"' /><span>"+app[i].appName+"</span></a></li>"
                           )
                	  }
                     
                  }
              }
          })
      }
      /*天气、日期接口*/
      function weather(){
    	  // 天气、日期接口 使用的免费天气接口，每小时只能访问500次
          $.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js',function(){  
            //alert(remote_ip_info.country);//国家  
            //alert(remote_ip_info.province);//省份  
            //alert(remote_ip_info.city);//城市   appkey=28596  sign : bd37764e724be25048448a6989cf1fb6(演示使用)
            $.ajax({
                 url:'http://api.k780.com:88/?app=weather.today&weaid='+remote_ip_info.city+'&&appkey=27936&sign='
                     +'f223782cff2126305a33f893065e820a&format=json&jsoncallback=?',
          //     url:'http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theCityCode='+remote_ip_info.city+'&theUserID=',    
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
      }
           
      /* 滑动换肤 */
        $("#range").change(function() {
            var alpha = $(this).val();
            $.ajax({
                url : "${ctx}/skin/save",
                type : "POST",
                data : {
                    id : $("#skinId").val(),
                    roleId : $('#userId').val(),
                    num : alpha
                }
            })
        })
         
            /*推荐背景换肤 */
            $("#show-skin .item").on("click", "img", function() {
                var skin = $(this).attr("src");
                    $(".img-flex").hide();
                    $('body').css({
                        'background-image':'url('+skin+')',
                        'background-position':'center',
                        'background-attachment':'fixed',
                        'background-size':'cover',
                        'background-repeat':'no-repeat'
                    });
                    $("#wrap-skin").slideUp().children("#show-skin").slideUp();
            
                    $.ajax({
                        url : "${ctx}/skin/save",
                        type : "POST",
                        data : {
                            id : $("#skinId").val(),
                            roleId : $('#userId').val(),
                            imageUrl : skin,
                            isUpload : 0
                        },
                        success : function(){
                        	 $("#wrap-skin").slideUp().children("#show-skin").slideUp();
                        }
                    })
            
            });
           /*不使用皮肤*/
            $("a.no-skin") .click( function() {
                var skin = "${ctxStatic}/portal/images/back_img_default.png";
                
                    $(".img-flex").hide();
                    $('body').css({
                        'background-image':'url('+skin+')',
                        'background-position':'center',
                        'background-attachment':'fixed',
                        'background-size':'cover',
                        'background-repeat':'no-repeat'
                    });
                    $("#wrap-skin").slideUp().children("#show-skin").slideUp();
                
                $ .ajax({
                    url : "${ctx}/skin/save",
                    type : "POST",
                    data : {
                        id : $("#skinId").val(),
                        roleId : $('#userId').val(),
                        imageUrl : "${ctxStatic}/portal/images/back_img_default.png",
                        isUpload : 0,
                        num : 0
                    },
                    success : function(){
                    	 $("#wrap-skin").slideUp().children("#show-skin").slideUp();
                    }
                })
              
            });
            var dataURL;
            $(document).off('change','#file').on('change','#file',function() {
                $('.preview-skin img').attr('src','');
                var $file = $(this);
                var fileObj = $file[0];
                validate_img_size(fileObj);
                var windowURL = window.URL || window.webkitURL;
                
                var $img = $("#preview-skin");
                if (fileObj && fileObj.files && fileObj.files[0]) {
                    dataURL = windowURL .createObjectURL(fileObj.files[0]);
                    $img.attr('src', dataURL);
                } else {
                    dataURL = $file.val();
                    var imgObj = document .getElementById("preview-skin");
                    // 两个坑:
                    // 1、在设置filter属性时，元素必须已经存在在DOM树中，动态创建的Node，也需要在设置属性前加入到DOM中，先设置属性在加入，无效；
                    // 2、src属性需要像下面的方式添加，上面的两种方式添加，无效；
                    imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                    imgObj.filters
                            .item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;
                }
                
            });
            $("button:contains('保存')").click( function() {
                $('body').css({
                    'background-image':'url('+dataURL+')',
                    'background-position':'center',
                    'background-attachment':'fixed',
                    'background-size':'cover',
                    'background-repeat':'no-repeat'
                });
                $("#show-skin").slideUp();
                    $.ajaxFileUpload({
                        url : "${ctx}/skin/upload",
                        type : "POST",
                        dataType : 'json',
                        contentType : 'application/json; charset=utf-8',
                        data : {
                            id : $("#skinId").val(),
                            roleId : $('#userId').val(),
                            isUpload : 1,
                            num : $("#range").val()
                        },
                        fileElementId : 'file', //这里对应html中上传file的id
                        contentType : 'application/json;charset=UTF-8',
                        success : function(){
                        	 $("#wrap-skin").slideUp().children("#show-skin").slideUp();
                        }
                    });
                });
                $("#cancel").click(function() {
                	 $("#wrap-skin").slideUp().children("#show-skin").slideUp();
                });
            //     var wow = new WOW({
            //         boxClass: 'wow',
            //         animateClass: 'animated',
            //         offset: 0,
            //         mobile: true,
            //         live: true
            //     });
            //     wow.init();
         
        /* 跳转搜索页面 */       
        function myAjax(name, service) {
        	//兼容ie 将 中文参数转码encodeURI
        	location.href = encodeURI('${ctx}/cms/solr/search?search=' + name
                            + '&service=' + service);
        }
        
        function validate_img_size(img){
             $(".span_tips").css("color","gray");
            var imageType = /\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/ ;
            if (!imageType.test(img.value)) {
                 $(".span_tips").css("color","red");
                $(".span_tips").html("上传的图片格式不正确");
                
            }
            else if(((img.files[0].size).toFixed(2))>=(5*1024*1024)){
                $(".span_tips").css("color","red");
                $(".span_tips").html("上传图片请小于5M");
                $('.preview-skin img').attr('src','');
                $('#file').val('');
                $("#selfSkin").attr("disabled","disabled");  
                return false;
             } else {
                 $(".span_tips").html("图片可以使用");
                 $("#selfSkin").removeAttr("disabled");
             }
        }
        
        /* 过滤搜索 特殊字符 */
    	function stripscript(s) {      
    	    var pattern = new RegExp("[`~!@#$^&*()=+|{}':;',\\[\\].·<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、?？%\"]") 
    	    var rs = ""; 
    	    for (var i = 0; i < s.length; i++) {
    	        rs = rs+s.substr(i, 1).replace(pattern, ''); 
    	    } 
    	    return rs;
    	}
        
        //搜索条件为空不跳 转
        function check(){
        	if(stripscript($("#solr").val())==""){
        		$("#solr").val("");
        		$("#solr").focus();
        		return false;
        	}
        }
       /*  我的应用 */
        function myApps(){
            $.ajax({
                url:'${ctx}/unifiedAuth/user/selfapp',
                type:'POST',
                success:function(data){
                    var html="";
                    for(var i=0;i<data.length;i++){ 
                        var appPic=data[i].pic;
                        var appName=data[i].name;
                        var appUrl=data[i].url;
                        html+=
//                         	"<a href='#' data-url='"+appUrl+"?back_home=back_home' title='"+appName+"'>"+
                             "<a href='#' data-url='"+appUrl+"' title='"+appName+"' target='_blank'>"+
                            "<div class='wrapApp'>"+
                                "<img src='${ctx}/ident/application/download?pic="+appPic+"'>"+
                                "<br>"+
                                "<span class='words'>"+appName+"</span>"+
                            "</div>"
                            +"</a>";
                    }
                    $('.dataContainer').html(html);
                }
            }) 
        }
       
        /*初始化滑动条    */
       function initJrange(){
           var jrange = $('.slider-input').jRange({
               from: 0,
               to: 100,
               step: 1, 
               format: '%s',
               width: 100,
               showLabels: true,
               showScale: false,
               theme: "theme-blue"
           });
       }
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
</body>
</html>