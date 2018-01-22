<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/><style>
	.i-width{
	width:12px;
	}
	</style>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
  <div class="ibox">
    <div class="ibox-title">
		<h5>通知列表 </h5>
	</div>
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
		<!-- 查询条件 -->
	<div class="row">
	<div class="col-sm-12">
	   <div class="pull-left">
			<form:form id="searchForm" modelAttribute="newNotice" action="${ctx}/cms/notice/${oaNotify.self?'self':''}" method="post" class="form-inline">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
				<div class="form-group">
					<span>标题：</span>
						<form:input path="title" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
				        <span>状态：</span>
				            <form:radiobuttons path="status" class="i-checks" items="${fns:getDictList('able')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				 </div>	
			 </form:form>
	   </div>
	   <div class="pull-left" style="margin-left:5px;">
	    <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
	     <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
	   </div>
	<div class="pull-right">
			<shiro:hasPermission name="notice:oaNotify:add">
				<table:addRow url="${ctx}/cms/notice/form" title="通知" width="800px" height="700px"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
<%-- 			<shiro:hasPermission name="notice:oaNotify:edit"> --%>
<%-- 			    <table:editRow url="${ctx}/cms/notice/form" id="contentTable"  title="通知" width="800px" height="700px"></table:editRow><!-- 编辑按钮 --> --%>
<%-- 			</shiro:hasPermission> --%>
			<shiro:hasPermission name="notice:oaNotify:del">
				<table:delRow url="${ctx}/cms/notice/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
<%-- 			<shiro:hasPermission name="notice:oaNotify:import"> --%>
<%-- 				<table:importExcel url="${ctx}/cms/notice/import"></table:importExcel><!-- 导入按钮 --> --%>
<%-- 			</shiro:hasPermission> --%>
<%-- 			<shiro:hasPermission name="notice:oaNotify:export"> --%>
<%-- 	       		<table:exportExcel url="${ctx}/cms/notice/export"></table:exportExcel><!-- 导出按钮 --> --%>
<%-- 	       </shiro:hasPermission> --%>
	      
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		 
	 </div>
	
	
	</div>
	</div>
	<table id="contentTable" class="table table-striped table-bordered  table-hover table-condensed  dataTables-example dataTable no-footer">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th>标题</th>
				<th>状态</th>
				<th>更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaNotify">
			<tr>
				<td> <input type="checkbox" id="${oaNotify.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看通知', '${ctx}/cms/notice/${requestScope.oaNotify.self?'view':'form'}?id=${oaNotify.id}','800px', '700px')">
					${fns:abbr(oaNotify.title,50)}
				</a></td>
				<td>
					<c:if test="${oaNotify.status eq '1' }"><span class="btn-primary btn-sm">已启用</span></c:if>
					<c:if test="${oaNotify.status ne '1' or empty oaNotify.status }"><span class="btn-danger btn-sm">已禁用</span></c:if>
				</td>
				<td>
					<fmt:formatDate value="${oaNotify.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
				<c:if test="${!requestScope.oaNotify.self}">
					<shiro:hasPermission name="notice:oaNotify:view">
						<a href="#" onclick="openDialogView('查看通知', '${ctx}/cms/notice/form?id=${oaNotify.id}','800px', '700px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="notice:oaNotify:edit">
    					<a href="#" onclick="openDialog('修改通知', '${ctx}/cms/notice/form?id=${oaNotify.id}','800px', '700px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i>修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="notice:oaNotify:edit">
    					 <c:if test="${oaNotify.status eq '1' }">
    						<a href="${ctx}/cms/notice/disable?id=${oaNotify.id}" onclick="return confirmx('确认要禁用该通知吗？', this.href)" 
    							class="btn btn-warning btn-xs" ><i class="fa fa-lock i-width"></i>禁用 </a>
						</c:if>
						<c:if test="${oaNotify.status ne '1' or empty oaNotify.status }">
    						<a href="${ctx}/cms/notice/disable?id=${oaNotify.id}" onclick="return confirmx('确认要启用该通知吗？', this.href)" 
    							class="btn btn-primary btn-xs" ><i class="fa fa-unlock i-width"></i> 启用</a>
						</c:if> 
    				</shiro:hasPermission>
    				<shiro:hasPermission name="notice:oaNotify:del">
						<a href="${ctx}/cms/notice/delete?id=${oaNotify.id}" onclick="return confirmx('确认要删除该通知吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i>删除</a>
					</shiro:hasPermission>
				</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
	<br/>
	</div>
	</div>
</div>
</body>
</html>