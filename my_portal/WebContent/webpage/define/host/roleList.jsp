<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>角色管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/webpage/include/treetable.jsp" %>
	<script type="text/javascript">
		function refresh(){//刷新或者排序，页码不清零
			window.location="${ctx}/pluginjsp/host/plugins/roleList";
    	}
		function saveAuth(id,auths){
			loading('正在保存，请稍等...');  
            //var name=$this.attr("pluginName")
            $.ajax({
                type: "GET",
                url: "${ctx}/plugin/host/plugins/api/saveAuth",
                data: {id:id,authStr:JSON.stringify(auths)},
                dataType: "json",
                success: function(data){
                    closeTip();
                    if(data.code=="0"){
                        layer.msg(data.msg,{icon:1,time:1000});
                    }else{
                        layer.msg(data.msg,{icon:2,time:1000});
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown){
                    closeTip();
                    top.layer.confirm(XMLHttpRequest.responseText, {icon: 2, title:'系统提示'});
                }
                
            });
		}
		$(function(){
			 $(".plugin-auth").click(function(){
	                var $this=$(this);
	                var url="${ctx}/pluginjsp/host/plugins/authorityTree?id=";
	                    url+=$this.attr("roleId");
	                // 正常打开 
	                top.layer.open({
	                    type: 2, 
	                    area: ['300px', '420px'],
	                    title:"选择插件权限",
	                    //ajaxData:{selectIds: $("#officeId").val()},
	                    content: url ,
	                    btn: ['确定', '关闭']
	                       ,yes: function(index, layero){ //或者使用btn1
	                                var tree = layero.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
	                                var nodes = [];
	                                var auths=[];
	                                nodes = tree.getCheckedNodes(true);
	                                for(var i=0; i<nodes.length; i++) {//
	                                	auths.push(nodes[i].obj);
	                                }
	                                //console.log(auths);
	                                if(auths){
	                                	saveAuth($this.attr("roleId"),auths);
	                                }
	                                top.layer.close(index);
	                                       },
	                cancel: function(index){ //或者使用btn2
	                           //按钮【按钮二】的回调
	                       }
	                }); 
	            
	            });
		});
		
	</script>
</head>
<body>
	<div class="wrapper wrapper-content">
	<sys:message content="${message}"/>
	<div class="row">
    <div class="col-sm-12">
    <form:form id="searchForm" modelAttribute="role" action="${ctx}/pluginjsp/host/plugins/roleList" method="post" class="form-inline">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <form:input path="parent.id" htmlEscape="false" type="hidden" />
        <form:input path="parentIds" htmlEscape="false" type="hidden" />
        <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
    </form:form>
    </div>
    </div>
		<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
	
	</div>
	</div>
	<table id="treeTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead><tr>
		<th>角色名称</th>
		<th>角色编码</th>
		<th>备注</th>
		<shiro:hasPermission name="plugin:host:plugins:authority:save"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody id="treeTableList"><c:forEach items="${page.list}" var="row">
		  <tr id="${row.id }" pId="${row.parent.id }">
            <td>${row.name}</td>
            <td>${row.enname}</td>
            <td>${fns:abbr(row.remarks,50)}</td>
            <td>
                        <shiro:hasPermission name="plugin:host:plugins:authority:save"> 
                        <a href="javascript:void(0);" roleId="${row.id }" class="btn btn-primary btn-xs plugin-auth" ><i class="fa fa-edit"></i> 权限设置</a> 
                        </shiro:hasPermission>
                        
            </td>
        </tr></c:forEach>
		</tbody>
	</table>
	<table:page page="${page}"></table:page>
	</div>
</body>
</html>