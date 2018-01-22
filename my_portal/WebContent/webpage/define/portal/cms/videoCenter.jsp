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
    .footer{
       display:block !important;
       position: absolute;
       bottom: 0;
    }
    </style>
    <script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
</head>
<body>
<%@ include file="/webpage/define/portal/cms/front/include/commonHeader.jsp"%>
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-12 no-padding">
                <div id="car1" class="carousel slide" data-ride="carousel" data-interval="4000">
                    <!--轮播区域-->
                    <div class="carousel-inner">
                        <!--具体轮播项-->
                         <c:forEach items="${banners }" var="banner" varStatus="status"> 
                        <div class="item <c:if test='${status.index == 0 }'>active</c:if>">
                            <a href="#"><img src="${banner.imageUrl}" class="img-responsive"/></a>
                            <div class="carousel-caption">
                                <h4 class="text">${banner.description}</h4>
                            </div>
                        </div>
                     </c:forEach>
                    </div>
                    <a href="#car1" class="carousel-control left" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                    </a>
                    <a href="#car1" class="carousel-control right" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                    </a>
                    <!-- 增加导航圆点 -->
                    <ul class="carousel-indicators">
                     <c:forEach items="${banners }" var="banner" varStatus="status"> 
                        <li class="<c:if test='${status.index == 0 }'>active</c:if>" data-target="#car1" data-slide-to="${status.index}"></li>
                      </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="wrap-video-nav">
        <div class="container">
        <input type="hidden" id = "videoTypeName" value="" />
            <ul class="video-nav">
                <li class="active"><a onclick="selectVideo('热门推荐')">热门推荐</a></li>
               <li class="all-video"> <a onclick="selectVideo('')">全部</a></li>
								<c:forEach items="${videoTypeList }" var="list" begin="0" end="9">
									<li><a onclick="selectVideo('${list.typeName }')" title="${list.typeName }">${list.typeName }</a></li>
								</c:forEach>
                <c:if test="${fn:length(videoTypeList) gt 10}">
	                <li class="more">
	                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                                                                                              更多
	                        <span class="caret"></span>
	                    </a>
	                    <ul class="dropdown-menu">
	                        <c:forEach items="${videoTypeList }" var="list" begin="10">
										<li><a onclick="selectVideo('${list.typeName }')" class="show-one" title="${list.typeName }">${list.typeName }</a></li>
						    </c:forEach>
	                    </ul>
	                </li>
                </c:if>
            </ul>
        </div>
    </div>
    <div class="container">
        <div class="wrap-video" id="wrap-video">

        </div>
    </div>
<script src="${ctxStatic }/portal/notice/js/bootstrap.js"></script>
<script src="${ctxStatic }/portal/notice/js/wow.min.js"></script>
<script>

/*导航菜单高亮 */
$(document).ready(function(){
      $("#video-highlight").css({"background":"#64b8fd"});
      selectVideo("热门推荐");
});   

$(function () {
    $('.video-nav').on('click','li',function () {
      $(this).addClass('active').siblings().removeClass('active');
      /*点击不同标签切换视频内容*/
      var html=$(this).children().html();
      var isRefresh=html.indexOf('更多');
     if(html==='热门推荐'){
       $('.wrap-video').empty().load('include/hotContent.html');
     }
     else if(isRefresh!==-1){
       return true;
     }
     else{
     }
    });
	if('${page.pageCode}'!=null||'${page.pageCode}'!=''){
		$("#pageCode").val('${page.pageCode}');
	}
	
$(window).scroll(function () {
    //$(window).scrollTop()这个方法是当前滚动条滚动的距离
    //$(window).height()获取当前窗体的高度
    //$(document).height()获取当前文档的高度
    var bot = 0; //bot是底部距离的高度
    if ((bot + $(window).scrollTop()) >= ($(document).height() - $(window).height())) {
       //当底部基本距离+滚动的高度〉=文档的高度-窗体的高度时；
        //我们需要去异步加载数据了
//         $.getJSON("url", { page: "2" }, function (str) { alert(str); });
//        addVideott();
    	if($("#totalPage").val()!=null){
			var pageCode = parseInt($("#pageCode").val());
			var totalPage = parseInt($("#totalPage").val()) 
			if(pageCode>=totalPage){
				return;
			}
		}
//     	alert($("#pageCode").val()+","+$("#totalPage").val()+".............");
		$.ajax({
			url:"${ctxFront }/cms/video/addVideo",
			type : "POST",
			data : {'videoType.typeName':$("#videoTypeName").val(),
				pageCode:$("#pageCode").val() },
			success : function(date) {
			if($("#pageCode").val()==='1'){
// 			 	alert(1);
			 	if(pageCode>totalPage){
    				return;
    			}
				var page = parseInt($("#pageCode").val());
				 $("#pageCode").val(1 + page);
				$("#addVideo").empty();
				$("#addVideo").html(date); 
				return;
				}else{
// 				 	alert($("#pageCode").val()+"######"+$("#totalPage").val());
				 	if($("#pageCode").val()>$("#totalPage").val()){
	    				return;
	    			}
					var id = $("#pageCode").val();
					$("#"+id).empty();
					$("#"+id).html(date); 
					var page = parseInt($("#pageCode").val());
					 $("#pageCode").val(1 + page);
					 return;
				}
			}
		});
    }
});
  });
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
	//切换新闻栏目,去掉页脚固定到页面底部属性
	$("#footer").removeClass("footer");
	$("#pageCode").val(1);
	$("#videoTypeName").val(name);
// 	alert("pageCode="+$("#pageCode").val());
	$.ajax({
			url:"${ctxFront }/cms/video/selectVideo",
			type : "POST",
			data : {'videoType.typeName':name},
			success : function(date) {
				$("#pageCode").val(1);
				$("#wrap-video").empty();
				$("#wrap-video").html(date);
			}
		});
}

</script>
 <!-- footer -->
<%@ include file="/webpage/define/portal/cms/front/include/footer.jsp"%>
</body>
</html>