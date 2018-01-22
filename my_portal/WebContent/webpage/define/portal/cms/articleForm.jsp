<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="front/include/taglib.jsp"%>
<html>
<head>
	<title>文章管理</title>
	<meta name="decorator" content="default"/>
	<style>
	#imagePreview li img{
	 width:200px!important;
	 height:100px!important;
	}
	#a_mid ol+a{
	margin-left:80px;
	}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			var recommend = false;
			var status = false;
            if($("#link").val()){
                $('#linkBody').show();
                $('#url').attr("checked", true);
            }
           
			$("#title").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					 if($("#article_recommend .iradio_square-green ").hasClass("checked")){
	            		 recommend = true;
	                 }
	            	 if($("#article_status .iradio_square-green ").hasClass("checked")){
	            		 status = true;
	                  }
                    if ($("#categoryId").val()==""){
                        $("#categoryName").focus();
                        top.$.jBox.tip('请选择归属栏目','warning');
                    }
                    else if (CKEDITOR.instances.content.getData()==""){
                        top.$.jBox.tip('请填写正文','warning');
                    }else if (!status ||!recommend){
                        top.$.jBox.tip('请选择状态/是否推荐','warning');
                    } 
                    else{
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
			//外部js调用
			laydate({
				format: 'YYYY-MM-DD hh:mm:ss',
				istime: true,
				elem : '#createDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
				event : 'focus' //响应事件。如果没有传入event，则按照默认的click
			});
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="ibox-content">
	<form:form id="inputForm" modelAttribute="article" action="${ctx}/cms/article/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label"> <font color="red">*</font>所在栏目:</label> -->
<!-- 			<div class="controls input-group"> -->
<%--                 <sys:treeselect id="category" name="category.id" value="${article.category.id}" labelName="category.name" labelValue="${article.category.name}" --%>
<%-- 					title="栏目" url="/cms/category/treeData" module="article" selectScopeModule="true" notAllowSelectRoot="false" notAllowSelectParent="true" cssClass="input-small"/> --%>
<!-- 					&nbsp; -->
<!-- <!--                 <span> --> 
<!-- <!--                     <input class="iradio_square-green" id="url" type="checkbox" onclick="if(this.checked){$('#linkBody').show()}else{$('#linkBody').hide()}$('#link').val()">&nbsp;<label for="url">外部链接</label> --> 
<!-- <!--                 </span> --> 
<!-- 			</div> -->
<!-- 		</div> -->
        <div class="control-group">
           <label class="control-label"> <font color="red">*</font>所在栏目:</label>
		    <div class="controls">
	                  <form:select path="category.id" class="form-control" items="${categories}" 
	                  	      itemLabel="name" itemValue="id" cssStyle="width:160px">
	                  </form:select>
	                  	&nbsp;
                <span style="display:block;">
                    <input class="iradio_square-green" id="url" type="checkbox" onclick="if(this.checked){$('#linkBody').show()}else{$('#linkBody').hide()}$('#link').val()">&nbsp;<label for="url">外部链接</label>
                </span>
	                  	
	            </div>
		</div>
		<div class="control-group">
			<label class="control-label"> <font color="red">*</font>标题:</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" cssStyle="width:400px" class="form-control input-xxlarge measure-input required"/>
				<span class="help-inline">长度需要在0-30之间</span>
<!-- 				&nbsp;<label>颜色:</label> -->
<%-- 				<form:select path="color" class="input-mini form-control" cssStyle="width:80px"> --%>
<%-- 					<form:option value="" label="默认"/> --%>
<%-- 					<form:options items="${fns:getDictList('color')}" itemLabel="label" itemValue="value" htmlEscape="false" /> --%>
<%-- 				</form:select> --%>
			</div>
		</div>
        <div id="linkBody" class="control-group" style="display:none">
            <label class="control-label">外部链接:</label>
            <div class="controls">
                <form:input path="link" htmlEscape="false" maxlength="200" class="form-control input-sm" cssStyle="width:200px"/>
                <span class="help-inline">绝对或相对地址。</span>
            </div>
        </div>
		<div class="control-group">
			<label class="control-label">关键字:</label>
			<div class="controls">
				<form:input path="keywords" htmlEscape="false" class="form-control input-sm" cssStyle="width:200px"/>
				<span class="help-inline">多个关键字，用空格分隔。</span>
			</div>
		</div>
		<div class="control-group"> 
			<label class="control-label">排序:</label>
			<div class="controls"> 
				<form:input path="weight" htmlEscape="false" cssStyle="width:80px" class="input-sm form-control required digits"/>&nbsp; 
				<span> 
					<input id="weightTop" class="iradio_square-green" type="checkbox" onclick="$('#weight').val(this.checked?'999':'0')"><label for="weightTop">&nbsp;置顶</label> 
				</span> 
<!-- 				&nbsp;过期时间： -->
<!-- <!-- 				<input id="weightDate" name="weightDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate" --> 
<%-- <%-- 					value="<fmt:formatDate value="${article.weightDate}" pattern="yyyy-MM-dd"/>" --%> 
<!-- <!-- 					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/> --> 
<!-- 				<input id="weightDate" name="weightDate" -->
<!-- 							type="text" maxlength="20" -->
<!-- 							class="laydate-icon form-control layer-date input-sm" -->
<%-- 							value="<fmt:formatDate value="${article.weightDate}" pattern="yyyy-MM-dd"/>" /> --%>
					
<!-- 				<span class="help-inline">数值越大排序越靠前，过期时间可为空，过期后取消置顶。</span> -->
			</div> 
		</div> 
		<div class="control-group">
			<label class="control-label"> <font color="red">*</font>摘要:</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="8" cssStyle="width:800px" class="form-control input-xxlarge required"/>
			</div>
		</div>
		<div class="control-group"   style="position:relative;">
			<label class="control-label">缩略图:</label>
			<div class="controls" style="position:relative" id="a_mid">
                <input type="hidden" id="image" name="image" value="${article.imageSrc}"/>
				<sys:ckfinder input="image" type="thumb" uploadPath="/cms/article" selectMultiple="false"/>
<!-- 				<span class="help-inline" style="margin: -40px 0px 0px 40px;">数值越大排序越靠前，过期时间可为空，过期后取消置顶。</span> -->
			<span class="help-inline" style="position:absolute;top:10px;left:264px;">图片比例推荐：760x370</span>
			</div>
			
		</div>
		<div class="control-group">
			<label class="control-label"> <font color="red">*</font>正文:</label>
			<div class="controls">
				<form:textarea id="content" htmlEscape="true" path="articleData.content" rows="4" maxlength="200" class="input-xxlarge"/>
				<sys:ckeditor replace="content" uploadPath="/cms/article" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">来源:</label>
			<div class="controls">
				<form:input path="articleData.copyfrom" htmlEscape="false" class="form-control input-sm" cssStyle="width:200px"/>
			</div>
		</div>
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">相关文章:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:hidden id="articleDataRelation" path="articleData.relation" htmlEscape="false" maxlength="200" class="input-xlarge"/> --%>
<!-- 				<ol id="articleSelectList"></ol> -->
<!-- 				<a id="relationButton" href="javascript:" class="btn">添加相关</a> -->
				<script type="text/javascript">
// 					var articleSelect = [];
// 					function articleSelectAddOrDel(id,title){
// 						var isExtents = false, index = 0;
// 						for (var i=0; i<articleSelect.length; i++){
// 							if (articleSelect[i][0]==id){
// 								isExtents = true;
// 								index = i;
// 							}
// 						}
// 						if(isExtents){
// 							articleSelect.splice(index,1);
// 						}else{
// 							articleSelect.push([id,title]);
// 						}
// 						articleSelectRefresh();
// 					}
// 					function articleSelectRefresh(){
// 						$("#articleDataRelation").val("");
// 						$("#articleSelectList").children().remove();
// 						for (var i=0; i<articleSelect.length; i++){
// 							$("#articleSelectList").append("<li>"+articleSelect[i][1]+"&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"articleSelectAddOrDel('"+articleSelect[i][0]+"','"+articleSelect[i][1]+"');\">×</a></li>");
// 							$("#articleDataRelation").val($("#articleDataRelation").val()+articleSelect[i][0]+",");
// 						}
// 					}
// 					$.getJSON("${ctx}/cms/article/findByIds",{ids:$("#articleDataRelation").val()},function(data){
// 						for (var i=0; i<data.length; i++){
// 							articleSelect.push([data[i][1],data[i][2]]);
// 						}
// 						articleSelectRefresh();
// 					});
// 					$("#relationButton").click(function(){
// 						top.$.jBox.open("iframe:${ctx}/cms/article/selectList?pageSize=8", "添加相关",$(top.document).width()-220,$(top.document).height()-180,{
// 							buttons:{"确定":true}, loaded:function(h){
// 								$(".jbox-content", top.document).css("overflow-y","hidden");
// 							}
// 						});
// 					});
				</script>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">是否允许评论:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:radiobuttons class="i-checks" path="articleData.allowComment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">推荐位:</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:checkboxes path="posidList" items="${fns:getDictList('cms_posid')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">发布时间:</label> -->
<!-- 			<div class="controls"> -->
<!-- <!-- 				<input id="createDate" name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" --> 
<%-- <%-- 					value="<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" --%> 
<!-- <!-- 					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> --> 
<!-- 					<input id="createDate" name="createDate" -->
<!-- 							type="text" maxlength="20" -->
<!-- 							class="laydate-icon form-control layer-date input-sm" -->
<%-- 							value="<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd"/>" /> --%>
<!-- 			</div> -->
<!-- 		</div> -->
        <div class="control-group">
			<label class="control-label"><font color="red">*</font>是否推荐:</label>
			<div class="controls" style="padding-top: 7px;" id="article_recommend">
				<form:radiobuttons class="i-checks" path="posid" items="${fns:getDictList('recommend')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				<span class="help-inline">前台页面推荐展示</span>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label"> <font color="red">*</font>状态:</label>
				<div class="controls" style="padding-top: 7px;" id="article_status">
					<form:radiobuttons class="i-checks" path="disable" items="${fns:getDictList('able')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					<span class="help-inline">前台页面推荐展示</span>
				</div>
			</div>
		
<%-- 		<shiro:hasPermission name="cms:category:edit"> --%>
<!--             <div class="control-group"> -->
<!--                 <label class="control-label">自定义内容视图:</label> -->
<!--                 <div class="controls"> -->
<%--                       <form:select path="customContentView" class="form-control" cssStyle="width:110px"> --%>
<%--                           <form:option value="" label="默认视图"/> --%>
<%--                           <form:options items="${contentViewList}" htmlEscape="false"/> --%>
<%--                       </form:select> --%>
<%--                       <span class="help-inline">自定义内容视图名称必须以"${article_DEFAULT_TEMPLATE}"开始</span> --%>
<!--                 </div> -->
<!--             </div> -->
<!--             <div class="control-group"> -->
<!--                 <label class="control-label">自定义视图参数:</label> -->
<!--                 <div class="controls "> -->
<%--                       <form:input path="viewConfig" htmlEscape="true" class="form-control input-mini" cssStyle="width:200px"/> --%>
<!--                       <span class="help-inline">视图参数例如: {count:2, title_show:"yes"}</span> -->
<!--                 </div> -->
<!--             </div> -->
<%-- 		</shiro:hasPermission> --%>
<%-- 		<c:if test="${not empty article.id}"> --%>
<!-- 			<div class="control-group"> -->
<!-- 				<label class="control-label">查看评论:</label> -->
<!-- 				<div class="controls"> -->
<%-- 					<input id="btnComment" class="btn" type="button" value="查看评论" onclick="viewComment('${ctx}/cms/comment/?module=article&contentId=${article.id}&status=0')"/> --%>
<!-- 					<script type="text/javascript"> -->
<!-- 					function viewComment(href){
// 							top.$.jBox.open('iframe:'+href,'查看评论',$(top.document).width()-220,$(top.document).height()-180,{
// 								buttons:{"关闭":true},
// 								loaded:function(h){
// 									$(".jbox-content", top.document).css("overflow-y","hidden");
// 									$(".nav,.form-actions,[class=btn]", h.find("iframe").contents()).hide();
// 									$("body", h.find("iframe").contents()).css("margin","10px");
// 								}
// 							});
// 							return false;
// 						}
<!-- 					</script> -->
<!-- 				</div> -->
<!-- 			</div> -->
<%-- 		</c:if> --%>
		<div class="form-actions">
			<shiro:hasAnyPermissions name="cms:article:edit,cms:article:add"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasAnyPermissions>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="javascript:window.location.href='${ctx}/cms/article'"/>
		</div>
	</form:form>
	</div>
	</div>
</body>
</html>