﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ include file="/webpage/include/head.jsp"%>
<html>
<head>
	<title>视频管理</title>
	<meta name="decorator" content="default"/>
<style>
.i-width{
	width:12px;
	}
.videoType-form{
   font-size:16px;
   height:30px;
   text-align:right;
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
	<script src="${ctxStatic}/layer-v2.3/layer/layer.js"></script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>视频列表 </h5>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12" style="height:32px;">
	<div class="pull-left">
		<form:form id="searchForm" modelAttribute="cmsVideoType" action="${ctx}/cms/videoType/" method="post" class="form-inline">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
			<div class="form-group">
				<label>标题：</label>
				<div class="input-group">
	<!-- 			<span>角色名称：</span> <input type="text" class=" form-control input-sm" id="searchRoleName" /> -->
				<form:input path="typeName" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
				</div>
				&emsp;
				<label>是否可用：</label>
				<div class="input-group">
					<form:select path="disable" id="disable" class="form-control input-md">
					     <option value="" >--请选择--</option>
					    <form:options items="${fns:getDictList('able')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>	 
				</div>
				
			</div>	
		</form:form>
	</div>
	<div class="pull-left" style="margin-left:5px;">
	    <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
	    <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
	</div>
	<div class="pull-right" style="margin-top:3px;">
			<shiro:hasPermission name="cms:videoType:add">
				<button class="btn btn-white btn-sm " onclick="newType()" >
 					<i class="glyphicon glyphicon-plus"></i>添加</button>
<%--                      <shiro:hasPermission name="notice:oaNotify:add"> --%>
<%-- 				<table:addRow url="${ctx}/cms/videoType/form" title="" width="800px" height="700px"></table:addRow><!-- 增加按钮 --> --%>
<%-- 			</shiro:hasPermission> --%>
			</shiro:hasPermission>
<%-- 			<shiro:hasPermission name="cms:videoType:edit"> --%>
<%-- 			    <table:editRow url="${ctx}/cms/videoType/form" title="视频" id="contentTable"></table:editRow><!-- 编辑按钮 --> --%>
<%-- 			</shiro:hasPermission> --%>
			<shiro:hasPermission name="cms:videoType:del">
				<table:delRow url="${ctx}/cms/videoType/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="cms:videoType:import">
				<table:importExcel url="${ctx}/cms/videoType/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="cms:videoType:export">
	       		<table:exportExcel url="${ctx}/cms/videoType/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
			</div>	
	
	<br/>
	</div>
	</div>
	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column sort">排序</th>
				<th  class="sort-column typeName">分类名称</th>
				<th  class="sort-column disable">是否可用</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="videoType" varStatus="status">
			<tr data-id="${videoType.id}">
				<td> <input type="checkbox" id="${videoType.id}" class="i-checks"></td>
				<td>${videoType.sort}</td>
				<td>${videoType.typeName}</td>
				<td>
					<c:if test="${videoType.disable eq '1' }"><span style="color: green">已启用</span></c:if>
					<c:if test="${videoType.disable ne '1' or empty videoType.disable }"><span style="color: red">已禁用</span></c:if>
				</td>
				<td>
					<shiro:hasPermission name="cms:videoType:edit">
					<a onclick="newType('${videoType.id}')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="cms:videoType:edit">
						<c:if test="${videoType.disable eq '1' }">
	    					<a href="${ctx}/cms/videoType/disable?id=${videoType.id}" 
	    						onclick="return confirmx('确认要禁用该视频类别吗？', this.href)" 
	    						class="btn btn-warning btn-xs" ><i class="fa fa-lock i-width"></i> 禁用</a>
						</c:if>
						<c:if test="${videoType.disable ne '1' or empty videoType.disable }">
	    					<a href="${ctx}/cms/videoType/disable?id=${videoType.id}" 
	    						onclick="return confirmx('确认要启用该视频类别吗？', this.href)" 
	    						class="btn btn-primary btn-xs" ><i class="fa fa-unlock i-width"></i> 启用</a>
						</c:if>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="cms:videoType:del">
						<a href="${ctx}/cms/videoType/delete?id=${videoType.id}" onclick="return confirmx('确认要删除该视频类别吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
<%-- 						<c:if test="${status.index != 0}"> --%>
<!-- 						        <a class="btn btn-info btn-xs" onclick="moveUp(this)"> -->
<!-- 							    <i class="fa fa-arrow-circle-up"></i> 上移</a> -->
<%-- 					        </c:if> --%>
<%-- 					       <c:if test="${status.index < page.list.size()-1}"> --%>
<!-- 						        <a class="btn btn-info btn-xs" onclick="moveDown(this)"> -->
<!-- 							    <i class="fa fa-arrow-circle-down"></i> 下移</a> -->
<%-- 					       </c:if> --%>
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
  <div style="width: 600px; display: none" class="container" id="addType">
		<div class="row" style="margin-top: 20px;">
			<input type="hidden" id="id" name="id">
			<div class="form-group mt15 col-sm-12 videoType-form" >
				<label class="col-sm-3 control-label"><span style="color:red">* </span>分类名称：</label>
				<div class="col-sm-7" id="type-name-validate">
					<input type="text" class="form-control" id="newTypeName" name="newTypeName">
				</div>
				<span style="color:red;display:none" id="video_tips"></span>
			</div>
			<div class="form-group col-sm-12 videoType-form">
				<label class="col-sm-3 control-label"><span style="color:red">* </span>排序：</label>
				<div class="col-sm-7">
					<input type="text" class="form-control" onkeyup="value=value.replace(/[^1234567890-]+/g,'')" id="sort" name="sort">
				</div>
			
			</div>
     <input type="hidden" id="oldName" name="oldName">
		</div>
	</div>
</div>
<script type="text/javascript">


function newType(id) {
	var str = (id !=''&&id != null) ? "修改视频类型" : "新增视频类型";
	layer.open({
		type : 1,
		title : str,
		area : [ '700px', '210px' ],
		content : $("#addType"),
		btn: ['保存', '关闭'],
		yes:function(index, layero){
          var flag = validateVideoType();
            if(flag){
            	$.ajax({
					url : "${ctx}/cms/videoType/save",
					type : "POST",
					data : {
						id : $("#id").val(),
						typeName : $("#newTypeName").val(),
						sort : $("#sort").val()
					},
					success:function(data){
						layer.msg(data.msg, {
							icon : 1,
							time : 1500
						}, function() {
							window.location.reload();
						});
					}
					
				})
// 				layer.close(index);
            }
		},
//            layer.close(index);
		success : function() {
			$("input").val("");
			if (id != ''&&id != null) {
				$.ajax({
					url : "${ctx}/cms/videoType/form",
					type : "POST",
					data : {
						id : id
					},
					success : function(data) {
						var type = data.body.videoType;
						$("#newTypeName").val(type.typeName);
						$("#sort").val(type.sort);
						$("#oldName").val(type.typeName);
						$("#id").val(type.id);
					}
				})
			}
		},
	});
}
function validateVideoType(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
	var flag=checkName();
	if($("#newTypeName").val()==""){
		$("#newTypeName").focus();
	    top.$.jBox.tip('请填写视频类别 ','warning');
	    return false;
	  }else if($("#sort").val()==""){
		  $("#sort").focus();
		    top.$.jBox.tip('请填写排序 ','warning');
		    return false;
	  }else if(flag){
		 return false;
	 }else{
		 return true;
	 }
 
}

/*验证  */
   function checkName(){
	var flag =false;
		$.ajax({
			url : "${ctx}/cms/videoType/checkName",
			type : "POST",
			async :false, 
			data : {
				typeName : $("#newTypeName").val(),
				oldName :$("#oldName").val()
			},
			success:function(data){
				if (data=="true"){
					$("#video_tips").html("名称已存在");
					$("#video_tips").css("display","block");
					flag = true;
				}else{
					flag= false;
				}
			}
		})
		return flag;
   }
  $("#newTypeName").focus(function(){
	  $("#video_tips").css("display","none");
  });
</script>
<script type="text/javascript">
function moveUp(obj) { 
	var objParentTR = $(obj).parent().parent(); 
	var prevTR = objParentTR.prev(); 
	if (prevTR.length > 0) { 
		$.ajax({
			url:"${ctx}/cms/videoType/sort",
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
			url:"${ctx}/cms/videoType/sort",
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