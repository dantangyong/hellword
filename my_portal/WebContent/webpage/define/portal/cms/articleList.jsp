<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>文章管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function viewComment(href){
			top.$.jBox.open('iframe:'+href,'查看评论',$(top.document).width()-220,$(top.document).height()-120,{
				buttons:{"关闭":true},
				loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
					$(".nav,.form-actions,[class=btn]", h.find("iframe").contents()).hide();
					$("body", h.find("iframe").contents()).css("margin","10px");
				}
			});
			return false;
		}
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
	<style type="text/css">
		.title-top {padding:10px;} 
        .i-width{ width:12px;}
	</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	   <div class="ibox-title">
				<h5>新闻列表 </h5>
	   </div>
		<div class="ibox-content">
		   <sys:message content="${message}"/>
	         <div class="row">
			    <div class="col-sm-12">
			        <div class="pull-left">
						<!--查询条件-->
						<form:form id="searchForm" modelAttribute="article" action="${ctx}/cms/article/" method="post" class="breadcrumb form-search form-inline" >
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							
							<div class="form-group">
								    <label>标题：</label>
									<div class="input-group">
									    <form:input path="title" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
									</div>
<!-- 								        弹出框树状展示 -->
<!-- 								    <label>栏目：</label> -->
<!-- 								    <div class="input-group"> -->
<%-- 								         <sys:treeselect id="category" name="category.id" value="${article.category.id}" labelName="category.name" labelValue="${article.category.name}" --%>
<%-- 											    title="栏目" url="/cms/category/treeData" module="article" notAllowSelectRoot="false" cssClass="input-small"/> --%>
<!-- 								    </div> -->
								    <label>栏目：</label>
									<div class="input-group">
									<form:select id="category.id" path="category.id"  class="form-control input-md">
											<option value="" >--全部--</option>
											<form:options items="${categories }" itemLabel="name" itemValue="id" htmlEscape="false"/>
									</form:select>
									</div>&emsp;
								
						<%-- 		<form:form id="searchForm02" modelAttribute="article" action="${ctx}/cms/article/" method="post" class="breadcrumb form-search form-inline title-top" style="display:inline-block"> --%>
								    <label>是否可用：</label>
									<div class="input-group">
										<form:select id="disable" path="disable" class="form-control input-md">
											<option value="" >--请选择--</option>
											<option value="" >全部</option>
											<form:options items="${fns:getDictList('able')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
										<%-- <form:select path="disable" itemValue="value" items="${fns:getDictList('able')}" 
						 					htmlEscape="false" class="form-control input-md"/>  --%>
									</div>
<!-- 								    <label>状态：</label> -->
<!-- 							     	<div class="input-group"> -->
<%-- 										<form:radiobuttons path="disable" class="i-checks" items="${fns:getDictList('able')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
<%-- 										<form:radiobuttons class="i-checks" onclick="searchArticle(this);" path="delFlag" items="${fns:getDictList('able')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
<!-- 										<input id="status1" name="disable"  class="i-checks" type="radio" value="" style="position: absolute; opacity: 0;">全部 -->
<%-- 										<form:radiobuttons id="status2" path="disable"  class="i-checks"  value="1" style="position: absolute; opacity: 0;" />启用 --%>
<%-- 										<form:radiobuttons id="status3" path="disable"  class="i-checks"  value="2" style="position: absolute; opacity: 0;" />禁用 --%>
<!-- 							 		</div> -->
                                      <label>是否推荐：</label>
									  <div class="input-group">
											<form:select id="posid" path="posid" cssStyle="width:100px;" class="form-control input-md">
													<option value="" >全部</option>
													<form:options items="${fns:getDictList('recommend')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				<%-- 									<form:options items="${authors }" itemLabel="name" itemValue="id" htmlEscape="false"/> --%>
											</form:select>
							           </div>
							</div>
						
					<%-- </form:form> --%>
					     </form:form>
			           </div>
					   <div class="pull-left" style="margin-left:5px;">
					    <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					     <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
					   </div>
						<div class="pull-right">
								<shiro:hasPermission name="cms:article:add">
									<a class="btn btn-white btn-sm " href="${ctx}/cms/article/form" title="新闻" ><i class="fa fa-plus"></i>增加</a><!-- 增加按钮 -->
								</shiro:hasPermission>
								<shiro:hasPermission name="cms:article:del">
								    <table:delRow url="${ctx}/cms/article/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
								</shiro:hasPermission>
						       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
						 </div>
			    </div>
		</div>
	
