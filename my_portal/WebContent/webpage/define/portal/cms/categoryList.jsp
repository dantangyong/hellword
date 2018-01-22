<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="front/include/taglib.jsp"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>栏目管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="front/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 3});
		});
    	function updateSort() {
			loading('正在提交，请稍等...');
	    	$("#listForm").attr("action", "${ctx}/cms/category/updateSort");
	    	$("#listForm").submit();
    	}
	</script>
	<style>
	.i-width{
	width:12px;
	}
	</style>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="ibox">
		    <div class="ibox-title">
				<h5>栏目列表 </h5>
			</div>
    <div class="ibox-content">
	<sys:message content="${message}"/>
		<div class="row">
			<div class="col-sm-12">
			   <div class="pull-left">
					<form:form id="searchForm" modelAttribute="category" action="${ctx}/cms/category/" method="post" class="breadcrumb form-search form-inline title-top" style="display:inline-block">
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
						<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
						<div class="form-group">
							<span>标题：</span>
								<form:input path="name" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
						        <span>状态：</span>
						            <form:radiobuttons path="inMenu" class="i-checks" items="${fns:getDictList('able')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						 </div>	
					 </form:form>
			   </div>
			   <div class="pull-left" style="margin-left:5px;">
			    <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			     <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
			   </div>
			<div class="pull-right">
					<shiro:hasPermission name="cms:category:edit">
						<a class="btn btn-white btn-sm " href="${ctx}/cms/category/form" title="栏目" width="700px" height="500px"><i class="fa fa-plus"></i>增加</a><!-- 增加按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="cms:category:edit">
					    <table:delRow url="${ctx}/cms/category/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
					</shiro:hasPermission>
			       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
				 
			 </div>
			
			
			</div>
		</div>
	
	
		<table id="contentTable" class="table table-striped table-bordered table-condensed dataTable">
			<tr>
			    <th> <input type="checkbox" class="i-checks"></th>
				<th>栏目名称</th>
				<th style="text-align:center;">排序</th>
				<th title="是否在导航中显示该栏目">状态</th>
				<th>操作</th>
			</tr>
			<c:forEach items="${page.list}" var="category" varStatus="status">
				<tr data-id="${category.id}" id="${category.id}" pId="${category.parent.id ne '1'?category.parent.id:'0'}">
				    <td> <input type="checkbox" id="${category.id}" class="i-checks"></td>
					<td><a href="${ctx}/cms/category/form?id=${category.id}">${category.name}</a></td>
					<td style="text-align:center;">
							${category.sort}
					</td>
					<td>
                         <c:choose>
							   <c:when test="${(fns:getDictLabel(category.inMenu, 'show_hide', '隐藏'))=='显示'}">
							        <span class="btn-primary btn-sm status-style">已启用</span> 
							   </c:when>
							   <c:otherwise>
							        <span class="btn-danger btn-sm status-style">已禁用</span> 
							   </c:otherwise>
						   </c:choose>
                         
					</td>
					<td>
						<shiro:hasPermission name="cms:category:edit">
							<a href="${ctx}/cms/category/form?id=${category.id}" class="btn btn-success btn-xs"><i class="fa fa-edit"></i>修改</a>
							<c:choose>
							   <c:when test="${(fns:getDictLabel(category.inMenu, 'show_hide', '隐藏'))=='显示'}">
							       <a href="${ctx}/cms/category/showOrHide?id=${category.id}" onclick="return confirmx('确认要启用/禁用该栏目吗？', this.href)" class="btn btn-warning btn-xs">
							               <i class="fa fa-lock i-width"></i>禁用
							       </a>
							   </c:when>
							   <c:otherwise>
							        <a href="${ctx}/cms/category/showOrHide?id=${category.id}" onclick="return confirmx('确认要启用/禁用该栏目吗？', this.href)" class="btn btn-primary btn-xs">
							               <i class="fa fa-unlock i-width"></i>启用
							       </a>
							   </c:otherwise>
						   </c:choose>
							<a href="${ctx}/cms/category/delete?id=${category.id}" onclick="return confirmx('要删除该栏目及所有子栏目项吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i>删除</a>
<%-- 							<c:if test="${status.index != 0}"> --%>
<!-- 						        <a class="btn btn-info btn-xs" onclick="moveUp(this)"> -->
<!-- 							    <i class="fa fa-arrow-circle-up"></i> 上移</a> -->
<%-- 					        </c:if> --%>
<%-- 					       <c:if test="${status.index < page.list.size()-1}"> --%>
<!-- 						        <a class="btn btn-info btn-xs" onclick="moveDown(this)"> -->
<!-- 							    <i class="fa fa-arrow-circle-down"></i> 下移</a> -->
<%-- 					       </c:if> --%>
						</shiro:hasPermission>
					</td>
				</tr>
			</c:forEach>
		</table>
<%-- 		<shiro:hasPermission name="cms:category:edit"><div class="form-actions pagination-left"> --%>
<!-- 			<input id="btnSubmit" class="btn btn-primary" type="button" value="保存排序" onclick="updateSort();"/> -->
<%-- 		</div></shiro:hasPermission> --%>
		<table:page page="${page}"></table:page>
		<br>
		<br>
	
	</div>
  </div>
</div>
<script type="text/javascript">
function moveUp(obj) { 
	var objParentTR = $(obj).parent().parent(); 
	var prevTR = objParentTR.prev(); 
	if (prevTR.length > 0) { 
		$.ajax({
			url:"${ctx}/cms/category/sort",
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
			url:"${ctx}/cms/category/sort",
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