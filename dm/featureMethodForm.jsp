<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<!--选取特征和分析方法 -->
<div id="feature_method-form">
	<form class="form-horizontal" id="feature_method">
		<div class="form-group">
			<div class="col-xs-offset-3 col-xs-10">
				<h4>选取特征和分析方法</h4>
			</div>
		</div>
		<div class="form-group">
			<label for="firstname" class="col-xs-2 control-label">主题:</label>
			<div class="col-xs-5">
				<input type="text" class="form-control" id="topic" name="topic"
					placeholder="啤酒和尿布是否强相关" disabled="disabled">
			</div>
		</div>
		<div class="form-group">
			<label for="feature" class="col-xs-2 control-label">选取特征:</label>
			<div class="col-xs-5">
				<select class="form-control required" id="feature" name="featureDepot.id">
					  <!--动态加载特征  -->
					   <c:forEach items="${features}" var="feature">
						<option value="${feature.id}">${feature.name}</option>
                    </c:forEach>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="classify" class="col-xs-2 control-label">分类:</label>
			<div class="col-xs-5">
				<select class="form-control required" id="classify" name="classify" onchange="analysisDepotChange()">
                 
                     <!--动态加载父分类  -->
                    <c:forEach items="${analysises}" var="analysis">
						<option value="${analysis.id}">${analysis.name}</option>
                    </c:forEach>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="analysisDepot" class="col-xs-2 control-label">实现算法:</label>
			<div class="col-xs-5">
				<select class="form-control required" id="analysisDepot" name="analysisDepot.id">
                      
                       <!-- 此处根据分类选项动态加载option -->
				
				</select>
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
					id="reset-featureMethod">重置</button>
				<button type="button"
					class="col-xs-offset-1 col-xs-2 btn btn-primary btn-sm"
					id="save-featureMethod">确定</button>
			</div>
		</div>
	</form>
</div>
<script>
     /* 表单验证 */
     var featureMethodForm;
     $(document).ready(function() {
    	 featureMethodForm = $("#feature_method").validate();
     });	 
     
	/* 保存  并跳转下一个表单 */
	$("#save-featureMethod").click(function() {
		if(!featureMethodForm.form()){
			  return false;
		}
		$.ajax({
			type : "POST",
			url : "${ctx}/dm/featureAnalysis/save",
			data : {"feature":$("#feature").val(),
				    "analysisDepot.id":$("#analysisDepot").val(),
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
		$('#reset-featureMethod').on('hide.bs.modal', function (e) {
			$(':input','#feature_method')  
			 .not(':button, :submit, :reset, :hidden')  
			 .val('')  
			 .removeAttr('checked')  
			 .removeAttr('selected');  
			featureMethodForm.resetForm();
		});
	/* 分类方法选择触发事件 */
		function analysisDepotChange(){
			var parentId = $("#classify").find("option:selected").val();
			/* ajax动态替换实现方法option */
			$.ajax({
				type : "POST",
				url : "${ctx}/dm/featureAnalysis/getChilds",
				data : {"id":parentId},
				success : function(data) {
					//待修改 哈
					$("#analysisDepot").empty();
					$("#analysisDepot").html(data);
				}
			});
		}
</script>