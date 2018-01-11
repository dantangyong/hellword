<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<script src="${ctxStatic}/common/ajaxfileupload.js"></script>
<!--准备数据表单  -->
<div id="data_prepare-form">
	<form class="form-horizontal" id="data-prepare">
		<div class="form-group">
			<div class="col-xs-offset-3 col-xs-10">
				<h4>准备数据</h4>
			</div>
		</div>
		<div class="form-group">
			<label for="topic" class="col-xs-2 control-label">主题:</label>
			<div class="col-xs-5">
				<input type="text" class="form-control required" id="topic" name="topic"
					placeholder="啤酒和尿布是否强相关">
			</div>
		</div>
		<div class="form-group">
			<label for="name" class="col-xs-2 control-label">名称:</label>
			<div class="col-xs-5">
				<input type="text" class="form-control required " id="name" name="name"
					placeholder="资料名称">
			</div>
		</div>
		<div class="form-group">
			<label for="content" class="col-xs-2 control-label">内容:</label>
			<div class="col-xs-5">
				<textarea class="form-control" rows="4" id="content" name="content"
					placeholder="资料内容"></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="time" class="col-xs-2 control-label">时间:</label>
			<div class="col-xs-5">
				<input type="text" class="form-control required" id="time" name="time"
					placeholder="创建时间">
			</div>
		</div>
		<div class="form-group">
			<label for="file" class="col-xs-2 control-label">附件:</label>
			<div class="col-xs-5">
				<input type="file" class="form-control required" id="file" name="file">
			</div>
		</div>

		<div class="form-group">
			<label for="desc" class="col-xs-2 control-label">描述:</label>
			<div class="col-xs-5">
				<textarea class="form-control" rows="4" id="desc" name="desc"></textarea>
			</div>
		</div>

		<div class="form-group">
			<div class="col-xs-offset-2 col-xs-10">
				<button type="button" class="col-xs-2 btn btn-primary btn-sm"
					id="reset-dataPrepare">重置</button>
				<button type="button"
					class="col-xs-offset-1 col-xs-2 btn btn-primary btn-sm"
					id="save-dataPrepare">确定</button>
			</div>
		</div>
	</form>
</div>

<script>
     /* 表单验证 */
     var dataPrepareForm;
     $(document).ready(function() {
    	 dataPrepareForm = $("#data-prepare").validate();
     });	 
     
	/* 保存  并跳转下一个表单 */
	$("#save-defineIssue").click(function() {
		if(!dataPrepareForm.form()){
			  return false;
		}
		 var name = $("#name").val();
		 var content = $("#content").val();
		 var time = $("#time").val();
		 var desc = $("#desc").val();
		 $.ajaxFileUpload({  
			    type: 'post',
	            url:'${ctx}/dm/dataPrepare/save?name='+name+"&content="+content
	            		       +"&time="+time+"&desc"+desc, 
	            fileElementId: 'file',
	            dataType: 'JSON',
	            contentType:"application/json",
	            success: function (date) {
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
		$('#reset-dataPrepare').on('hide.bs.modal', function (e) {
			$(':input','#data-prepare')  
			 .not(':button, :submit, :reset, :hidden')  
			 .val('')  
			 .removeAttr('checked')  
			 .removeAttr('selected');  
			dataPrepareForm.resetForm();
		});
	
</script>