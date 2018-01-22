<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/webpage/include/taglib.jsp"%>
 <div class="news-distance">
	    <div class="row">
	         <div class="col-xs-12 col-md-7 border-radius pictips_content">
	              <c:if test="${empty documentList}"> 
		               <img src="${ctxStatic }/portal/images/infoNotFound.png" class="imgtips_content"    alt="图片走丢了">
		                <script>
		                   $("#pic_helper").val("true");
		               </script>
		         </c:if>
		          <c:if test="${not empty documentList}"> 
		               <c:forEach items="${documentList}" var="document" varStatus="status">
		                   <div class="notice-item">
		                     <h5><a href="${ctx}/cms/notice/noticeDetail?name=${document.id[0]}">通知公告:${document["notice_title"] }</a></h5>
		                 <p class="show-three" style="height:70px;">
		                   ${document["notice_content"][0]}
		                 </p>
		                 </div>
		               </c:forEach>
	             </c:if>
	         </div>
	         
               <div
			class="col-xs-12 col-md-4 col-md-offset-1 border-radius include-search">
			<h4>热门搜索</h4>
			<div class="hot-content">
				<ul class="recent-news" id="hot-contents">
				
				</ul>
			</div>
		</div>
          </div>
 </div>
 <div class="col-xs-12 col-md-7 text-center">
<c:if test="${total gt 5}">
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
	changeBackground();
    $(".search-nav li:eq(2)").addClass("active");
  
});

   $(function(){
		$.ajax({
			url:"${ctx}/cms/solr/hotName",
			type:"GET",
			data : {
				service:"3"
			},
			success:function(data){
				$("#hot-contents").empty();
				var compos = data.body.composes;
				for(var i=0; i < compos.length; i++){
					var url = compos[i].name == null ? "" : compos[i].name;
					console.log("====="+url);
					$("#hot-contents").append("<li><a id=li"+compos[i].id+" class='show-one' href='#'"
							                 +"onclick=myAjax('"+compos[i].name+"','"+compos[i].service+"')>"
							                 +'<span class="number">'+(i+1)+'</span>'+compos[i].name+"</a></li>");
				}
				
			}
		})
	})
	
	function button(page){
		$.ajax({
			url : "${ctx}/cms/solr/change",
			type : "post",
			data : {
				type : record,
				solr : $("#solr").val(),
				mypage:page
			},
			success : function(data) {
				if(record == 0 || record == 1){
					$('#news').html(data);}
					if(record == 2)
						{$("#service-application").html(data);
						
						return;
						}
					if(record == 3)
						{$("#show-message").html(data);return;}
					if(record == 4){
						$("#pingan-video").html(data);return;
					}
			}
		});
	}
	function myAjax(name,service){
		$("#solr").val(name);
		serviceapp(service);
// 		location.href='${ctx}/cms/solr/search?search='+name+'&service='+service+'#show-message';
	}
	</script>
          

