<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
 <c:choose>
		<c:when test="${videos != null && videos.size() != 0}">
			<c:forEach items="${videos}" var="video">
	        <div class="subItem">
        <div class="img-content">
            <img src="${video.videoImage}">
            <span class="play">
               <a href="${ctxFront }/cms/video/detail?id=${video.id}"><img src="${ctxStatic }/portal/images/play.png"></a>
            </span>
        </div>
        <div class="video-words">
            <p class="show-one">
                ${video.videoName}
            </p>
        </div>
    </div>
			</c:forEach>
		</c:when>
	</c:choose>		
	<div id="${page.pageCode }">
	</div>
	<script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
	<script>
	</script>
	
	
	
	
	
	
	
	
	 