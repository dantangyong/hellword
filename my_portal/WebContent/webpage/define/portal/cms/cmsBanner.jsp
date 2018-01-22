<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>banner管理</title>
<meta name="decorator" content="default"/>
<style type="text/css">  
	 #preview, img {  
		 width:300px;  
		 height:150px;  
	 }
	 #preview,.bannerImg {  
		 border:1px solid #666;  
		 border-radius:5px;
		 width:300px;  
		 height:150px; 
   	 }  
</style>
<script src="${ctxStatic}/portal/js/ajaxfileupload01.js"></script>
<script src="${ctxStatic}/layer-v2.3/layer/layer.js"></script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>banner列表 </h5>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<form:form id="searchForm" modelAttribute="cmsBanner" action="${ctx}/portal/cmsBanner" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
	</form:form>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-right">
			<shiro:hasPermission name="cms:banner:add">
				<button class="btn btn-white btn-sm " onclick="newBanner()" title="banner">
					<i class="glyphicon glyphicon-plus"></i>添加</button><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="cms:banner:del">
				<table:delRow url="${ctx}/portal/cmsBanner/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
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
				<th>排序</th>
				<th>配文</th>
				<th>是否禁用</th>
				<th>图片路径</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsBanner" varStatus="status" >
			<tr data-id="${cmsBanner.id}">
				<td> <input type="checkbox" id="${cmsBanner.id}" class="i-checks"></td>
				<td>${cmsBanner.sort}</td>
				<td>${cmsBanner.description}</td>
				<td>
					<c:if test="${cmsBanner.disable eq '1'}"><span class="btn-primary btn-sm">已启用</span></c:if>
					<c:if test="${cmsBanner.disable eq '2'}"><span class="btn-danger btn-sm">已禁用</span></c:if>
				</td>
				<td><img alt="banner" src="${cmsBanner.imageUrl}" style="width: 200px; height: 50px;"></td>
				<td>
				<shiro:hasPermission name="cms:banner:edit">
   					<a onclick="newBanner('${cmsBanner.id}')" class="btn btn-success btn-sm" ><i class="fa fa-edit"></i> 修改</a>
    			</shiro:hasPermission>
				<shiro:hasPermission name="cms:banner:edit">
					<a href="${ctx}/portal/cmsBanner/disable?id=${cmsBanner.id}" onclick="return confirmx('确认要禁用/启用该banner吗？', this.href)"
						class="btn ${cmsBanner.disable eq '1' ? 'btn-warning' : 'btn-primary'} btn-sm" >
						<i class="fa ${cmsBanner.disable eq '1' ? 'fa-lock' : 'fa-unlock'}"></i>
								${cmsBanner.disable eq '1' ? '禁用' : '启用'}</a>
				</shiro:hasPermission>
    			<shiro:hasPermission name="cms:banner:del">
					<a href="${ctx}/portal/cmsBanner/delete?id=${cmsBanner.id}" 
						onclick="return confirmx('确认要删除该banner吗？', this.href)" class="btn btn-danger btn-sm"><i class="fa fa-trash"></i> 删除</a>
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
	<div style="width: 700px; padding: 20px 0; display: none" class="container" id="addBanner">
	   <form  id="bannerValidate">
		<div class="row">
			<input type="hidden" id="id">
			<div class="form-group mt15 col-sm-12">
				<label class="col-sm-2 control-label" style="font-size: 16px"><span style="color:red">* </span>图片：</label>
				<div class="col-sm-10">
					<div class="row">
						<div class="col-sm-7">
							<div id="preview"></div>
						</div>
						<div class="col-sm-5">
							<button name="button" type="button" class="btn btn-primary"
										onclick="file.click();">上传</button>
							<input type="file" id="file" name="file"
								accept="image/jpeg,image/jpg,image/png"
								onchange="preview(this)" style="display: none">
							<p style="color:gray">图片小于2M,尺寸为1920x500</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="form-group mt15 col-sm-12">
				<label class="col-sm-2 control-label" style="font-size: 16px"><span style="color:red">* </span>配文：</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="description">
				</div>
			</div>
		</div>
		<div class="row">
			<div class="form-group mt15 col-sm-12">
				<label class="col-sm-2 control-label" style="font-size: 16px"><span style="color:red">* </span>排序：</label>
				<div class="col-sm-10">
					<input type="text" class="form-control required" onkeyup="value=value.replace(/[^1234567890-]+/g,'')" style="width:50px;display:inline-block;" id="sort">
				    <span class="help-inline">设置前台视频轮播图显示顺序</span>
				</div>
				
			</div>
		</div>
		<div class="row">
			<div style="text-align:center">
				<a class="btn btn-info" style="margin-right:10px" id="bannerSave">保存</a>
				<a class="btn btn-default" onclick="closeLayer()" >关闭</a>
			</div>
                  
		</div>
		</form>
	</div>
	</div>
	</div>
</div>
 
<script type="text/javascript">
	 
function closeLayer(){
	layer.closeAll();
}
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
function newBanner(id) {
	var str = (id !=''&&id != null) ? "修改banner" : "新增banner";
	$("#sort").val('');
	layer.open({
		type : 1,
		title : str,
		area : [ '740px', '450px' ],
		content : $("#addBanner"),
		success : function() {
			$("#preview").empty();
			$("#description").val("");
			if (id != ''&&id != null) {
				$.ajax({
					url : "${ctx}/portal/cmsBanner/edit",
					type : "POST",
					data : {
						id : id
					},
					success : function(data) {
						var banner = data.body.banner;
						$("#preview").append("<img src='"+banner.imageUrl+"' class='bannerImg' />");
						$("#description").val(banner.description);
						$("#id").val(banner.id);
						$("#sort").val(banner.sort);
					}
				})
			}
		},
	});
}

function cmsBannerValidate(a1,b1,c1){
	var flag = true;
	if (a1 == '' && $("#preview").html()=='') {
		layer.msg("上传图片不能为空",{icon : 5,time : 2000});
		flag =  false;
		return false;
	}
	if (b1== ''){
		
		layer.msg("配文不能为空",{icon : 5,time : 2000});
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
$(function() {
	$("#bannerSave").on( "click", function() {
		var fileV = $("#file").val();
		var descV = $("#description").val();
		var sortV = $("#sort").val();
		var idV= $("#id").val();
        var flag = cmsBannerValidate(fileV,descV,sortV);
         if (!flag){
        	 return false;
         }
		$.ajaxFileUpload({
			url : "${ctx}/portal/cmsBanner/save",
			type : "POST",
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			data : {
				id : idV,
				description : descV,
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
			url:"${ctx}/portal/cmsBanner/sort",
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
			url:"${ctx}/portal/cmsBanner/sort",
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