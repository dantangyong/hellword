<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>视频管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	.title-top {padding:10px;}.i-width{
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
				<h5>视频列表 </h5>
	   </div>
	<div class="ibox-content">
	    <sys:message content="${message}"/>
        <div class="row">
			<div class="col-sm-12">
			   <div class="pull-left">
					<!--查询条件-->
					<form:form id="searchForm" modelAttribute="cmsVideo" action="${ctx}/cms/video/highSearch" method="post" class="form-inline">
						<input id="pageNo" name="pageNo" type="hidden" value="1"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
						<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
						<div class="form-group">
							<label>标题：</label>
							<div class="input-group">
							<form:input path="videoName" htmlEscape="false" maxlength="50" class="form-control input-sm" />
<!-- 								<span class="input-group-btn"><input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;&nbsp;</span> -->
							</div>&emsp;
							<label>是否可用：</label>
							<div class="input-group">
								<form:select id="disable" path="disable" class="form-control input-md">
									<option value="" >全部</option>
									<form:options items="${fns:getDictList('able')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
								<%-- <form:select path="disable" itemValue="value" items="${fns:getDictList('able')}" 
				 					htmlEscape="false" class="form-control input-md"/>  --%>
							</div>&emsp;
							<label>视频分类：</label>
							<div class="input-group">
							<form:select id="videoType.id" path="videoType.id"  class="form-control input-md">
									<option value="" >--全部--</option>
									<form:options items="${videoTypes }" itemLabel="typeName" itemValue="id" htmlEscape="false"/>
								</form:select>
							</div>&emsp;
							<label>是否推荐：</label>
							<div class="input-group">
							<form:select id="videoPriority" path="videoPriority" cssStyle="width:100px;" class="form-control input-md">
									<option value="" >全部</option>
									<form:options items="${fns:getDictList('recommend')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
<%-- 									<form:options items="${authors }" itemLabel="name" itemValue="id" htmlEscape="false"/> --%>
								</form:select>
							</div>
						</div>	
					</form:form>
			   </div>
			   <div class="pull-left" style="margin-left:5px;">
			    <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			     <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
			   </div>
			<div class="pull-right">
					<shiro:hasPermission name="cms:video:add">
						<a class="btn btn-white btn-sm " href="${ctx}/cms/video/form" title="视频" ><i class="fa fa-plus"></i>增加</a><!-- 增加按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="cms:video:del">
					    <table:delRow url="${ctx}/cms/video/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
					</shiro:hasPermission>
			       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
			 </div>
			
			</div>
		</div>
	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
			    <th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column a.sort">排序</th>
				<th  class="sort-column a.video_name">视频标题</th>
				<th  class="sort-column a.video_type_id">视频分类</th>
				<th  class="sort-column a.create_by">发布作者</th>
				<th  class="sort-column a.hits">点击量</th>
				<th  class="sort-column a.disable">是否可用</th>
				<th  class="sort-column a.video_priority">是否推荐</th>
				<th  class="sort-column a.update_date">更新日期</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsVideo" varStatus="status">
			<tr data-id="${cmsVideo.id}">
			    <td> <input type="checkbox" id="${cmsVideo.id}" class="i-checks"></td>
				<td>
					${cmsVideo.sort}
				</td>
				<td>${cmsVideo.videoName}</td>
				<td>${cmsVideo.videoType.typeName}</td>
				<td>${cmsVideo.createBy.name}</td>
				<td>${cmsVideo.hits}</td>
				<td>
					<c:if test="${cmsVideo.disable eq '1' }"><span class="btn-primary btn-sm">已启用</span></c:if>
					<c:if test="${cmsVideo.disable ne '1' or empty cmsVideo.disable }"><span class="btn-danger btn-sm">已禁用</span></c:if>
				</td>
				<td>
					<c:if test="${cmsVideo.videoPriority eq '1' }"><span class="btn-primary btn-sm">已推荐</span></c:if>
					<c:if test="${cmsVideo.videoPriority ne '1' or empty cmsVideo.videoPriority }"><span class="btn-danger btn-sm">未推荐</span></c:if>
				</td>
				<td>
					<fmt:formatDate value="${cmsVideo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<shiro:hasPermission name="cms:video:edit">
						<a href="${ctx}/cms/video/form?id=${cmsVideo.id}" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="cms:video:edit">
						<c:if test="${cmsVideo.disable eq '1' }">
    						<a href="${ctx}/cms/video/disable?id=${cmsVideo.id}" onclick="return confirmx('确认要禁用该视频吗？', this.href)" 
    							class="btn btn-warning btn-xs" ><i class="fa fa-lock i-width"></i> 禁用</a>
						</c:if>
						<c:if test="${cmsVideo.disable ne '1' or empty cmsVideo.disable }">
    						<a href="${ctx}/cms/video/disable?id=${cmsVideo.id}" onclick="return confirmx('确认要启用该视频吗？', this.href)" 
    							class="btn btn-primary btn-xs" ><i class="fa fa-unlock i-width"></i> 启用</a>
						</c:if>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="cms:video:del">
						<a href="${ctx}/cms/video/delete?id=${cmsVideo.id}" onclick="return confirmx('确认要删除该视频吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="cms:video:edit">
						<c:if test="${cmsVideo.videoPriority eq '1' }">
    						<a href="${ctx}/cms/video/recommend?id=${cmsVideo.id}" onclick="return confirmx('确认要取消推荐该视频吗？', this.href)" 
    							class="btn btn-warning btn-xs" ><i class="fa fa-thumbs-down i-width"></i>取消推荐</a>
						</c:if>
						<c:if test="${cmsVideo.videoPriority ne '1' or empty cmsVideo.videoPriority }">
    						<a href="${ctx}/cms/video/recommend?id=${cmsVideo.id}" onclick="return confirmx('确认要推荐该视频吗？', this.href)" 
    							class="btn btn-primary btn-xs" ><i class="fa fa-thumbs-up i-width"></i> 是否推荐</a>
						</c:if>
<%-- 						<c:if test="${status.index != 0}"> --%>
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
		</tbody>
	</table>
	
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
	<br/>
	</div>
 </div>
</div>
<script type="text/javascript">
function moveUp(obj) { 
	var objParentTR = $(obj).parent().parent(); 
	var prevTR = objParentTR.prev(); 
	if (prevTR.length > 0) { 
		$.ajax({
			url:"${ctx}/cms/video/sort",
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
			url:"${ctx}/cms/video/sort",
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