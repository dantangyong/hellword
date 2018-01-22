<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<link rel="stylesheet"
	href="${ctxStatic }/portal/notice/css/noticeDetail.css">
	<link rel="stylesheet" href="${ctxStatic }/portal/notice/css/commonHeader.css">
	<script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
	<style>
	 .footer{
       display:block !important;
       position: absolute;
       bottom: 0;
    }
	</style>
</head>
<body>
	<!--导航栏-->
	<%@ include file="/webpage/define/portal/cms/front/include/commonHeader.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
            	<h4 class="text-center notice-title">${notice.title}</h4>
       		</div>
             <div class="notice-content"> 
               <h5> </h5> 
                 <ul> 
                     <li> 
                          <div id="notice_contents">
                         ${notice.content}
                          </div>
                        
                    </li> 
                    <c:if test="${noticeFiles!=null && fn:length(noticeFiles) > 1}">
                       <c:forEach items="${noticeFiles}" var="noticefile">
	                     <li class="text-left"> 
                             <a href="${noticefile.files}"><font color="red" size="2">附件:${noticefile.title}</font></a>
	                     </li> 
	                     </c:forEach>
                     </c:if>
                     <li class="text-right">${notice.office.name}</li> 
                     <li class="text-right">
                     <fmt:formatDate value="${notice.updateDate}" pattern="yyyy-MM-dd HH:mm"/>
                     </li> 
                 </ul> 
             </div>  
		</div>
	</div>
	<!--5、引入 jquery，bootstrap js-->
	<script src="${ctxStatic }/portal/notice/js/bootstrap.js"></script>
	<script src="${ctxStatic }/portal/notice/js/bootlint.js"></script>
<script type="text/javascript">
/*导航菜单高亮 */
$(document).ready(function(){
	$("#notice-highlight").css({"background":"#64b8fd"});
	if($(document.body).height()<800){
		$("#footer").addClass("footer");
	}
})
function news(){
	window.location.href="${ctx}/cms/solr/news?pageCode=";
}

function video(){
	window.location.href="${ctx}/cms/solr/videoee?pageCode=";
}

function notice(){
	window.location.href="${ctx}/cms/notice/notice?pageCode=";
}

function infoUsercenter(){
	window.location.href="${ctx}/cms/solr/infoUsercenter?pageCode=";
}

</script>	
 <!-- footer -->
<%@ include file="/webpage/define/portal/cms/front/include/footer.jsp"%>
</body>
</html>