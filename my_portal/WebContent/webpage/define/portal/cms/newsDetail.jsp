<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
.cke_show_borders{
white-space: pre-wrap;
}
</style>
        <div class="row">
            <div class="col-xs-12">
            	 <c:forEach items="${list03}" var="document">
                <div class="wrap-detail-content">
                    <h3 class="text-center title-header">${document["article"].title}</h3>
                    <p class="text-right pub-time"><span>${document.copyfrom}</span><fmt:formatDate value="${document['article'].updateDate}" pattern="yyyy-MM-dd HH:mm"/></p>
<!--                     <p class="line-style"> -->
<%--                          ${document.content}  --%>
<!--                     </p> -->
                         <div>
                          ${document.content}
                         </div>
                </div>
                </c:forEach>
            </div>

        </div>
<script>
if($(document.body).height()<800){
	$("#footer").addClass("footer");
}
</script>
