<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
    <title>定义问题管理</title>
    <meta name="decorator" content="default"/>
   
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
	        <!-- 工具栏 -->
	    <div class="row">
		    <div class="col-sm-12">
		        <div class="pull-left">
<%--                 <a href="${ctx}/dm/defineIssue/index" class="btn btn-info"> <span class="glyphicon glyphicon-plus"></span>增加</a> --%>
<%-- 		        <a href="${ctx}/dm/defineIssue/index" class="btn btn-info"><span class="glyphicon glyphicon-edit"></span> 编辑</a> --%>
<%-- 		        <a href="${ctx}/dm/defineIssue/index"  class="btn btn-info"><span class="glyphicon glyphicon-remove"></span>删除</a> --%>
	                <table:addRow url="${ctx}/dm/defineIssue/formIndex" title="问题定义" width="1000px" height="700px" ></table:addRow><!-- 增加按钮 -->  
 		            <table:delRow url="${ctx}/dm/defineIssue/deleteAll" id="contentTable" ></table:delRow><!-- 删除按钮 -->
 		            <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="searchDefineIssue()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
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
	        </tbody>
	    </table>
	 </div>
    </div>
    </div>
 <script type="text/javascript">
    
    $(document).ready(function() {
    	searchDefineIssue();
    })
    /*分页信息*/
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		searchDefineIssue();
		return false;
	}
    
    /*列表信息 */
	function searchDefineIssue(){
		var pageNo = $("#pageNo").val();
		var pageSize = $("#pageSize").val();
		$.ajax({
			type : "POST",
			url : "${ctx}/dm/defineIssue/list",
			data : {
				pageNo:pageNo,
				pageSize:pageSize
			},
			success : function(date) {
				$("#defineIssueList").empty();
				$("#defineIssueList").html(date);
			}
		});
	}
	
    
    </script>
</body>
</html>