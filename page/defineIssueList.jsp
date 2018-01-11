<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<c:forEach items="${page.list}" var="list">
	<tr>
		<td>
		    <input type="checkbox" id="${list.id}" class="i-checks">
		</td>
		<td>${list.topic }</td>
		<td>${list.dictType.label }</td>
		<td><a href="#"
			onclick="openDialogView('查看定义问题', '${ctx}/dm/defineIssue/get?id=${list.id}','600px', '700px')"
			class="btn btn-info btn-xs"><i class="fa fa-search-plus"></i> 查看</a>
			<a href="#"
			onclick="openDialog('修改定义问题', '${ctx}/dm/defineIssue/formIndex?id=${list.id}','1000px', '700px')"
			class="btn btn-success btn-xs"><i class="fa fa-edit"></i> 修改</a> <a
			href="${ctx}/dm/defineIssue/delete?id=${list.id}"
			onclick="return confirmx('确认要删除该问题定义吗？', this.href)"
			class="btn  btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a></td>
	</tr>
</c:forEach>
<tr>
	<td colspan="4">
	    <table:page page="${page}"></table:page> 
	</td>
</tr>
<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
<script src="/mht_dm/static/iCheck/icheck.min.js"></script>
<script src="/mht_dm/static/iCheck/icheck-init.js"></script>