<%-- 	<input type="hidden" value="${disable }" id="dis-check"> --%>
	<input type="hidden" value="" id="no_tips_show">
	 
	<table id="contentTable" class="table table-striped table-bordered table-condensed  dataTable">
		<thead>
		 <tr>
		   <th> <input type="checkbox" class="i-checks"></th>
		   <th>排序</th>
		   <th>点击数</th>
		   <th>标题</th>
		   <th>栏目</th>
		   <th>发布者</th>
		   <th>状态</th>
		   <th  class="sort-column a.video_priority">是否推荐</th>
		   <th>更新时间</th>
		   <th>操作</th>
		   </tr>
		  </thead>
		<tbody>
		<c:forEach items="${page.list}" var="article" varStatus="status" >
			<tr data-id="${article.id}">
			    <td> <input type="checkbox" id="${article.id}" class="i-checks"></td>
			    <td>${article.weight}</td>
 				<td>${article.hits}</td> 
				<td><a href="${ctx}/cms/article/form?id=${article.id}" title="${article.title}">${fns:abbr(article.title,40)}</a></td>
				<td><a href="javascript:" onclick="$('#categoryId').val('${article.category.id}');$('#categoryName').val('${article.category.name}');$('#searchForm').submit();return false;">${article.category.name}</a></td>
				<td>${article.user.name}</td>
				<td>
					<c:if test="${article.disable eq '1' }"><span class="btn-primary btn-sm">已启用</span></c:if>
					<c:if test="${article.disable ne '1' or empty article.disable }"><span class="btn-danger btn-sm">已禁用</span></c:if>
				</td>
				<td>
					<c:if test="${article.posid eq '1' }"><span class="btn-primary btn-sm">已推荐</span></c:if>
					<c:if test="${article.posid ne '1' or empty article.posid }"><span class="btn-danger btn-sm">未推荐</span></c:if>
				</td>
				<td><fmt:formatDate value="${article.updateDate}" type="both"/></td>
				<td>
<%-- 					<a href="${pageContext.request.contextPath}${fns:getFrontPath()}/view-${article.category.id}-${article.id}${fns:getUrlSuffix()}" target="_blank">访问</a> --%>
					   <shiro:hasPermission name="cms:article:edit">
						<c:if test="${article.category.allowComment eq '1'}">
							<a href="${ctx}/cms/comment/?module=article&contentId=${article.id}&delFlag=2" onclick="return viewComment(this.href);">评论</a>
						</c:if>
						 <a href="${ctx}/cms/article/form?id=${article.id}" class="btn btn-success btn-xs"><i class="fa fa-edit"></i>修改</a>
						</shiro:hasPermission>
	    				
	    				<shiro:hasPermission name="cms:article:edit">
							<%-- <a href="${ctx}/cms/article/delete?id=${article.id}${article.delFlag ne 0?'&isRe=true':''}&categoryId=${article.category.id}" onclick="return confirmx('确认要${article.delFlag ne 0?'发布':'删除'}该文章吗？', this.href)" class="btn btn-danger btn-xs">--%>
                            <c:if test="${article.disable eq '1' }">
    						<a href="${ctx}/cms/article/disable?id=${article.id}" onclick="return confirmx('确认要禁用该文章吗？', this.href)" 
    							class="btn btn-warning btn-xs" ><i class="fa fa-lock i-width"></i> 禁用</a>
						</c:if>
						<c:if test="${article.disable ne '1' or empty article.disable }">
    						<a href="${ctx}/cms/article/disable?id=${article.id}" onclick="return confirmx('确认要启用该文章吗？', this.href)" 
    							class="btn btn-primary btn-xs" ><i class="fa fa-unlock i-width"></i> 启用</a>
						</c:if> 
						</shiro:hasPermission>
						<shiro:hasPermission name="cms:article:del">
							<a href="${ctx}/cms/article/delete?id=${article.id}${article.delFlag ne 0?'&isRe=true':''}&categoryId=${article.category.id}" onclick="return confirmx('确认要删除该文章吗？', this.href)" class="btn btn-danger btn-xs">
							 <i class="fa fa-trash"></i>删除</a>
						</shiro:hasPermission>
						<shiro:hasPermission name="cms:article:edit">
						 	<c:if test="${article.posid eq '1' }">
	    						<a href="${ctx}/cms/article/recommend?id=${article.id}" onclick="return confirmx('确认要取消推荐该文章吗？', this.href)" 
	    							class="btn btn-warning btn-xs" ><i class="fa fa-thumbs-down i-width"></i>取消推荐</a>
							</c:if>
							<c:if test="${article.posid ne '1' or empty article.posid }">
	    						<a href="${ctx}/cms/article/recommend?id=${article.id}" onclick="return confirmx('确认要推荐该文章吗？', this.href)" 
	    							class="btn btn-primary btn-xs" ><i class="fa fa-thumbs-up i-width"></i> 是否推荐</a>
							</c:if>
						</shiro:hasPermission>	
