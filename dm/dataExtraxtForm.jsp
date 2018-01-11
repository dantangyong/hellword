<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<!--提取数据需求 -->
	<div id="data-extraxt-form">
		<form class="form-horizontal" id="data-extraxt">
			<div class="form-group">
				<div class="col-xs-offset-3 col-xs-10">
					<h4>提取数据需求</h4>
				</div>
			</div>
			<div class="form-group">
				<label for="firstname" class="col-xs-2 control-label">主题:</label>
				<div class="col-xs-5">
					<input type="text" class="form-control" id="topic" name="topic"
						placeholder="啤酒和尿布是否强相关" >
				</div>
			</div>
			<div class="form-group">
				<label for="result" class="col-xs-2 control-label">选择数据集：</label>
				<div class="col-xs-5">
					<input type="text" class="form-control required" id="result" name="result"
						placeholder="数据中心的数据仓库">
				</div>
			</div>
			
			<div class="form-group">
				<label for="desc" class="col-xs-2 control-label">描述:</label>
				<div class="col-xs-5">
					<textarea class="form-control required" rows="4" id="desc"
						name="desc"></textarea>
				</div>
			</div>

			<div class="form-group">
				<div class="col-xs-offset-2 col-xs-10">
					<button type="button" class="col-xs-2 btn btn-primary btn-sm"
						id="reset-dataExtraxt">重置</button>
					<button type="button" class="col-xs-offset-1 col-xs-2 btn btn-primary btn-sm"
						id="save-dataExtraxt">确定</button>
				</div>
			</div>
		</form>
	</div>
	
<script>
/* 表单验证 */
	var dataExtraxtForm;
	$(document).ready(function() {
		dataExtraxtForm = $("#data-extraxt").validate();
	});	 
	
	/* 保存  并跳转下一个表单 */
	$("#save-dataExtraxt").click(function() {
		if(!dataExtraxtForm.form()){
			  return false;
		}
		$.ajax({
			type : "POST",
			url : "${ctx}/dm/dataExtraxt/save",
			data : {"result":$("#result").val(),
				    "desc":$("#desc").val()
			    },
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
		$('#reset-dataExtraxt').on('hide.bs.modal', function (e) {
			$(':input','#data-extraxt')  
			 .not(':button, :submit, :reset, :hidden')  
			 .val('')  
			 .removeAttr('checked')  
			 .removeAttr('selected');  
			dataExtraxtForm.resetForm();
		});



</script>