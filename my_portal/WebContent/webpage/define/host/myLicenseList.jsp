<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>用户管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {
	    $("#btnImportPhoto").click(function(){
	        top.layer.open({
	            type: 1, 
	            area: [500, 300],
	            title:"学生头像上传",
	            content:$("#importPhotoBox").html() ,
	            btn: ['确定', '关闭'],
	            btn1: function(index, layero){
	                    var inputForm =top.$("#importForm");
	                    inputForm.attr("target","studentContent");//表单提交成功后，从服务器返回的url在当前tab中展示
	                    top.$("#importForm").submit();
	                    top.layer.close(index);
	              },
	             
	              btn2: function(index){ 
	                  top.layer.close(index);
	               },
	            success: function(){
	            }
	        }); 
	    });
	});
	
</script>
</head>
<body>
	<div class="wrapper wrapper-content">
		<sys:message content="${message}" />
		<!-- 查询条件 -->
		<div class="row">
			<div class="col-sm-12">
				<form:form id="searchForm" modelAttribute="licenseInfo"
					action="${ctx}/pluginjsp/host/license/myLicense" method="post"
					class="form-inline">
					<input id="pageNo" name="pageNo" type="hidden"
						value="${page.pageNo}" />
					<input id="pageSize" name="pageSize" type="hidden"
						value="${page.pageSize}" />
					<table:sortColumn id="orderBy" name="orderBy"
						value="${page.orderBy}" callback="sortOrRefresh();" />
					<!-- 支持排序 -->
					<div class="form-group">
						<span>插件：</span>
						<select id="pluginCode" name="pluginCode" class="form-control input-sm" style="width: 150px;padding:0">
						      <option value="">--请选择--</option>
						      <c:forEach items="${plugins}" var="plugin">
						      <option value="${plugin.code }" <c:if test='${plugin.code == licenseInfo.pluginCode}'>selected="selected"</c:if>>${plugin.name }</option>
						      </c:forEach>
						</select>
						
					</div>
				</form:form>
				<br />
			</div>
		</div>

		<!-- 工具栏 -->
		<div class="row">
			<div class="col-sm-12">
				<div class="pull-left">
					
					<button class="btn btn-white btn-sm " data-toggle="tooltip"
						data-placement="left" onclick="sortOrRefresh()" title="刷新">
						<i class="glyphicon glyphicon-repeat"></i> 刷新
					</button>

				</div>
				<div class="pull-right">
					<button class="btn btn-primary btn-rounded btn-outline btn-sm "
						onclick="search()">
						<i class="fa fa-search"></i> 查询
					</button>
					<button class="btn btn-primary btn-rounded btn-outline btn-sm "
						onclick="reset()">
						<i class="fa fa-refresh"></i> 重置
					</button>
				</div>
			</div>
		</div>

		<table id="contentTable"
			class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
			<thead>
				<tr>
					<!-- <th><input type="checkbox" class="i-checks"></th> -->
					<th class="plugin_name">插件名称</th>
					<th class="plugin_code">插件编码</th>
					<th class="licenseMsg">证书状态</th>
					<th class="licenseMsg">生成时间</th>
					<th class="id_no">到期时间</th>
					<th class=" createDate">上传时间</th>
					<th class=" createBy">上传人</th>
					<!-- <th>操作</th> -->
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${page.list}" var="plugin">
					<tr>
						<!-- <td> <input type="checkbox" id="${user.id}" class="i-checks"></td> -->
						<td>${plugin.pluginName}</td>
						<td>${plugin.pluginCode}</td>
						<td>${plugin.licenseMsg}</td>
						<td><c:if test="${not empty plugin.pluginLicense}"><fmt:formatDate value="${plugin.pluginLicense.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if></td>
						<td><c:if test="${not empty plugin.pluginLicense}"><fmt:formatDate value="${plugin.pluginLicense.endDate}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if></td>
						<td><fmt:formatDate value="${plugin.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td>${plugin.createBy.name}</td>
						<!-- <td></td> -->
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<table:page page="${page}"></table:page>
	</div>
</body>
</html>