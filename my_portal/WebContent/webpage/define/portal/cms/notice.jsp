<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head lang="zh-cn">
<meta charset="UTF-8">
<!--2 viewport-->
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=no">
<!--3、x-ua-compatible-->
<meta http-equiv="x-ua-compatible" content="IE=edge">
<title>通知公告</title>
<!--4、引入两个兼容文件-->
<!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
<!--6、引入 bootstrap.css-->
<link rel="stylesheet"
	href="${ctxStatic }/portal/notice/css/bootstrap.css">
<link rel="stylesheet" href="${ctxStatic }/portal/notice/css/notice.css">
<link rel="stylesheet" href="${ctxStatic }/portal/notice/css/commonHeader.css">
<style>
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
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<div class="title-header">
					<p class="pull-left">通知公告</p>
					<div class="search-box pull-right">
						<style>
                        	input.ieHcak::-ms-clear{display:none;}
                      	 </style>
                      	 <form:form id="search_helper" action="${ctx}/cms/notice/noticeSearch" method="get">
							<input type="text" placeholder="输入关键字" value="${keyWords}" id="noticeSearch" name="keyWords" class="ieHcak">
<%-- 						<input type="hidden" value="${keyWords }" id="noticeSearchKeyWords"> --%>
						     <button type="submit" >
							   <img src="/mht_portal/static/portal/images/searchIcon.png">
						    </button>
						</form:form>
					</div>
				</div>
			</div>
			<div class="col-xs-12">
				<ul class="notice-detail">
					
					<c:forEach items="${list}" var="document">
						<li><a
							href="${ctx}/cms/notice/noticeDetail?name=${document.id}">${document.title}</a>
							<span class="pull-right"><fmt:formatDate value="${document.updateDate}" pattern="yyyy-MM-dd HH:mm"/></span></li>
<%-- 							<span class="pull-right">${document.updateDate}</span></li> --%>
					</c:forEach>
				
				</ul>
			</div>
		</div>
	</div>
	<!--5、引入 jquery，bootstrap js-->
	<script src="${ctxStatic }/portal/notice/js/bootstrap.js"></script>
	<script src="${ctxStatic }/portal/notice/js/bootlint.js"></script>
	<script>
    $(".btn-group").on("click","button",function () {
        $(this).addClass("active").siblings("button").removeClass("active");
    });
    $(".notice-detail").on("click","a",function () {
        location.href="noticeDetail.html";
    })
</script>

	<script>
	 /*导航菜单高亮 */
    $(document).ready(function(){
    	$("#notice-highlight").css({"background":"#64b8fd"});
    	/*page 当前页样式  */
        $(".pageStyle").each(function(){
           if( $(this).text() ==$("#pageActive").val()){
              $(this).removeClass("btn-default").addClass("btn-primary");
           }
        });
        $("#footer").addClass("footer");
    });  
function news(){
		window.location.href="${ctx}/cms/solr/news?pageCode=";
}
function video(){
	window.location.href="${ctx}/cms/solr/videoee?pageCode=";
}
function infoUsercenter(){
	window.location.href="${ctx}/cms/solr/infoUsercenter?pageCode=";
}
function noticeDetail(solr){
	var url="${ctx}/cms/solr/noticeDetail?solr="+solr+"&ss="+solr;
	window.location.href=url;
}
</script>
	 <c:if test="${pageBean.totalPage gt '1'}"> 
    <div class='2323' style="text-align: center;margin-top:10px">
        <a href='javascript:goPage(1)' id="first"><button type="button"
                class="btn btn-sm btn-default">首页</button></a> <a
            href='javascript:goPage(${pageBean.pageCode-1})' id="first"><button
                type="button" class="btn btn-sm btn-default">上一页</button></a>
        <c:forEach begin="${pageBean.begin }"
            end="${pageBean.end }" var="p">
            <a href="javascript:goPage('${p}')"><button type="button"
                    class="btn btn-sm btn-default pageStyle">${p}</button></a>
        </c:forEach>
        <input type="hidden" value="" name="key"> <a href='javascript:goPage(${pageBean.pageCode+1})' id="first"><button
                type="button" class="btn btn-sm btn-default" />下一页
            </button></a> <a href='javascript:goPage(${pageBean.totalPage})' id="last"><button
                type="button" class="btn btn-sm btn-default">尾页</button></a> 
<%--                 <span>当前第${pageBean.pageCode}页/共${pageBean.totalPage}页</span> --%>
  <input type="hidden" value="${pageBean.pageCode}" id="pageActive">
    </div>
    </c:if>
    <script type="text/javascript">
        function goPage(p) {
            if (p<1 || p>${pageBean.totalPage}) {
                return;
            }
            $("#page").val(p);
            var keyWord = $("#noticeSearch").val();
            location.href = "${ctx}/cms/notice/noticeSearch?pageCode="+p+"&keyWords="+keyWord;
        };
    </script>
 <!-- footer -->
<%@ include file="/webpage/define/portal/cms/front/include/footer.jsp"%>
<script>
 $(document).ready(function(){
        $("#footer").addClass("footer");
    }); 
 </script>
</body>
</html>