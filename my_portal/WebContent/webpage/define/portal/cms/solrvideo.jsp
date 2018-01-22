<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<style>
/*  视频标题靠左显示 */
.video-item{
    text-align: left; 
}
.video-item h5 {
    text-align: left; 
}

</style>
<div class="news-distance" style="margin-left:-15px">
	<div class="row">
		<div class="col-xs-12" style="padding-left: 0px;">
			<div class="col-xs-12 border-radius pictips_content" style="padding: 15px 0px">
			     <c:if test="${empty documentList}"> 
			          <div style="text-align:center;">
		                  <img src="${ctxStatic }/portal/images/infoNotFound.png"  class="imgtips_content"   alt="图片走丢了">
		                   <script>
		                      $("#pic_helper").val("true");
		                   </script>
		              </div>
		         </c:if>
				<ul>
				 <c:if test="${not empty documentList}">  
					<c:forEach items="${documentList}" var="document"
						varStatus="status">
						<li class="video-item"><a
							href="/mht_portal/f/cms/video/detail?id=${document.id[0]}"> <img
								src="${document.video_image[0]}">
						</a>
							<h5 class="show-one">
								<c:forEach items='${document["video_name"]}' var="value">
                                                           ${value}
                                 </c:forEach>
                            </h5>
                            </li>
               	     </c:forEach>
                  </c:if>
				</ul>
			</div>
		</div>

	</div>
</div>
 <div class="col-xs-12 text-center">
<c:if test="${total gt 16}">
	<c:forEach items="${divedPage}" var="showPage">
		<c:forEach items="${showPage}" var="map">
			<c:choose>
				<c:when test="${map.key == '上一页' }">
					<button type="button" class="btn btn-sm btn-default prev"
						onclick="button(${showPage.value})">上一页</button>
				</c:when>
				<c:when test="${map.key == '其他页' }">
					<button type="button" class="btn btn-sm btn-default"
						onclick="button(${map.value})">${map.value}</button>
				</c:when>
				<c:when test="${map.key == '当前页' }">
					<button type="button" class="btn btn-sm btn-default currentv"
						onclick="button(${map.value})">${map.value}</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-sm btn-default next"
						onclick="button(${map.value})">下一页</button>
				</c:otherwise>

			</c:choose>
		</c:forEach>
	</c:forEach>

</c:if>
</div>
<script>
$(document).ready(function(){
	$(".search-nav li:eq(3)").addClass("active");
	changeBackground();
});

</script>