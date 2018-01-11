<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
    <title>定义问题管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
    function refresh(){//刷新或者排序，页码不清零
        window.location="${ctx}/dm/defineIssue/list";
    }
    /*分页信息*/
	function page(n, s) {
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
            <h5>定义问题列表 </h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
    </div>
    <div class="ibox-content">
       <sys:message content="${message}"/>
     <!-- 分页查询表单 -->
	<div class="row">
		<div class="col-sm-12">
			<form:form id="searchForm"  action="${ctx}/dm/defineIssue/list" method="post" class="form-inline">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			</form:form>
		</div>
	</div>
	        <!-- 工具栏 -->
	    <div class="row">
		    <div class="col-sm-12">
		        <div class="pull-left">
<%--                 <a href="${ctx}/dm/defineIssue/index" class="btn btn-info"> <span class="glyphicon glyphicon-plus"></span>增加</a> --%>
<%-- 		        <a href="${ctx}/dm/defineIssue/index" class="btn btn-info"><span class="glyphicon glyphicon-edit"></span> 编辑</a> --%>
<%-- 		        <a href="${ctx}/dm/defineIssue/index"  class="btn btn-info"><span class="glyphicon glyphicon-remove"></span>删除</a> --%>
	                <table:addRow url="${ctx}/dm/defineIssue/formList" title="问题定义" width="1000px" height="700px" ></table:addRow><!-- 增加按钮 -->  
 		            <table:delRow url="${ctx}/dm/defineIssue/deleteAll" id="contentTable" ></table:delRow><!-- 删除按钮 -->
 		            <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="refresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		        </div>
		    </div>
	    </div>
	    
	    <table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
	        <thead>
	            <tr>
	                <th><input type="checkbox" class="i-checks"></th>
	                <th>主题</th>
	                <th>优先级</th>
	                <th>操作</th>
	            </tr>
	        </thead>
	        <tbody id="defineIssueList">
	            <c:forEach items="${page.list}"  var="list"> 
	               <tr> 
	                 <td><input type="checkbox" id="${list.id}" class="i-checks"></td>
	                 <td>${list.topic }</td>
	                 <td>${list.dictType.id }</td>
	                 <td>
	                   <a href="#" onclick="openDialogView('查看定义问题', '${ctx}/dm/defineIssue/get?id=${list.id}','600px', '700px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
	                   <a href="#" onclick="openDialog('修改定义问题', '${ctx}/dm/defineIssue/formList?id=${list.id}','1000px', '700px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
	                   <a href="${ctx}/dm/defineIssue/delete?id=${list.id}" onclick="return confirmx('确认要删除该问题定义吗？', this.href)" class="btn  btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
	                 </td>
	               </tr>
 	            </c:forEach> 
	        </tbody>
	    </table>
	 </div>
	 <!-- 分页代码 -->
	<table:page page="${page}"></table:page>
    </div>
    </div>
</body>
</html>