<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head lang="zh-cn">
    <meta charset="UTF-8">
    <!--2 viewport-->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <!--3、x-ua-compatible-->
    <meta http-equiv="x-ua-compatible" content="IE=edge">
    <title>播放详情</title>
    <!--4、引入两个兼容文件-->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <!--6、引入 bootstrap.css-->
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/bootstrap.css">
    <link rel="stylesheet" href ="${ctxStatic }/portal/notice/css/animate.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/videoCenter.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/commonHeader.css">
    <script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
    <style>
    .video-detail-style{float:left;}
  
    
    </style>
</head>
<body>
<%@ include file="/webpage/define/portal/cms/front/include/commonHeader.jsp"%>
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h4 class="title shadowWhite show-one">
                    <span class="tag">热播</span><span class="category">[${video.videoType.typeName }]</span>
                    ${video.videoName}
                </h4>
                <div class="video-box">
                    <video src="${video.videoUrl}" controls id="video1" preload="auto">
                                                              你的浏览器版本太低请升级你的浏览器播放视频                                                             
                    </video>
                    <span class="video-control">
                        <img src="${ctxStatic }/portal/images/play.png">
                    </span>
                </div>
            </div>
            <div class="col-xs-12" style="margin-top:10px;">
                <div class="video-detail-style" > <span style="font-style:bold;"> 视频简介：</span></div>
                <div class="col-xs-10 video-detail-style"  style="padding-left:10px">
                <c:if test="${ empty video.videoDetail}">
                                                               暂无简介
                </c:if>
                ${video.videoDetail}
                 </div>
                 
              
            </div>
            <div class="col-xs-12">
                <div class="hot-video tips-video">
                    <header>
                        <span>推荐视频</span>
                            <span class="to-more">
                          <a href="/mht_portal/f/cms/video">更多</a>
                            <span>
                                 <img src="${ctxStatic }/portal/images/rightArrow.png">
                            </span>
                        </span>
                    </header>
                    <div class="common-channel">
                    <c:forEach items="${videoList}" var="document" begin="0" end="11">
                        <div class="small-item">
                            <div class="img-content">
                                <img src="${document.videoImage}">
                                <span class="play">
                                   <a href="/mht_portal/f/cms/video/detail?id=${document.id}"> <img src="${ctxStatic }/portal/images/play.png"></a>
                                </span>
                            </div>
                            <p class="show-one" title="${document.videoName}">${document.videoName}</p>
                        </div>
        		</c:forEach>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>

<script src="${ctxStatic }/portal/notice/js/bootstrap.min.js"></script>
    <script>
    $(document).ready(function(){
    	$("#video-highlight").css({"background":"#64b8fd"});
    })
        $(function () {
          var player=document.getElementById('video1');
          player.ontimeupdate = function() {myFunction()};  
        function myFunction(){
        	 console.log(player.currentTime);
          }
          
            $('.video-control').click(function (e) {
               e.stopPropagation();
              console.log(player.currentTime);
            player.play();
          });
          player.onpause=function () {
            $('.video-control').show()
          };
          player.onplay=function () {
            $('.video-control').hide()
          };
          $('.video-box').click(function () {
        	 
        	  console.log(player.currentTime);
            player.pause();
          });
        });
    </script>
</body>
</html>