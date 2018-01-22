<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>用户管理</title>
<meta name="decorator" content="default" />
</head>
<body>
	<div class="wrapper wrapper-content">
		<sys:message content="${message}" />
		<!-- 查询条件 -->
		<div class="row">
			<div class="col-sm-12">
				<form:form id="searchForm" modelAttribute="user"
					action="${ctx}/sys/user/list" method="post" class="form-inline">
					<div class="form-group">
						<span>${user.name }</span> <input type="hidden" id="userId"
							value="${user.id }" />
					</div>
				</form:form>
				<br />
			</div>
		</div>

		<table id="contentTable"
			class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
			<thead>
				<tr>
					<th class="sort-column login_name">系统名称</th>
					<th class="sort-column name">系统配置</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="appUser">
					<tr appid="${appUser.app.id}">
						<td>${appUser.app.appName}</td>
						<td>
							<c:if test="${appUser.accessAuth eq '1'}">
								<input type="checkbox" class="i-checks accessAuth"
									 checked="checked">访问权限</c:if>
							<c:if test="${empty appUser.accessAuth or appUser.accessAuth ne '1'}">
								<input type="checkbox" class="i-checks accessAuth">访问权限</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<shiro:hasPermission name="unifiedAuth:user:save">
			<button class="btn btn-primary"
				onclick="save()">提交</button>
		</shiro:hasPermission>
	</div>
	<script type="text/javascript">
		function save() {
			var trs = $("#contentTable tbody").find("tr");
			var list = [], close = [];
			var userId = $("#userId").val();
			for (var i = 0; i < trs.length; i++) {
				var tr = $(trs[i]);
				var accessAuth = tr.find(".accessAuth").is(':checked');
				//alert(accessAuth);
				if (accessAuth) {
					list.push({
						userId : userId,
						appId : tr.attr("appid"),
						accessAuth : "1"
					});
				}
			}
			$.ajax({
				type : "POST",
				url : "${ctx}/portal/auth/saveUser",
				data : {
					authUserForm : JSON.stringify(list),
					userId : userId
				},
				dataType : "json",
				success : function(data) {
					if (data.success) {
						layer.msg('保存成功', {
							icon : 1,
							time : 2000
						});
					} else {
						layer.msg('保存出错', {
							icon : 3,
							time : 2000
						});
					}
				}
			});
			//alert(trs.length);
		}
	</script>
</body>
</html>