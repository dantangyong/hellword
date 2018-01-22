<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/webpage/define/portal/cms/front/include/taglib.jsp"%>
<div class="col-xs-12 news-distance">
	<div class="row">
		<div class="col-xs-12 col-md-7 border-radius pictips_content">
		   <c:if test="${empty documentList}"> 
		        <img src="${ctxStatic }/portal/images/infoNotFound.png" class="imgtips_content"   alt="图片走丢了">
		         <script>
                   $("#pic_helper").val("true");
                 </script>
		   </c:if>
		  <c:if test="${not empty documentList}">   
			<c:forEach items="${documentList}" var="document" varStatus="status">
				<c:choose>
					<c:when
						test="${document['article_image'][0] ne null && document['article_image'][0] ne ''&& document['article_image'][0] ne 'null'}">
						<div class="img-text-new">
							<div class="img-content">
		                         <img alt="图片走丢了" src="${document['article_image'][0] }" />
<!-- 								<img alt="图片走丢了" -->
<!-- 									src="/mht_portal/static/portal/images/back_img_ten.png" /> -->

							</div>
							<div class="news-content">
								<h5>
								  <c:if test="${not empty document['article_link'][0] }">
								      <a href="${document['article_link'][0] }" class='show-one' target="_blank"> 
									          <c:forEach items='${document["article_title"]}' var="value"> ${value} </c:forEach>
									 </a>
								  </c:if>
								  <c:if test="${empty document['article_link'][0] }">
								      <a href="${ctx}/cms/solr/solrDetailJsp?name=${document.id[0]}"class='show-one'> 
									          <c:forEach items='${document["article_title"]}' var="value"> ${value} </c:forEach>
									</a>
								  </c:if>
									
								 <span class="pull-right">
								   <c:forEach items='${document["update_date"]}' var="value01">
<%--                                          <fmt:parseDate value="${value01}" var="yearMonth" pattern="yyyy-MM-dd HH:mm"/> --%>
<%-- 		                                 <fmt:formatDate value="${yearMonth}" pattern="yyyy-MM-dd HH:mm"/> --%>
                                                  <span class="data-format">  ${value01}</span>
                                </c:forEach> </span>
								</h5>
								<p class="show-three" style="height:70px;">
									<c:forEach items='${document["article_description"]}'
										var="value02">
                                  ${value02}
                             </c:forEach>
								</p>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="text-new">
							<div class="news-content text-left">
								<h5>
									<c:if test="${not empty document['article_link'][0] }">
								      <a href="${document['article_link'][0] }" class='show-one' target="_blank"> 
									          <c:forEach items='${document["article_title"]}' var="value"> ${value} </c:forEach>
									 </a>
								  </c:if>
								  <c:if test="${empty document['article_link'][0] }">
								      <a href="${ctx}/cms/solr/solrDetailJsp?name=${document.id[0]}"class='show-one'> 
									          <c:forEach items='${document["article_title"]}' var="value"> ${value} </c:forEach>
									</a>
								  </c:if>
									 <span class="pull-right"> <c:forEach
											items='${document["update_date"]}' var="value01">
<%--                                          <fmt:parseDate value="${value01}" var="yearMonth" pattern="yyyy-MM-dd HH:mm"/> --%>
<%-- 		                                 <fmt:formatDate value="${yearMonth}" pattern="yyyy-MM-dd HH:mm"/> --%>
		                                  <span class="data-format"  style="margin-right: 20px;">  ${value01}</span>
                                </c:forEach>
									</span>
								</h5>
								<p class="show-three" style="height:70px;">
									<c:forEach items='${document["article_description"]}'
										var="value02">
                                  ${value02}
                             </c:forEach>
								</p>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
		</div>
		<div
			class="col-xs-12 col-md-4 col-md-offset-1 border-radius include-search">
			<h4>热门搜索</h4>
			<div class="hot-content">
				<ul class="recent-news" id="hot-content">
				</ul>
			</div>
		</div>
	</div>
</div>
  <div class="col-xs-12 col-md-7 text-center"> 
	<c:if test="${total gt 5}" >
		<c:forEach items="${divedPage}" var="showPage" >
			<c:forEach items="${showPage}" var="map" >
			<c:choose>
			<c:when test="${map.key == '上一页' }">
			<button type="button" class="btn btn-sm btn-default prev" onclick="button(${showPage.value})">上一页</button> 
			</c:when>
			<c:when test="${map.key == '其他页' }">
			<button type="button" class="btn btn-sm btn-default" onclick="button(${map.value})">${map.value}</button> 
			</c:when>
			<c:when test="${map.key == '当前页' }">
			<button type="button" class="btn btn-sm btn-default currentv" onclick="button(${map.value})">${map.value}</button>
			</c:when>
			<c:otherwise>
			<button type="button" class="btn btn-sm btn-default next" onclick="button(${map.value})">下一页</button> 
			</c:otherwise>
			</c:choose>
			</c:forEach> 
		</c:forEach>
	</c:if>
</div>
<script>   
$(document).ready(function(){
	$(".search-nav li:eq(0)").addClass("active");
	 changeBackground();
	 dateFormat();
});
   $(function(){
		$.ajax({
			url:"${ctx}/cms/solr/hotName",
			type:"GET",
			data : {
				service:"1"
			},
			success:function(data){
				$("#hot-content").empty();
				var compos = data.body.composes;
				for(var i=0; i < compos.length; i++){
					var url = compos[i].name == null ? "" : compos[i].name;
					$("#hot-content").append("<li><a id=li"+compos[i].id+" class='show-one' >"+'<span class="number">'+(i+1)+'</span>'+compos[i].name+"</a></li>");
					$("#li"+compos[i].id).attr("href","#");
					$("#li"+compos[i].id).attr("onclick","myAjax('"+compos[i].name+"','"+compos[i].service+"')");
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
		//location.href='${ctx}/cms/solr/search?search='+name+'&service='+service;
	}
	</script>
