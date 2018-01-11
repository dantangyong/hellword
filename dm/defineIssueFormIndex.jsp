<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<style>
.form-right {
	border: 1px solid #ddd;
	border-radius: 5px;
}

.form_hide {
	display: none;
}

.content {
	height: 500px;
}

a {
	color: black;
}

.define_issue {
	background: #F8F8F8;
	padding: 20px;
}

h4 {
	padding-top: 20px;
}
</style>
<!--左侧表单列表  -->
<div class="row define_issue">
	<div class="col-xs-3 form-left">
		<ul class="nav nav-pills nav-stacked">
			<li aria-controls="defineIssue" class="active"><a href="#">定义问题</a></li>
			<li aria-controls="dataPrepare"><a href="#">数据资料准备</a></li>
			<li aria-controls="featureMethod"><a href="#">选取特征和分析方法</a></li>
			<li aria-controls="dataExtraxt"><a href="#">提取数据需求</a></li>
			<li aria-controls="analysisResult"><a href="#">分析结果及结论</a></li>
			<li aria-controls="implMeasure"><a href="#">实施及建议措施</a></li>
			<li aria-controls="implAppraise"><a href="#">实施效果评估及报告整理</a></li>
		</ul>
	</div>
	<div class="col-xs-8 form-right">
		<div id="form-content"></div>
	</div>
</div>
<div class="modal fade" id="message-info">
	<div class="modal-dialog modal-bs">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title text-center text-danger">消息提示</h4>
			</div>
			<div class="modal-body">
				<p class="text-center text-warning">
					<span class="message-content"></span>
				</p>
			</div>
			<div class="modal-footer text-right">
				<button type="button" class="btn btn-md normal" data-dismiss="modal">确定</button>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		/*初始化defineIssue表 单 */
		 $.ajax({
				type:"POST",
				url:"${ctx}/dm/defineIssue/form",
				success:function(data){
					$("#form-content").empty();
					$("#form-content").html(data);
			    }
			});  
	});
	
	 /* 所有表单跳转 组  */
	var controller=new Array();
		controller[0] = "defineIssue";
		controller[1] = "dataPrepare";
		controller[2] = "featureMethod";
		controller[3] = "dataExtraxt";
		controller[4] = "analysisResult";
		controller[5] = "implMeasure";
		controller[6] = "implAppraise";
		var current_urlController ="defineIssue";
		var next_urlController;
	
		/* 表单列表添加事件 ,动态更改背景及跳转到相应表单  */
	$(".form-left").on("click", "li", function() {
		$(this).addClass("active").siblings().removeClass("active");
		var urlController = $(this).attr("aria-controls");
		current_urlController = urlController;
		var url = "${ctx}/dm/"+urlController+"/form";
		getNextForm(url);
	});
	
	/*跳转下一个 表单 */
	 function getNextForm(url){
		 $.ajax({
				type:"POST",
				url:url;
				success:function(data){
					$("#form-content").empty();
					$("#form-content").html(data);
			    }
			});  
	 }
   
	/*获取下一个url */
   function getNextUrl(current_urlController){
		for(var i=0;i<controller.length;i++){
			if(current_urlController ==controller[i]){
				if(i ==controller.length-1 ){
					return;
				}
				next_urlController = controller[i+1];
				
			}
		}
	}
</script>
<script
	src="${ctxStatic}/jquery-validation/1.14.0/jquery.validate.min.js"
	type="text/javascript"></script>
<script
	src="${ctxStatic}/jquery-validation/1.14.0/localization/messages_zh.min.js"
	type="text/javascript"></script>
<!-- 引入自定义的jQuery validate的扩展校验 -->
<script src="${ctxStatic}/common/validateExtend.js"
	type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.14.0/jquery.form.js"
	type="text/javascript"></script>