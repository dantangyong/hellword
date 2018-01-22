<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="front/include/taglib.jsp"%>
<html>
<head>
	<title>栏目管理</title>
	<meta name="decorator" content="default"/>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
			<div class="ibox-content">
	<form:form id="inputForm" modelAttribute="category" action="${ctx}/cms/category/save" method="post" class="form-horizontal">
<%-- 	    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/> --%>
<%-- 		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/> --%>
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">归属机构:</label> -->
<!-- 			<div class="controls input-group"> -->
<%--                 <sys:treeselect id="office" name="office.id" value="${category.office.id}" labelName="office.name" labelValue="${category.office.name}" --%>
<%-- 					title="机构" url="/sys/office/treeData" cssClass="input-small"/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">上级栏目:</label> -->
<!-- 			<div class="controls input-group"> -->
<%--                 <sys:treeselect id="category" name="parent.id" value="${category.parent.id}" labelName="parent.name" labelValue="${category.parent.name}" --%>
<%-- 					title="栏目" url="/cms/category/treeData" extId="${category.id}" cssClass="input-small"/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">栏目模型:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:select path="module" class="form-control m-b" cssStyle="width:120px"> --%>
<%-- 					<form:option value="" label="公共模型"/> --%>
<%-- 					<form:options items="${fns:getDictList('cms_module')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
<%-- 				</form:select> --%>
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="control-group">
			<label class="control-label"><font color="red">*</font>栏目名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" id="category_name" class="form-control input-sm required" cssStyle="width:200px" />
<!-- 				<span style="color:red;display:none" id="name-info"></span> -->
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font>英文名:</label>
				<form:input path="target" htmlEscape="false" maxlength="50" id="englishName" class="form-control input-sm required" cssStyle="width:200px" />
<!-- 				<span style="color:red;display:none" id="name-info"></span> -->
			</div>
		</div>
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">缩略图:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:hidden path="image" htmlEscape="false" maxlength="255" class="input-xlarge"/> --%>
<%-- 				<span><sys:ckfinder input="image" type="thumb" uploadPath="/cms/category" /></span> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">链接:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:input path="href" htmlEscape="false" cssStyle="width:200px" class=" form-control input-sm"/> --%>
<!-- 				<span class="help-inline">栏目超链接地址，优先级“高”</span> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">目标:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:input path="target" htmlEscape="false" cssStyle="width:200px" class=" form-control input-sm"/> --%>
<!-- 				<span class="help-inline">栏目超链接打开的目标窗口，新窗口打开，请填写：“_blank”</span> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="4" cssStyle="width:400px" class="form-control input-xxlarge"/>
			</div>
		</div>
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">关键字:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:input path="keywords" htmlEscape="false" cssStyle="width:200px" class=" form-control input-sm"/> --%>
<!-- 				<span class="help-inline">填写描述及关键字，有助于搜索引擎优化</span> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="control-group">
			<label class="control-label"><font color="red">*</font>排序:</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false"  cssStyle="width:80px" class=" form-control input-sm" onkeyup="value=value.replace(/[^1234567890-]+/g,'')"/>
				<span class="help-inline">栏目的排列次序</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font>状态:</label>
			<div class="controls">
				<form:radiobuttons path="inMenu" items="${fns:getDictList('able')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks" />
				<span class="help-inline">是否在导航中(前台)显示该栏目</span>
			</div>
		</div>
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">在分类页中显示列表:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:radiobuttons path="inList" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks"/> --%>
<!-- 				<span class="help-inline">是否在分类页中显示该栏目的文章列表</span> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label" title="默认展现方式：有子栏目显示栏目列表，无子栏目显示内容列表。">展现方式:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:radiobuttons path="showModes" items="${fns:getDictList('cms_show_modes')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks"/>
<%-- 				<form:select path="showModes" class="input-medium"> --%>
<%-- 					<form:option value="" label="默认"/> --%>
<%-- 					<form:options items="${fns:getDictList('cms_show_modes')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
<%-- 				</form:select><span class="help-inline"></span> --%> 
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">是否允许评论:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:radiobuttons class="i-checks" path="allowComment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">是否需要审核:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:radiobuttons class="i-checks" path="isAudit" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">自定义列表视图:</label> -->
<!-- 			<div class="controls"> -->
<%--                 <form:select path="customListView" class="form-control m-b" cssStyle="width:120px"> --%>
<%--                     <form:option value="" label="默认视图"/> --%>
<%--                     <form:options items="${listViewList}" htmlEscape="false"/> --%>
<%--                 </form:select> --%>
<%--                 <span class="help-inline">自定义列表视图名称必须以"${category_DEFAULT_TEMPLATE}"开始</span> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">自定义内容视图:</label> -->
<!-- 			<div class="controls"> -->
<%--                 <form:select path="customContentView" class="form-control m-b" cssStyle="width:120px"> --%>
<%--                     <form:option value="" label="默认视图"/> --%>
<%--                     <form:options items="${contentViewList}" htmlEscape="false"/> --%>
<%--                 </form:select> --%>
<%--                 <span class="help-inline">自定义内容视图名称必须以"${article_DEFAULT_TEMPLATE}"开始</span> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">自定义视图参数:</label> -->
<!-- 			<div class="controls"> -->
<%--                 <form:input path="viewConfig" htmlEscape="true" cssStyle="width:200px" class=" form-control input-sm"/> --%>
<!--                 <span class="help-inline">视图参数例如: {count:2, title_show:"yes"}</span> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="form-actions">
			<shiro:hasPermission name="cms:category:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="javascript:window.location.href='${ctx}/cms/category'"/>
		</div>
	</form:form>
	</div>
	</div>
	
<script type="text/javascript">
		$(document).ready(function() {
			var flag = false;
            $('input').on('ifChecked',function(event){ 
            	flag = true;
           });
            $(".i-checks").each(function(){
            	if($(this).is(':checked')){
            		flag = true;
            	}
            })
			$("#name").focus();
		    $("#inputForm").validate({
		    	focusInvalid: false,
				onkeyup: false,
				rules: {
					name: {remote: "${ctx}/cms/category/checkName?oldName=${category.name}"}
				},
				messages: {
					name: {remote: "栏目名称已存在"}
				},
		       
				submitHandler: function(form){
				 if (!flag){
                        top.$.jBox.tip('请选择状态','warning');
                    } else{
                    	loading('正在提交，请稍等...');
						form.submit();
                    }
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
// 		    $("#inputForm").validate().element($("#category_name"));
		});
	</script>	
</body>
</html>