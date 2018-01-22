<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>应用管理</title>
<meta name="decorator" content="default"/>
<style type="text/css">  
	 #preview, img { 
	 	border:1px solid #e5e6e7;  
		 border-radius:5px; 
		 width:100px;  
		 height:100px;  
	 }
	 #preview,.bannerImg {  
		 border:1px solid #e5e6e7;  
		 border-radius:5px;
		 width:100px;  
		 height:100px; 
   	 } 
   	 .addTitle{
   	 	font-size: 16px;
   	 	text-align: right;
   	 } 
</style>
<script src="${ctxStatic}/portal/js/ajaxfileupload01.js"></script>
<script src="${ctxStatic}/layer-v2.3/layer/layer.js"></script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>应用列表 </h5>
		</div>
    <div class="ibox-content">
	<sys:message content="${message}"/>
	<!-- 工具栏 -->
	<div class="row">
		<div class="col-sm-12">
		    <div class="pull-left">
				<!--查询条件-->
		         <form:form id="searchForm" modelAttribute="frontApp" action="${ctx}/portal/frontApp" method="post" class="form-inline">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
					<div class="form-group">
						<span>标题：</span>
							<form:input path="appName" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
					        <span>状态：</span>
					            <form:radiobuttons path="disable" class="i-checks" items="${fns:getDictList('able')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					 </div>	
				 </form:form>
		     </div>
		     <div class="pull-left" style="margin-left:5px;">
			    <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			     <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
	         </div>
			<div class="pull-right">
				<shiro:hasPermission name="portal:frontAPP:add">
					<button class="btn btn-white btn-sm " onclick="newApp()" >
						<i class="glyphicon glyphicon-plus"></i>添加</button><!-- 增加按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="portal:frontAPP:del">
					<table:delRow url="${ctx}/portal/frontApp/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
				</shiro:hasPermission>
		       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新">
		       			<i class="glyphicon glyphicon-repeat"></i> 刷新</button>
			</div>
		</div>
	</div>
	
	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th>排序</th>
				<th>应用名称</th>
				<th>应用图标</th>
				<th>是否禁用</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="app" varStatus="status" >
			<tr data-id="${app.id}">
				<td> <input type="checkbox" id="${app.id}" class="i-checks"></td>
				<td>${app.sort}</td>
				<td>${app.appName}</td>
				<td><img alt="banner" src="${app.appImg}" style="width: 50px; height: 50px;"></td>
				<td>
					<c:if test="${app.disable eq '1'}"><span class="btn-primary btn-sm">已启用</span></c:if>
					<c:if test="${app.disable eq '2' or empty app.disable}">
						<span class="btn-danger btn-sm">已禁用</span></c:if>
				</td>
				<td>
				<shiro:hasPermission name="portal:frontAPP:edit">
   					<a onclick="newApp('${app.id}')" class="btn btn-success btn-sm" ><i class="fa fa-edit"></i> 修改</a>
    			</shiro:hasPermission>
				<shiro:hasPermission name="portal:frontAPP:edit">
					<a href="${ctx}/portal/frontApp/disable?id=${app.id}" onclick="return confirmx('确认要禁用/启用该应用吗？', this.href)"
						class="btn ${app.disable eq '1' ? 'btn-warning' : 'btn-primary'} btn-sm" >
						<i class="fa ${app.disable eq '1' ? 'fa-lock' : 'fa-unlock'}"></i>
								${app.disable eq '1' ? '禁用' : '启用'}</a>
				</shiro:hasPermission>
    			<shiro:hasPermission name="portal:frontAPP:del">
					<a href="${ctx}/portal/frontApp/delete?id=${app.id}" 
						onclick="return confirmx('确认要删除该应用吗？', this.href)" class="btn btn-danger btn-sm"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
