<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ include file="/webpage/include/head.jsp"%>
<html>
<head>	
	<title>视频管理</title>
	<meta name="decorator" content="default"/>
	<style>
	.radio-check{
	      margin:0px 0px 3px 0px !important;
	}
	#filesImagePreview li img{
	    width:150px !important;
	    height:120px !important;
	}
	.controls ol+a{
	    margin-left: 60px;
	}
	
	</style>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
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
					var flag=true;
					if($("#linkContent").is(":hidden")){
						 if ($("#files").val()=="" || $("#files").val() == null){
							 $("#files").focus();
		                        top.$.jBox.tip('请上传视频','warning');
		                        flag=false;
		                    }
							else if ($("#filesImage").val()=="" || $("#filesImage").val() ==null){
			                    	 $("#filesImage").focus();
			                        top.$.jBox.tip('请上传图片','warning');
			                        flag=false;
			                }
							
							else if(!$(".iradio_square-green ").hasClass("checked")){
								 top.$.jBox.tip('请选择是否推荐','warning');
				            	flag = false;
				            }
					}
	                
					if(flag){
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
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="ibox-content">
	<form:form id="inputForm" modelAttribute="cmsVideo" action="${ctx}/cms/video/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label"><span style="color:red">*</span> 视频标题:</label>
			<div class="controls">
				<form:input path="videoName" htmlEscape="false" cssStyle="width:400px" class="form-control input-xxlarge measure-input required"/>
			</div>
		</div>
		<div class="control-group row">
			<div class="col-sm-3">
				<label class="control-label"><span style="color:red">*</span> 视频分类:</label>
	            <div class="controls">
	                  <form:select path="videoType.id" class="form-control" items="${videoTypes}" 
	                  	itemLabel="typeName" itemValue="id" cssStyle="width:160px"></form:select>
	            </div>
			</div>
			<div class="col-sm-5">
				<label class="control-label" style="width:50px;"><span style="color:red">*</span> 排序:</label>
				<div class="controls" style="margin-left:70px;">
					<form:input path="sort" htmlEscape="false" cssStyle="width:100px" class="input-sm form-control required digits"/>
					<span class="help-inline">设置前台视频顺序</span>
				</div>
			</div>
        </div>
		<div class="control-group">
			<label class="control-label"><span style="color:red">*</span> 上传视频:</label>
			<div class="controls input-group" style="padding-top:7px;">
                <span>
                	<input class="radio-check" id="link" type="radio" name="videoSource" value="1" >&nbsp;
                		<label>外部链接</label> &emsp;&emsp;&emsp;&emsp;
                    <input class="radio-check" id="local" type="radio" name="videoSource" value="2" >&nbsp;
                    	<label>本地上传</label>
                </span>
			</div>
		</div>
        <div id="linkContent" class="control-group" style="display: none;">
            <label class="control-label"><span style="color:red">*</span>外部链接:</label>
            <div class="controls">
                <form:input path="videoUrlTemp" htmlEscape="false" class="form-control input-sm required" cssStyle="width:200px"/>
                <span class="help-inline">请使用绝对地址</span>
            </div>
        </div>
        <div id="localContent" class="control-group" style="display:none;">
            <label class="control-label"><span style="color:red">*</span> 视频上传:</label>
            <div class="controls">
                <form:hidden id="files" path="videoUrlCache" htmlEscape="false" class="form-control"/>
                <span class="help-inline" style=" margin:8px 0px 0px 186px;">请上传小于5M的视频</span>
					<sys:ckfinder input="files" type="files" uploadPath="/portal/video" selectMultiple="false"/>
            </div>
            
        </div>
        <div class="control-group">
         <label class="control-label"><span style="color:red">*</span> 图片上传:</label>
            <div class="controls">
                <form:hidden id="filesImage" path="videoImage" htmlEscape="false" class="form-control"/>
					<sys:ckfinder input="filesImage" type="images" uploadPath="/portal/image" selectMultiple="false"/>
            </div>
            </div>
		<div class="control-group">
			<label class="control-label">视频简介:</label>
			<div class="controls">
				<form:textarea path="videoDetail" htmlEscape="false" class="form-control input-sm" rows="5" cssStyle="width:60%" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font>是否推荐:</label>
			<div class="controls" style="padding-top: 7px;">
				<form:radiobuttons class="i-checks" path="videoPriority" items="${fns:getDictList('recommend')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				<span class="help-inline">前台页面推荐展示</span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasAnyPermissions name="cms:video:edit,cms:video:add">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&emsp;
			</shiro:hasAnyPermissions>
<!-- 			<input id="btnOnline" class="btn btn-warning" type="button" value="发布" />&emsp; -->
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="javascript:window.location.href='${ctx}/cms/video'"/>
		</div>
	</form:form>
	</div>
</div>
<script type="text/javascript">
$(function(){
	$("#link").on("click",function(){
		$("#linkContent").css("display","block");
		$("#localContent").css("display","none");
	})
	$("#local").on("click",function(){
		$("#localContent").css("display","block");
		$("#linkContent").css("display","none");
	})
	if('${cmsVideo.videoSource}'==='1'){
		$("#linkContent").attr("style","display: block;");
		$("#link").attr("checked","checked");
	}else{
		$("#localContent").attr("style","display: block;");
		$("#local").attr("checked","checked");
	}
	
	
	
})
</script>	
</body>
</html>