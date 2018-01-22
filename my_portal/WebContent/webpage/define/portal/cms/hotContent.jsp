<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<div class="hot-video">
    <header>
        <span>热门视频</span>
        <span class="to-more" onclick="more()">
            MORE
            <span>
                <img src="${ctxStatic }/portal/images/rightArrow.png" alt="">
            </span>
        </span>
    </header>
    <div class="common-channel">
    <div class="big-item">
            <div class="img-content">
                <img src="${hotVideos[0].videoImage}">
                <span class="play">
                  <a href="${ctxFront }/cms/video/detail?id=${hotVideos[0].id}">  <img src="${ctxStatic }/portal/images/play.png"></a>
                </span>
            </div>
            <p class="show-one" title="${hotVideos[0].videoName}">${hotVideos[0].videoName}</p>
        </div>
    <c:forEach items="${hotVideos}" var="video" begin="1" end="8">
				<div class="small-item">
					<div class="img-content">
               			<img src="${video.videoImage}">
                			<span class="play">
                    	<a href="${ctxFront }/cms/video/detail?id=${video.id}"> <img src="${ctxStatic }/portal/images/play.png"></a>
               				 </span>
            		</div>
            		<p class="show-one" title="${video.videoName}">${video.videoName}</p>
	        	</div>
	</c:forEach>
    </div>
</div>
<div class="hot-video">
    <header>
        <span>推荐视频</span>
        <span class="to-more" onclick="more()">
            MORE
            <span>
                <img src="${ctxStatic }/portal/images/rightArrow.png" alt="">
            </span>
        </span>
    </header>
        
    <div class="common-channel">
        <div class="big-item">
            <div class="img-content">
                <img src="${recommendVideos[0].videoImage}">
                <span class="play">
                    <a href="${ctxFront }/cms/video/detail?id=${recommendVideos[0].id}"> <img src="${ctxStatic }/portal/images/play.png"></a>
                </span>
            </div>
            <p class="show-one" title="${recommendVideos[0].videoName}">${recommendVideos[0].videoName}</p>
        </div>
        
        <c:forEach items="${recommendVideos}" var="video" begin="1" end="8">
				<div class="small-item">
					<div class="img-content">
               			<img src="${video.videoImage}">
                			<span class="play">
                    	<a href="${ctxFront }/cms/video/detail?id=${video.id}"> <img src="${ctxStatic }/portal/images/play.png"></a>
               				 </span>
            		</div>
            		<p class="show-one" title="${video.videoName}">${video.videoName}</p>
	        	</div>
	</c:forEach>
    </div>
</div>
	<script>
	$("#document").ready(function(){
		if('${page.pageCode}'!=null||'${page.pageCode}'!=''){
			$("#pageCode").val('${page.pageCode}');
		}
	});
function more() {
	selectVideo("");
}

</script>