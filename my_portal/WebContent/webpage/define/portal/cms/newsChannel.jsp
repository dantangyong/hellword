	<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/webpage/include/taglib.jsp"%>

<ul class="nav nav-pills" id="channel-nav">
					<c:forEach items="${allchannel }" var="list">
						<li>
							<a href="javaScript:" onclick="news_teach('${list.name}')">${list.name}</a>
						</li>
					</c:forEach>
</ul>
<script>
function news_teach(name){
	window.location.href="${ctx}/cms/solr/newsChannel?name="+name+"&pageCode=";
}
$(function(){
	
});

</script>