<%-- 					<c:if test="${status.index != 0}"> --%>
<!-- 						<a class="btn btn-info btn-sm" onclick="moveUp(this)"> -->
<!-- 							<i class="fa fa-arrow-circle-up"></i> 上移</a> -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${status.index < page.list.size()-1}"> --%>
<!-- 						<a class="btn btn-info btn-sm" onclick="moveDown(this)"> -->
<!-- 							<i class="fa fa-arrow-circle-down"></i> 下移</a> -->
<%-- 					</c:if> --%>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
	<br/>
	<div style="width: 700px; padding: 20px 0; display: none" class="container" id="addApp">
		<form id="myForm">
			<div class="row">
				<div class="form-group mt15 col-sm-12">
					<label class="col-sm-3 control-label addTitle"><span style="color: red">*</span>名称：</label>
					<div class="col-sm-8">
						<input type="text" class="form-control required" id="appNames">
					</div>
				</div>
			</div>
			<div class="row">
				<input type="hidden" id="id">
				<div class="form-group mt15 col-sm-12">
					<label class="col-sm-3 control-label addTitle">图标：</label>
					<div class="col-sm-9">
						<div class="row">
							<div class="col-sm-3">
								<div id="preview"></div>
							</div>
							<div class="col-sm-9"> 
								<button name="button" type="button" class="btn btn-primary"
											onclick="file.click();">上传</button>
								<input type="file" id="file" name="file"
									accept="image/jpeg,image/jpg,image/png"
									onchange="preview(this)" style="display: none">
								<p style="color:gray">注：图片小于1M,尺寸为100x100</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group mt15 col-sm-12">
					<label class="col-sm-3 control-label addTitle">应用地址：</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="appUrl">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group mt15 col-sm-12"> <!-- style="font-size: 16px;text-align: right;" -->
					<label class="col-sm-3 control-label addTitle">排序：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" onkeyup="value=value.replace(/[^1234567890-]+/g,'')" style="width: 50px;" id="sort">
					</div>
				</div>
			</div>
			<div class="row">
					<div class="col-md-3 col-md-offset-6">
						<a class="btn btn-primary" id="appSave">保存</a>
					</div>
			</div>
		</form>
	</div>
</div>
</div>
</div>
 
<script type="text/javascript">    
function preview(file) {  
	var prevDiv = document.getElementById('preview');  
	if (file.files && file.files[0]) {  
		var reader = new FileReader();  
		reader.onload = function(evt){  
			prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';  
		}    
 		reader.readAsDataURL(file.files[0]);  
	} else {  
		prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';  
	}  
}
function newApp(id) {
	var str = (id !=''&&id != null) ? "修改应用" : "新增应用";
	layer.open({
		type : 1,
		title : str,
		area : [ '740px', '445px' ],
		content : $("#addApp"),
		success : function() {
			$("#preview").empty();
			$("input").val("");
			if (id != ''&&id != null) {
				$.ajax({
					url : "${ctx}/portal/frontApp/form",
					type : "POST",
					data : {
						id : id
					},
					success : function(data) {
						var app = data.body.app;
						$("#preview").append("<img src='"+app.appImg+"' class='bannerImg' />");
						$("#appNames").val(app.appName);
						$("#appUrl").val(app.appUrl);
						$("#id").val(app.id);
						$("#sort").val(app.sort);
					}
				})
			}
		},
	});
}
$(function() {
	
	$("#appSave").on( "click", function() {
		var appNameV = $("#appNames").val();
		var fileV = $("#file").val();
		var urlV = $("#appUrl").val();
		var sortV = $("#sort").val();
		var idV= $("#id").val();
		 var flag = cmsBannerValidate(fileV,urlV,sortV,appNameV);
         if (!flag){
        	 return false;
         }
		$.ajaxFileUpload({
			url : "${ctx}/portal/frontApp/save",
			type : "POST",
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			data : {
				id : idV,
				appName : appNameV,
				appUrl : urlV,
				sort : sortV
			},
			fileElementId : 'file', //这里对应html中上传file的id
			contentType : 'application/json;charset=UTF-8',
			success : function(data) {
				layer.msg(data, {
					icon : 1,
					time : 500
				}, function() {
					window.location.reload();
				});
			}
		})
	})
})
function moveUp(obj) { 
	var objParentTR = $(obj).parent().parent(); 
	var prevTR = objParentTR.prev(); 
	if (prevTR.length > 0) { 
		$.ajax({
			url:"${ctx}/portal/frontApp/sort",
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
			url:"${ctx}/portal/frontApp/sort",
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

function cmsBannerValidate(a1,b1,c1,d1){
	var flag = true;
	if (d1 == '') {
		layer.msg("应用名称不能为空 ",{icon : 5,time : 2000});
		flag =  false;
		return false;
	}
	if (a1 == '' && $("#preview").html()=='') {
		layer.msg("上传图片不能为空",{icon : 5,time : 2000});
		flag =  false;
		return false;
	}
	if (b1== ''){
		
		layer.msg("应用地址不能为空",{icon : 5,time : 2000});
		$("#description").focus();
		flag =  false;
		return false;
	}
	if (c1== ''){
		layer.msg("排序不能为空",{icon : 5,time : 2000});
		$("#sort").focus();
		flag =  false;
	}
	
	return flag;
}
</script>
</body>
</html>