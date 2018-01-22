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
    <title>查看视频</title>
    <!--4、引入两个兼容文件-->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <!--6、引入 bootstrap.css-->
    <link rel="stylesheet" href="${ctxStatic }/portal/solrShow/css/bootstrap.css">
    <link rel="stylesheet" href ="${ctxStatic }/portal/solrShow/css/animate.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/solrShow/css/checkVideo.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/commonHeader.css">
    <script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
    <style type="text/css">
    .card p{
		overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    width:210px;
		}
    .card{
    	text-align:center;
    	padding-left:9.5%;
    }
    	.card img{
		width:200px;
		height:150px;
		}
    </style>
</head>
<body>
	<!--导航栏-->
	<%@ include file="/webpage/define/portal/cms/front/include/commonHeader.jsp"%>
    <div class="container first-container">
        <div class="row">
        
            <div class="col-xs-12 title">
                <h5>
                    <span class="hotPoint">热点</span>
                  ${video.videoName}
                </h5>
            </div>
            <div class="col-xs-12" id="video-play">
               <video src="${video.videoUrl}" controls id="video">浏览器不支持video标签</video>
<%--                 <video src="${ctxStatic }/portal/solrShow/res/${video.videoUrl}" controls id="video">浏览器不支持video标签</video> --%>
                <a href="#" class="control-video" style="display:none;">
                    <img src="${ctxStatic }/portal/images/pause.png" id="playIcon" onclick="play()">
                </a>
            </div>					
        
        </div>
    </div>
    <div class="container second-container">
        <div class="row">
            <div class="col-xs-12 relation-video">
                <p><img src="${ctxStatic }/portal/images/movie.png">相关视频</p>
            </div>
            <div class="col-xs-12 wrap-video">
            <c:forEach items="${videoList}" var="document" begin="0" end="8">
        	<div class="card wow rotateIn" data-wow-duration=".8s" data-wow-delay="0.5s">
        		<a href="/mht_portal/f/cms/video/detail?id=${document.id}">
                    <img src="${document.videoImage}" alt="">
                </a>
        		<div class="card-block">
                    <p>${document.videoName}</p>
                </div>
        	</div>
        </c:forEach>
            </div>
        </div>
    </div>
<!--5、引入 jquery，bootstrap js-->

<script src="${ctxStatic }/portal/solrShow/js/bootstrap.js"></script>
<script src="${ctxStatic }/portal/solrShow/js/wow.min.js"></script>
<%-- <script src="${ctxStatic }/portal/solrShow/js/checkVideo.js"></script> --%>
<script>
$(function () {
    var wow = new WOW({
        boxClass: 'wow',
        animateClass: 'animated',
        offset: 0,
        mobile: true,
        live: true
    });
    wow.init();
    console.log(video);
    playIcon.src = "${ctxStatic }/portal/images/play.png";
    $("#video-play").mouseenter(function (e) {
        e.preventDefault();
           $(".control-video").show();
    }).mouseleave(function () {
        $(".control-video").hide();
    });
    $(".control-video").click(function (e) {
        e.preventDefault();
        if (video.paused) {
            $(this).children("img").attr("src", "${ctxStatic }/portal/images/play.png");
            video.play();
        }
        else{
				$(this).hide();
            }
    });
    video.onplay = function () {
        playIcon.style.display="none";
    };
    video.onpause= function () {
        playIcon.style.display="block";
    };
    $(".wrap-video").on("click","img",function () {
        location.href="checkVideo.html";
    })
    $("#video").click(function() {
		video.pause();
	})
});




function news(){
		window.location.href="${ctx}/cms/newsCenter";
	}
	
	function notice(){
		window.location.href="${ctx}/cms/notice/notice?pageCode=";
	}
	
</script>
</body>
</html>