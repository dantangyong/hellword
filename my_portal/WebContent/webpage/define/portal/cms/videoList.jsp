<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
	<c:choose>
		<c:when test="${videos != null && videos.size() != 0}">
			<c:forEach items="${videos}" var="video">
				<div class="card">
	        		<a href="${ctxFront }/cms/video/detail?id=${video.id}">
	                    <img src="${video.videoImage}" alt=""> 
<%-- 							 <video src="${video.videoUrl }" preload="none"></video> --%>
	                </a>
	        		<div class="card-block">
	                    <p>${video.videoName}</p>
	                </div>
	        	</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<div >	
        		<img src="/mht_portal/static/user/images/empty.png" />
        	</div>		
		</c:otherwise>
	</c:choose>		
<script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
<input id="pageCode" type="hidden" value= "1"/>
	<div id="addVideo" style="margin-top:0">
	</div>
	  <script>
	  var pageCode=2;
	function search(a,b) {
	if(b>'${page.last }'||b<1){
			return
		}
	$.ajax({
		type:"POST",
		url:"${ctx}/swust/order/list",
		data:"state="+a+"&pageNo="+b+"&name="+$("#hiddenkey").val(),
		success:function(date){
			$("#not-check").empty();
			$("#not-check").html(date);
			$("#"+b).addClass("active");
		}
	});
}
	$(document).ready(function () { 
// 	    $(window).scroll(function () {
// 	        //$(window).scrollTop()这个方法是当前滚动条滚动的距离
// 	        //$(window).height()获取当前窗体的高度
// 	        //$(document).height()获取当前文档的高度
// 	        var bot = 0; //bot是底部距离的高度
// 	        if ((bot + $(window).scrollTop()) >= ($(document).height() - $(window).height())) {
// 	           //当底部基本距离+滚动的高度〉=文档的高度-窗体的高度时；
// 	            //我们需要去异步加载数据了
// // 	            $.getJSON("url", { page: "2" }, function (str) { alert(str); });
// // 	           addVideott();
// 	        	if($("#totalPage").val()!=null){
// 	    			var pageCode = parseInt($("#pageCode").val());
// 	    			var totalPage = parseInt($("#totalPage").val())
// 	    			if(pageCode>totalPage){
// 	    				return;
// 	    			}
// 	    		}
// 	    		$.ajax({
// 	    			url:"${ctxFront }/cms/video/addVideo",
// 	    			type : "POST",
// 	    			data : {'videoType.typeName':$("#videoTypeName").val(),
// 	    				pageCode:$("#pageCode").val() },
// 	    			success : function(date) {
// 	    			if($("#pageCode").val()=='1'){
// 	    				var page = parseInt($("#pageCode").val());
// 	    				 $("#pageCode").val(1 + page);
// 	    				$("#addVideo").empty();
// 	    				$("#addVideo").html(date); 
// 	    				}else{
// 	    					var id = $("#pageCode").val();
// 	    					$("#"+id).empty();
// 	    					$("#"+id).html(date); 
// 	    					var page = parseInt($("#pageCode").val());
// 	    					 $("#pageCode").val(1 + page);
// 	    				}
// 	    			}
// 	    		});
// 	        }
// 	    });
	});
</script>
	
	
	
	
	
	
	
	
	
	
	 