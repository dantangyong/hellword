<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!--定义问题表单  -->
<div id="define_issue-form">
	<form class="form-horizontal" id="define-issue">
		<div class="form-group">
			<div class="col-xs-offset-3 col-xs-10">
				<h4>定义问题</h4>
			</div>
		</div>
		<div class="form-group">
			<label for="firstname" class="col-xs-2 control-label">主题:</label>
			<div class="col-xs-5">
				<input type="text" class="form-control required" id="topic" name="topic"
					placeholder="定义问题">
			</div>
		</div>
		<div class="form-group">
			<label for="content" class="col-xs-2 control-label">内容:</label>
			<div class="col-xs-5">
				<textarea class="form-control required" rows="4" id="content" name="content"
					placeholder="准确完整表达问题"></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="priority" class="col-xs-2 control-label">优先级:</label>
			<div class="col-xs-5">
				<select class="form-control required" id="priority" name="dictType.id">
					<option value="1">特急</option>
					<option value="2">紧急</option>
					<option value="3">一般</option>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="reason" class="col-xs-2 control-label">原因:</label>
			<div class="col-xs-5">
				<textarea class="form-control required" rows="4" id="reason" name="reason"
					placeholder="为什么要解决该问题"></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="mean" class="col-xs-2 control-label">意义:</label>
			<div class="col-xs-5">
				<textarea class="form-control required" rows="4" id="mean" name="mean"
					placeholder="解决问题的意义"></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="desc" class="col-xs-2 control-label">描述:</label>
			<div class="col-xs-5">
				<textarea class="form-control required" rows="4" id="desc" name="desc"></textarea>
			</div>
		</div>

		<div class="form-group">
			<div class="col-xs-offset-2 col-xs-10">
				<button type="button" class="col-xs-2 btn btn-primary btn-sm"
					id="reset-defineIssue">重置</button>
				<button type="button"
					class="col-xs-offset-1 col-xs-2 btn btn-primary btn-sm"
					id="save-defineIssue">确定</button>
			</div>
		</div>
	</form>
</div>
<!-- 消息提示 	 -->

<script>
     /* 表单验证 */
     var defineIssueForm;
     $(document).ready(function() {
    	 defineIssueForm = $("#define-issue").validate();
     });	 
     
	/* 保存  并跳转下一个表单 */
	$("#save-defineIssue").click(function() {
		if(!defineIssueForm.form()){
			  return false;
		}
		$.ajax({
			type : "POST",
			url : "${ctx}/dm/defineIssue/save",
			data : $("#define-issue").serialize(),
			success : function(date) {
				$(".message-content").html(date.msg);
				$("#message-info").modal("show");
				if (date.success) {
					//获取下一个表单 路径，并跳转下一个表单 
					getNextUrl(current_urlController);
					var nextUrl = "${ctx}/dm/" + next_urlController + "/form";
					getNextForm(nextUrl);
				}
			}
		});
	})
	
	/*重置表单*/
		$('#reset-defineIssue').on('hide.bs.modal', function (e) {
			$(':input','#define-issue')  
			 .not(':button, :submit, :reset, :hidden')  
			 .val('')  
			 .removeAttr('checked')  
			 .removeAttr('selected');  
			validateForm.resetForm();
		});
	
</script>