<%-- 					 	<c:if test="${status.index != 0}"> --%>
<!-- 					        <a class="btn btn-info btn-xs" onclick="moveUp(this)"> -->
<!-- 						    <i class="fa fa-arrow-circle-up"></i> 上移</a> -->
<%-- 				        </c:if> --%>
<%-- 				       <c:if test="${status.index < page.list.size()-1}"> --%>
<!-- 					        <a class="btn btn-info btn-xs" onclick="moveDown(this)"> -->
<!-- 						    <i class="fa fa-arrow-circle-down"></i> 下移</a> -->
<%-- 				       </c:if> --%>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
		<table:page page="${page}"></table:page>
		<br>
		<br>
	 </div>
	</div>
</div>
<script type="text/javascript">
// $(document).ready(function(){
// 	var c = $("#dis-check").val();
// 	if(c=='1'){
// 		$("#status2").parent(".iradio_square-green").addClass("checked");  
// 	} else if(c=='2'){
// 		$("#status3").parent(".iradio_square-green").addClass("checked"); 
// 	} else {
// 		$("#status1").parent(".iradio_square-green").addClass("checked"); 
// 	}
// });

// $('input').on('ifChecked',function(event){ 
// 	 $("#searchForm02").submit();
// }); 
</script>
<script type="text/javascript">
function moveUp(obj) { 
	var objParentTR = $(obj).parent().parent(); 
	var prevTR = objParentTR.prev(); 
	if (prevTR.length > 0) { 
		$.ajax({
			url:"${ctx}/cms/article/sort",
			type:"post",
			data:{
				sourceId : objParentTR.attr("data-id"),
				destinationId : prevTR.attr("data-id")
			},
			success:function(data){
				layer.msg(data.msg, {
					icon : 1,
					time : 500
				}, function() {
					window.location.reload();
					prevTR.insertAfter(objParentTR); 
				});
			}
		})
	} 
} 
function moveDown(obj) { 
	var objParentTR = $(obj).parent().parent(); 
	var nextTR = objParentTR.next(); 
	if (nextTR.length > 0) { 
		$.ajax({
			url:"${ctx}/cms/article/sort",
			type:"post",
			data:{
				sourceId : objParentTR.attr("data-id"),
				destinationId : nextTR.attr("data-id")
			},
			success:function(data){
				layer.msg(data.msg, {
					icon : 1,
					time : 500
				}, function() {
					window.location.reload();
					nextTR.insertBefore(objParentTR); 
				});
			}
		})
	} 
}

</script>
</body>
</html>