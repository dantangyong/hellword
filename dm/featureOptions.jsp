<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<c:if test="${not empty analysisDepots}">
	<c:forEach items="${analysisDepots}" var="analysisDepot">
		<option value="${analysisDepot.id}">${analysisDepot.name}</option>
	</c:forEach>	
</c:if>