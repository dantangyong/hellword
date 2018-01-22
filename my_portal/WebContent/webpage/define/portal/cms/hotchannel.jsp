<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>

<%-- <c:forEach items="${secondHotChannel}" var="list"> --%>
<%-- 	<a href="javaScript:" onclick="news_channel('${list.name }')"> <img --%>
<%-- 		src="${ctxStatic }${list.image}" alt="">  --%>
<!-- 		<br>  -->
<%-- 		<span>${list.name }</span> --%>
<!-- 	</a> -->
<%-- </c:forEach> --%>
<div class="row">
            <div class="col-sm-8 border-radius left" style="padding:0;">
                <div id="car1" class="carousel slide banner" data-ride="carousel" data-interval="3000">
                    <!--轮播区域-->
                    <div class="carousel-inner">
                        <!--具体轮播项-->
                      <c:forEach items="${recommendList}" var="list" begin="0" end="4" varStatus="status">   
                        <div class="item <c:if test="${status.index ==0}">active</c:if> ">
                            <c:if test="${not empty list.article.link }">
                                     <a href="${list.article.link }" target="_blank" ><img src="${list.article.image}"  class="img-responsive"/></a>
                            </c:if>
                             <c:if test="${empty list.article.link }">
                                    <a href="#" onclick="newsDetail('${list.id}')"><img src="${list.article.image}"  class="img-responsive"/></a>
                            </c:if>
	                       <div class="banner-content">
			                    <header>
			                        <c:if test="${not empty list.article.link }">
                                      <a href="${list.article.link }" target="_blank" >${list.article.title}</a>
                                    </c:if>
                                    <c:if test="${empty list.article.link }">
                                      <a onclick="newsDetail('${list.id}')"  >${list.article.title}</a>
                                    </c:if>
			                    </header>
			                    <p class="show-one detail">
			                       ${list.article.description}
			                    </p>
	                       </div>
                         </div>
                        </c:forEach>
                    </div>
                    <!-- 增加导航圆点 -->
                    <ul class="carousel-indicators">
                        <li class="active" data-target="#car1" data-slide-to="0"></li>
                        <li data-target="#car1" data-slide-to="1"></li>
                        <li data-target="#car1" data-slide-to="2"></li>
                        <li data-target="#car1" data-slide-to="3"></li>
                        <li data-target="#car1" data-slide-to="4"></li>
                    </ul>
                </div>
                
            </div>
            <div class="col-sm-4 some-padding right1">
                <div class="border-radius some-padding">
                    <header>热点新闻</header>
                    <main>
                    	<c:forEach items="${hitsList}" var="list" begin="0" end="5">
                        <div class="item">
                            <p class="header-text">
                                <span class="glyphicon glyphicon-time"></span>
                                <span class="date"><fmt:formatDate value="${list.article.updateDate}" pattern="MM-dd HH:mm"/></span>
                                <span class="publish">${list.copyfrom}</span>
                            </p>
                            <p class="paragraph show-one ">
                              <c:if test="${not empty list.article.link }">
                                  <a href="${list.article.link }" target="_blank" >${list.article.title}</a>
                              </c:if>
                              <c:if test="${empty list.article.link }">
                                      <a onclick="newsDetail('${list.id}')"  >${list.article.title}</a>
                              </c:if>
                              
                            </p>
                        </div>
                        </c:forEach>
                    </main>
                </div>
            </div>
            <div class="col-xs-12 change-padding0">
                <p class="title">精彩推荐</p>
                <div class="row news-container">
                <c:forEach items="${recommendList}" var="list" begin="5" end="12">
                    <div class="col-sm-3 height380">
                        <div class="border-radius">
                         <c:if test="${not empty list.article.link }">
                            <a href="${list.article.link }" target="_blank" ><img src="${list.article.image}" class="img-responsive"></a>
                         </c:if>
                         <c:if test="${empty list.article.link }">
                            <img src="${list.article.image}" onclick="newsDetail('${list.id}')" class="img-responsive">
                         </c:if>
                            <div class="padding27">
                                <p class="card-new">
                                    <span class="news-title">${list.copyfrom}</span>
                                    <span class="time"><fmt:formatDate value="${list.article.updateDate}" pattern="MM-dd HH:mm"/></span>
                                </p>
                                <p class="news-title show-one content-line01">
                                  <c:if test="${not empty list.article.link }">
                                    <a href="${list.article.link }" target="_blank" class="show-two content-line01" style="display:block" >${list.article.title }</a>
                                 </c:if>
                                 <c:if test="${empty list.article.link }">
                                    <a onclick="newsDetail('${list.id}')" class="show-two content-line01" style="display:block" >${list.article.title }</a>
                                 </c:if>
<%--                             	       <c:if test="${fn:length(list.article.title)>16 }">   --%>
<%-- <%--                     						<a onclick="newsDetail('${list.id}')" class="show-two" >${fn:substring(list.article.title, 0, 16)}...</a>  --%> 
<%--                                                <a onclick="newsDetail('${list.id}')" class="show-two" >${list.article.title }</a> --%>
<%-- 					                   </c:if>   --%>
<%-- 					                   <c:if test="${fn:length(list.article.title)<=16 }">  --%>
<%-- 					                    	<a onclick="newsDetail('${list.id}')" class="show-two" >${list.article.title } </a>  --%>
<%-- 					                   </c:if>   --%>
                                </p>
                                <div class="show_three" style="height:60px;overflow:hidden">
                                <p class="news-content " >
                                       ${list.article.description }
<%--                                    	    <c:if test="${fn:length(list.article.description)>48 }">   --%>
<%--                          				   ${fn:substring(list.article.description, 0, 48)}...   --%>
<%--                    						</c:if>   --%>                  
<%--                   						<c:if test="${fn:length(list.article.description)<=48 }">   --%>
<%--                          				   ${list.article.description}  --%>
<%--                   					    </c:if>   --%>
                                </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
            </div>
            <script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
<script src="${ctxStatic }/portal/notice/js/bootstrap.js"></script>
<script type="text/javascript">
$('#car1').carousel();
function newsDetail(id){
	$.ajax({
		type:"POST",
		url:"${ctx}/cms/solr/newsDetailJsp",
		data:{
			name:id,
			},
		success:function(date){
			$("#secondHotChannel").empty();
			$("#secondHotChannel").html(date);
			}
		});
}

$(".show_three").each(function(i){
    var divH = $(this).height();
    var $p = $("p", $(this)).eq(0);
    while ($p.outerHeight() > divH) {
        $p.text($p.text().replace(/(\s)*([a-zA-Z0-9]+|\W)(\.\.\.)?$/, "..."));
    };
});

</script>
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 