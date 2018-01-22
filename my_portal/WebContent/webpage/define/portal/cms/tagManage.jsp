<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>底部标签管理</title>
<meta name="decorator" content="default" />
<link href="${ctxStatic }/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/common/ajaxfileupload.js"></script>
<script src="${ctxStatic}/layer-v2.3/layer/layer.js"></script>
<style type="text/css">
	.mt15 {
		margin-left: 15px;
	}
	.mTop15{
		margin-top: 15px;
		margin-left:-30px;
	}
	 #preview, img {  
		 width:200px;  
		 height:100px;  
	 }
	 #preview,.bannerImg {  
		 border:1px solid #666;  
		 border-radius:5px;
		 width:200px;  
		 height:100px; 
   	 }  
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="ibox">
			<div class="ibox-title">
				<h5 style="font-weight: 600;color: #666;">底部标签管理</h5>
				</div>
			<div class="ibox-content">
				<input type="hidden" id="id">
				<div class="row" style="margin-top: 30px;">
					<div class="col-sm-5 col-sm-offset-1">
						<div class="card">
						  <div class="card-header"><span style="font-weight: bold;">Logo管理</span></div>
						  <div class="card-block">
						    <blockquote class="card-blockquote" style="height:251px;">
						      <div class="row">
						      	<div class="col-sm-3">状态：</div>
						      	<div class="col-sm-9" id="logoStatus">
						      		<input type="radio" name="logoAble" value="1"  />启用&emsp;&emsp;
						      		<input type="radio" name="logoAble" value="2"  />禁用
								</div>
						      </div>
						      <div class="row" style="margin-top: 15px;">
						      	<div class="col-sm-3">Logo：</div>
						      	<div class="col-sm-9">
										<div id="preview"></div>
										<button name="button" type="button" class="btn btn-primary" style="margin-top:10px;"
													onclick="file.click();">上传</button>
										<input type="file" id="file" name="file"
											accept="image/jpeg,image/jpg,image/png"
											onchange="preview(this)" style="display: none">
										<p class="help-inline">注：图片小于2M,尺寸400x100</p>
								</div>
						      </div>
						      	
						    </blockquote>
						  </div>
						</div>
					</div>
					<div class="col-sm-5 mt15" >
						<div class="card">
						  <div class="card-header"><span style="font-weight: bold;">版本声明</span></div>
						  <div class="card-block">
						    <blockquote class="card-blockquote">
						      <div class="row">
						      	<div class="col-sm-3">状态：</div>
						      	<div class="col-sm-9" id="editionStatus">
						      		<input type="radio" name="editionAble" value="1"  />启用&emsp;&emsp;
						      		<input type="radio" name="editionAble" value="2"  />禁用
								</div>
						      </div>
						      <div class="row" style="margin-top: 15px;">
						      	<div class="col-sm-3">声明内容编辑：</div>
						      	<div class="col-sm-9">
						      		<textarea rows="3" class="required" style="width:80%" id="edition"></textarea>
								</div>
						      </div>
						      <div class="row" style="margin-top: 15px;">
						      	<div class="col-sm-3">联系方式编辑：</div>
						      	<div class="col-sm-9">
						      		<textarea rows="3" class="required" style="width:80%" id="contactWays"></textarea>
								</div>
						      </div>
						    </blockquote>
						  </div>
						</div>
					</div>
				</div>
				<div class="row" style="margin-top: 60px;">
					<div class="col-sm-5 col-sm-offset-1">
						<div class="card">
						  <div class="card-header"><span style="font-weight: bold;">合作单位</span></div>
						  <div class="card-block">
						    <blockquote class="card-blockquote">
						      <div class="row">
						      	<div class="col-sm-3">状态：</div>
						      	<div class="col-sm-9" id="cooperStatus">
						      		<input type="radio" name="cooperatorAble" value="1"  />启用&emsp;&emsp;
						      		<input type="radio" name="cooperatorAble" value="2"  />禁用
								</div>
						      </div>
						      <div class="row" style="margin-top: 15px;" >
						      	<div class="col-sm-3">合作单位：</div>
						      	<div class="col-sm-9" id="cooperList">
						      		<button type="button" style="width: 150px" class="btn btn-primary" id="addCooper">添加</button>
								</div>
						      </div>
						    </blockquote>
						  </div>
						</div>
					</div>
					<div class="col-sm-5 mt15" >
						<div class="card">
						  <div class="card-header"><span style="font-weight: bold;">常用链接</span></div>
						  <div class="card-block">
						    <blockquote class="card-blockquote">
						      <div class="row">
						      	<div class="col-sm-3">状态：</div>
						      	<div class="col-sm-9" id="linkStatus">
						      		<input type="radio" name="linkAble" value="1"  />启用&emsp;&emsp;
						      		<input type="radio" name="linkAble" value="2"  />禁用
								</div>
						      </div>
						      <div class="row" style="margin-top: 15px;">
						      	<div class="col-sm-3">常用链接：</div>
						      	<div class="col-sm-9" id="linkList">
									<button type="button" style="width: 150px" class="btn btn-primary" id="addLink">添加</button>
								</div>
						      </div>
						    </blockquote>
						  </div>
						</div>
					</div>
				</div>
				<div class="row" style="margin-top: 20px;">
					<div class="col-sm-5"></div>
					<div class="col-sm-4" style="margin-left:-3px;">
						<button class="btn btn-primary btn-lg" style="width:120px;" id="tagSave">编辑/保存</button>&emsp;&emsp;
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="${ctxStatic}/portal/js/tagManage.js"></script>	
<script type="text/javascript">

