<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>插件列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	function openCreateLicense(obj){
		var $this=$(obj);
		
		var url="${ctx}/pluginjsp/host/license/createLicense?code="+$this.attr("pluginCode");
	    top.layer.open({
	        type: 2, 
	        area: ['550px', '500px'],
	        title:"创建证书",
	        content: url ,
	        btn: ['关闭'],
	        cancel: function(index){ //或者使用btn2
	               //按钮【按钮二】的回调
	           }
	    }); 
	}
	
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content" style="height: 100%">
	<div class="ibox" style="height: 100%">
	<div class="ibox-title">
			<h5>插件列表 </h5>
			<div class="ibox-tools">
				<a class="collapse-link">
					<i class="fa fa-chevron-up"></i>
				</a>
				
				<a class="close-link">
					<i class="fa fa-times"></i>
				</a>
			</div>
	</div>
    <div class="ibox-content" style="height: 100%">
	<sys:message content="${message}"/>
	
		<!-- 查询条件 -->
	<div class="row">
	<div class="col-sm-12">
	
	<br/>
	</div>
	</div>
<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			
		</div>
	</div>
	</div>	
	
	<table id="contentTable" style="table-layout: fixed;" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<!-- <th>图标</th> -->
				<th class=" ">应用名称</th>
				<th class=" ">应用编码</th>
				<th class=" ">排序</th>
				<th class=" ">类别</th>
				<th class=" " style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 40%;">描述</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${list}" var="plugin">
			<tr>
			<!-- <td><img src="${ctxStatic}/images/application.png" style="width: 50px;height: 50px"/></td> -->
                <td>${plugin.name}</td>
                <td>${plugin.code }</td>
                <td>${plugin.order }</td>
                <td>${plugin.category }</td>
                <td style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 40%;" title="${plugin.desc }">${plugin.desc }</td>
				<td>
				<a href="javascript:void(0)" onclick="openCreateLicense(this)" pluginName="${plugin.name }" pluginCode="${plugin.code }" class="btn btn-info btn-xs"><i class="fa fa-mail-forward"></i>证书生成</a>
				
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	</div>
	</div>
</body>
</html>
