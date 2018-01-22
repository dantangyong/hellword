<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/>
	
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
			if(CKEDITOR.instances.content.getData()==""){
			    $.jBox.tip('请填写正文','warning');
			   return false;
			  }
			if(validateForm.form()){
               $("#inputForm").submit();
 				  return true;
		  }
	      
		  return false;
		}
		$(document).ready(function() {
			//$("#name").focus();
			validateForm = $("#inputForm").validate({
				submitHandler: function(form){
						loading('正在提交，请稍等...');
						form.submit();
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
		});
	</script>
	<style>
.controls{ 
	width: 80%; 
 } 
.form-horizontal .control-label{
    width:100px;
}
.form-horizontal .controls{
	margin-left:0px;
}
	
	</style>
</head>
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="oaNotify" action="${ctx}/cms/notice/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="control-group" style="margin-top:20px">
			<label class="control-label"> <font color="red">*</font>标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="200" class="form-control required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件：</label>
			<div class="controls">
				
					<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="form-control"/>
					<sys:ckfinder input="files" type="files" uploadPath="/notice/notify" selectMultiple="true"/>
				
<%-- 		         <c:if test="${oaNotify.status eq '1'}"> --%>
<%-- 					<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="form-control"/> --%>
<%-- 					<sys:ckfinder input="files" type="files" uploadPath="/notice/notify" selectMultiple="true" readonly="true" /> --%>
<%-- 		         </c:if> --%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"> <font color="red">*</font>内容：</label>
			<div class="controls">
				 <form:textarea id="content" htmlEscape="true" path="content" rows="4" maxlength="2000" class="input-xxlarge form-control required"/>
         		<sys:ckeditor replace="content" uploadPath="/cms/article" /> 
			</div>
		</div>
	</form:form>
</body>
</html>