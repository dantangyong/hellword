]<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>角色授权（应用）</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="wrapper wrapper-content ">
	<sys:message content="${message}"/>
	
	<div class="row">
	<div class="col-sm-12">
		<div class="form-group">
			<span>${role.name }</span>
			<input type="hidden" id="roleId" value="${role.id}" />
		</div>	
	<br/>
	</div>
	</div>	
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<thead>
					<tr>
						<th class="sort-column login_name">应用名称</th>
						<th class="sort-column name">系统配置</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="roleAuth">
						<tr appid="${roleAuth.app.id}">
							<td> ${roleAuth.app.appName} </td>
							<td>
								<c:if test="${roleAuth.accessAuth eq '1'}">
									<input type="checkbox" class="i-checks accessAuth" checked="checked">访问权限</c:if>
								<c:if test="${empty roleAuth.accessAuth or roleAuth.accessAuth ne '1'}">
									<input type="checkbox" class="i-checks accessAuth">访问权限</c:if></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		
		<shiro:hasPermission name="unifiedAuth:role:save">
			<c:if test="${ not empty list}">
				<button class="btn btn-primary  btn-sm " onclick="save()">提交</button>
			</c:if>
		</shiro:hasPermission>
	</div>
<script type="text/javascript">
	function save(){
		var trs=$("#contentTable tbody").find("tr");
		   var list=[];
		   for(var i=0;i<trs.length;i++){
			   var tr=$(trs[i]);
			   var accessAuth=tr.find(".accessAuth").is(':checked');
			   if(accessAuth){
				   list.push({
					   roleId:$("#roleId").val(),
					   appId:tr.attr("appid"),
					   accessAuth:"1"
				   });
			   }
		   }
	        $.ajax({
	            type: "POST",
	            url: "${ctx}/portal/auth/saveRole",
	            data : {
	            	authRoleForm:JSON.stringify(list),
	            	id:$("#roleId").val(),
	            },
	            dataType: "JSON",
	            success: function(data){
	            	 if(data.success){
	                	  layer.msg('保存成功', {
	                          icon : 1,
	                          time : 2000
	                      });
	                  }else{
	                	  layer.msg('保存出错', {
	                          icon : 5,
	                          time : 2000
	                      });
	                  }
	            }
	        });
		}
	</script>
</body>
</html>