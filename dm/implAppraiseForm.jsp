<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<!--实施及建议措施  -->
<div id="impl-measure-form" class="form_hide">
	<form class="form-horizontal form-reset" role="form">
		<div class="form-group">
			<div class="col-xs-offset-3 col-xs-10">
				<h4>实施及建议措施</h4>
			</div>
		</div>
		<div class="form-group">
			<label for="topic" class="col-xs-2 control-label">主题:</label>
			<div class="col-xs-5">
				<input type="text" class="form-control" id="topic" name="topic"
					placeholder="啤酒和尿布是否强相关">
			</div>
		</div>
		
		<div class="form-group">
			<label for="method" class="col-xs-2 control-label">业务层解决措施:</label>
			<div class="col-xs-5">
				<textarea class="form-control" rows="4" id="method"
					name="method" placeholder="业务层解决措施"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="method" class="col-xs-2 control-label">挖掘层解决措施:</label>
			<div class="col-xs-5">
				<textarea class="form-control" rows="4" id="method"
					name="method" placeholder="挖掘层解决措施"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="file" class="col-xs-2 control-label">附件:</label>
			<div class="col-xs-5">
				<input type="file" class="form-control" id="file" name="file"
					>
			</div>
		</div>
		
		<div class="form-group">
			<label for="content" class="col-xs-2 control-label">描述:</label>
			<div class="col-xs-5">
				<textarea class="form-control" rows="4" id="content"
					name="content"></textarea>
			</div>
		</div>

		<div class="form-group">
			<div class="col-xs-offset-2 col-xs-10">
				<button type="button" class="col-xs-2 btn btn-primary btn-sm"
					id="resetBtn">重置</button>
				<button type="button"
					class="col-xs-offset-1 col-xs-2 btn btn-primary btn-sm"
					id="comfirm">确定</button>
			</div>
		</div>
	</form>
</div>
				