$(function(){
	
	function linkList(str) {
		var _html = "";
		for (var i = 0; i < str.length; i++) {
			_html = _html
			+ '<div class="col-sm-12 mTop15 linkChild">'
			+ '<div class="col-sm-8">'
			+ '<input class="form-control linkName" type="text" value="'+str[i]+'">'
			+ '</div>' + '<div class="col-sm-4">'
			+ '<button type="button" class="btn btn-danger">删除</button>'
			+ '</div>' + '</div>';
		}
		return _html;
	}
	function cooperList(str) {
		var _html = "";
		for (var i = 0; i < str.length; i++) {
			_html = _html
			+ '<div class="col-sm-12 mTop15 cooperChild">'
			+ '<div class="col-sm-8">'
			+ '<input class="form-control cooperName" type="text" value="'+str[i]+'">'
			+ '</div>' + '<div class="col-sm-4">'
			+ '<button type="button" class="btn btn-danger">删除</button>'
			+ '</div>' + '</div>';
		}
		return _html;
	}
	
	$.ajax({
		url:"${ctx}/portal/tagManage/show",
		type:"get",
		success:function(data){
			var tag=data.body.tag;
			var link = tag.link.split(",");
			var cooperator = tag.cooperator.split(",");
			$(linkList(link)).insertAfter($("#addLink"));
			$(cooperList(cooperator)).insertAfter($("#addCooper"));
			var edition = tag.edition;
// 			var reg =/&copy;/g;
// 			if(edition.indexOf("&copy;")>0){
// 				alert("true");
// 				edition.replace(reg,"©");
// 			}
			$("#edition").val(edition);
			$("#contactWays").val(tag.contactWays);
			$("#preview").append("<img src='"+tag.logoUrl+"' class='bannerImg' />");
			$(":radio[name='linkAble'][value='"+ tag.linkAble + "']").prop("checked", "checked");
			$(":radio[name='logoAble'][value='" + tag.logoAble + "']").prop("checked", "checked");
			$(":radio[name='editionAble'][value='" + tag.editionAble + "']").prop("checked", "checked");
			$(":radio[name='cooperatorAble'][value='" + tag.cooperatorAble + "']").prop("checked", "checked");
			$("#id").val(tag.id);
		}
	})
	
	$("#tagSave").on( "click", function() {
//		合作单位、常用链接数据处理
		var $cooper = $("#cooperList").find(".cooperChild");
		var $link = $("#linkList").find(".linkChild");
		
		var cooperData = new StringBuffer();
		var linkData = new StringBuffer();
		for (var i = 0; i < $cooper.length; i++) {
			if(i==0){
				cooperData.append($($cooper[i]).find('.cooperName').val());
			} else {
				cooperData.append(","+$($cooper[i]).find('.cooperName').val());
			}
		}
		for (var i = 0; i < $link.length; i++) {
			if(i==0){
				linkData.append($($link[i]).find('.linkName').val());
			} else {
				linkData.append(","+$($link[i]).find('.linkName').val());
			}
		}
		var linkString = linkData.toString();
		var cooperString = cooperData.toString();
		$.ajaxFileUpload({
			url : "${ctx}/portal/tagManage/save",
			type : "POST",
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			data : {
				id : $("#id").val(),
				logoAble : $("#logoStatus").find("input:checked").val(),
				linkAble : $("#linkStatus").find("input:checked").val(),
				cooperatorAble : $("#cooperStatus").find("input:checked").val(),
				editionAble : $("#editionStatus").find("input:checked").val(),
				edition:$("#edition").val(),
				contactWays:$("#contactWays").val(),
				link:linkString,
				cooperator:cooperString
			},
			fileElementId : 'file', //这里对应html中上传file的id
			contentType : 'application/json;charset=UTF-8',
			success : function(data) {
				layer.msg(data.msg, {
					icon : 1,
					time : 500
				}, function() {
					window.location.reload();
				});
			}
		})
	})
	function StringBuffer() {
	    this.__strings__ = new Array();
	}
	StringBuffer.prototype.append = function (str) {
	    this.__strings__.push(str);
	    return this;    //方便链式操作
	}
	StringBuffer.prototype.toString = function () {
	    return this.__strings__.join("");
	}
})
</script>
</body>
</html>