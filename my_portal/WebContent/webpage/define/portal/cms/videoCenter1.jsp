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
    <title>视频中心</title>
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
    <style>
    .current{
    	border-bottom:2px solid #1482C7 !important;
    }
            .two-arrow{
                position: absolute;
                top:10px;
                right:0;
            }
            .two-arrow a{
                margin-right: 10px !important;
                text-decoration: none;
            }
            .two-arrow .glyphicon{
                font-weight: normal !important;
            }
	        .carousel-inner .item-size{
	            text-align: left;
	          	margin-top:10px;
	          	padding-left: 12%;
	          	height:60px;
	          	overflow:hidden !important;
	        }
            .carousel-inner .item-size a{
            	display:inline-block;
                width:70px !important;
                text-decoration:none;
                height:32px !important;
                text-align:center;
            }
            .all{
            	position:absolute;
            	left:50px;
            	top:0;
            	width:40px !important;
            	height:42px !important;
            	line-height:60px !important;
            	 z-index:80;
            	 text-decoration:none !important;
            	 text-align:center;
            }
            .tobe-fixed .item-size{
            	padding-left: 16% !important;
            }
    </style>
    <script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
</head>
<body>
	<!--导航栏-->
	<%@ include file="/webpage/define/portal/cms/front/include/commonHeader.jsp"%>
    <div class="container-fluid">
    <!--banner--> 
    <div class="row"> 
        <div class="col-xs-12 no-padding">
            <div id="car1" class="carousel slide banner" data-ride="carousel" data-interval="4000">
                <!--轮播区域-->
                <div class="carousel-inner">
                    <!--具体轮播项-->
                    <div class="item active">
                        <a href="#"><img src="${ctxStatic }/portal/images/banner01.jpg" class="img-responsive"/></a>
                        <div class="carousel-caption">
                            <h4 class="text">功崇惟志，业广为勤</h4>
                        </div>
                    </div>
                    <div class="item">
                        <a href="#"><img src="${ctxStatic }/portal/images/banner02.jpg" class="img-responsive"/></a>
                        <div class="carousel-caption">
                            <h4 class="text">明德博学，笃行创新</h4>
                        </div>
                    </div>
                </div>
                <a href="#car1" class="carousel-control left" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                </a>
                <a href="#car1" class="carousel-control right" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </a>
                <!-- 增加导航圆点 -->
                <ul class="carousel-indicators">
                    <li class="active" data-target="#car1" data-slide-to="0"></li>
                    <li data-target="#car1" data-slide-to="1"></li>
                </ul>
            </div>
        </div>
    </div>
	</div>
    <div class="container">
    <!--banner-->
    
    <div class="row">
        <div class="col-xs-12" id="tobe-fixed">
				<div class="nav nav-pills carousel slide" id="choose-video"
					data-interval=false>
					<div class="carousel-inner">
					<input type="hidden" id = "videoTypeName" value="" />
						<a href="#" onclick="selectVideo('')" class="all current">全部</a>
						<c:forEach begin="0" end="${requestScope.pageTotal == 0 ? 0 : requestScope.pageTotal-1 }" varStatus="i">
							<c:if test="${i.index eq 0 }">
							<div class="item active item-size">
								<c:forEach items="${videoTypeList }" var="list" begin="${i.index*9 }" end="${i.index*9+8}">
									<a href="#" onclick="selectVideo('${list.typeName }')">${list.typeName }</a>
								</c:forEach>
							</div>
							</c:if>
							<c:if test="${i.index ne 0 }">
							<div class="item item-size">
								<c:forEach items="${videoTypeList }" var="list" begin="${i.index*9 }" end="${i.index*9+8}">
									<a href="#" onclick="selectVideo('${list.typeName }')">${list.typeName }</a>
								</c:forEach>
							</div>
							</c:if>
						</c:forEach>
						<c:if test="${requestScope.pageTotal-1 gt 0}">
						<div class="two-arrow">
							<a href="#choose-video" data-slide="prev" class="prev">
							 	<span class="glyphicon glyphicon-chevron-left"></span>
							</a> 
							<a href="#choose-video" data-slide="next" class="next"> 
								<span class="glyphicon glyphicon-chevron-right"></span>
							</a>
						</div>
						</c:if>
					</div>
				</div>
			</div>
        <!-- 显示视频列表 -->
        <div class="col-xs-12" id="all-videos">
                	
         
        </div>
        
        
<!--         <div class="col-xs-12" id="load"> -->
<!--             <a class="btn btn-lg"> -->
<%--               <img src="${ctxStatic }/portal/images/load.png">查看更多 --%>
<!--             </a> -->
<!--         </div> -->
    </div>
</div>
<!--5、引入 jquery，bootstrap js-->

<script src="${ctxStatic }/portal/notice/js/bootstrap.js"></script>
<script src="${ctxStatic }/portal/notice/js/wow.min.js"></script>
<script>
$(function(){
	var wow = new WOW({
        boxClass: 'wow',
        animateClass: 'animated',
        offset: 0,
        mobile: true,
        live: true
    });
    wow.init();
	$(".carousel-inner").on('click','.item a',function(){
		$(this).addClass('current').siblings().removeClass('current').parent().siblings('.item').children('a').removeClass('current')
		.parent().siblings('a').removeClass('current');
		}).on('click','.all',function(){$(this).addClass('current').siblings('.item').children('a').removeClass('current');}
		)
    $("#all-videos").on("click","img",function(){
        location.href="checkVideo.html";
    });
})
function news(){
		window.location.href="${ctx}/cms/solr/news";
	}
	
function notice(){
		window.location.href="${ctx}/cms/notice/notice";
	}
	
function toChackVideo(){
	window.location.href="${ctx}/cms/solr/showVideo";
}
function selectVideo(name) {
	$("#videoTypeName").val(name);
	$.ajax({
			url:"${ctxFront }/cms/video/selectVideo",
			type : "POST",
			data : {'videoType.typeName':name},
			success : function(date) {
				$("#all-videos").empty();
				$("#all-videos").html(date); 
			}
		});
}
window.onload=function(){ 
	selectVideo("");
}

</script>
</body>
</html>