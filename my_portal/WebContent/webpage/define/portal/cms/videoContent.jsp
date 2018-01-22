<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<div class="all-video">
    <c:choose>
		<c:when test="${videos != null && videos.size() != 0}">
			<c:forEach items="${videos}" var="video" begin="0" end="14">
	        <div class="subItem">
        <div class="img-content">
            <img src="${video.videoImage}">
            <span class="play">
               <a href="${ctxFront }/cms/video/detail?id=${video.id}"><img src="${ctxStatic }/portal/images/play.png"></a>
            </span>
        </div>
        <div class="video-words">
            <p class="show-one" title="${video.videoName}">
                ${video.videoName}
            </p>
        </div>
    </div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<div style="text-align:center;">	
        		<img src="/mht_portal/static/user/images/empty.png" />
        	</div>		
		</c:otherwise>
	</c:choose>	
</div>
	<input type="hidden" id="totalPage" value="${page.totalPage }"/>
	<input id="pageCode" type="hidden" value= "1"/>
	<div class="wrap-video" id="addVideo">
	
	</div>
	<input type="hidden" id="foot_helper" value="${fn:length(videos)}">
	<script type="text/javascript">
	 $(document).ready(function(){
		 var footV = $("#foot_helper").val();
		 //视频条数少于5 ，就把页脚固定到底部
	       if(footV =='' || footV ==0 || footV<=5){
	    	   $("#footer").addClass("footer");
	       } 
	 })
	  var pageCode=2;
		function search(a,b) {
		if(b>'${page.totalPage }'||b<1){
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
	</script>