<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="front/include/taglib.jsp"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>显示设置</title>
<meta name="decorator" content="default" />
<link href="${ctxStatic}/css/displaySetting.css" rel="stylesheet" />
<link
	href="${ctxStatic}/bootstrap-color-picker/css/bootstrap-colorpicker.min.css"
	rel="stylesheet" />
<link href="${ctxStatic}/webuploader-0.1.5/webuploader.css" rel="stylesheet" />
<script
	src="${ctxStatic}/bootstrap-color-picker/js/bootstrap-colorpicker.min.js"></script>
<script src="${ctxStatic}/portal/js/ajaxfileupload.js"></script>
<script src="${ctxStatic}/artTemplate/artTemplate-web.js"></script>
<script>
	$(function() {
		/* 颜色选择插件  */
		$('#cp2').colorpicker({
			format : 'hex',
		});
		/* +颜色按钮点击出现添加input框    */
		$('.addColor').on('click', function() {
			$('.addColorDiv').removeClass('hide');
		});
		/* 取消添加颜色  */
		$('.cancelAddColor').on('click', function() {
			$('.addColorDiv').addClass('hide');
		});
		/* 删除logo图   */
		$('#delLogo').on('click', '.deleteLogo', function() {
			var obj = $(this).parent();
			$.ajax({
				url : "${ctx}/cms/displaySetting/delLogo",
				type : "post",
				data : {
					id : $("#id").val(),
				},
				success : function() {
					obj.empty();
					$("#picname").val("");
				}
			});
		});
		/* 删除颜色  */
		$('.themeUl').on('click', '.deleteColor', function() {
			var obj = $(this).parent();
			var color = $(this).attr("color");
			$.ajax({
				url : "${ctx}/cms/displaySetting/delTheme",
				type : "post",
				data : {
					id : $("#id").val(),
					theme : color
				},
				success : function() {
					obj.remove();
				}
			});
		});
		/* 确定添加颜色  */
		$('.sureAddColor').on('click',function() {
			var color = $('#colorInput').val();
			$('.addColorDiv').addClass('hide');
			$.ajax({
				url : "${ctx}/cms/displaySetting/saveTheme",
				type : "post",
				data : {
					id : $("#id").val(),
					theme : color
				},
				success : function(data) {
					if(data.code === '50000'){
						layer.alert(data.msg,{icon:0});
					} else {
						layer.alert(data.msg,{icon:1});
					}
					reloadThemes();
				}
			});
		});
		
		/* banner */
		$('.bannerList').on('click', 'a', function() {
			$(this).addClass('active').siblings().removeClass('active');
		})

		$('#sysNameSave').on('click', function() {
			$.ajax({
				url : '${ctx}/cms/displaySetting/saveName',
				type : 'post',
				dataType : 'json',
				data : {
					id : $('#id').val(),
					systemName : $('#systemName').val(),
				},
				success : function(data) {
					layer.alert(data.msg,{icon:1});
				}
			})
		})
	})
	
	function upload() {
		var url = '${ctx}/cms/displaySetting/saveLogo';//这里填请求的地址
		$.ajaxFileUpload({
			url : url,
			type : 'POST',
			dataType : 'json',
			data : {
				id : $('#id').val()
			},
			fileElementId : 'file', //这里对应html中上传file的id
			contentType : 'application/json;charset=UTF-8',
			success : function(data) {
				layer.alert(data.msg,{icon:1});
				var url = data.body.url;
				if ($('#delLogo>.logoImg').size() === 0) {
					var html = '<img class="logoImg" alt="logo" src="'+url+'">'
							+ '<span class="deleteLogo"><span class="glyphicon glyphicon-remove-circle"></span></span>';
					$('#delLogo').html(html);
				} else {
					$('.logoImg').attr('src', url);
				}
			},
			error : function() {
				alert('请链接网络');
			}
		})
	}
	function reloadThemes(){
		$.ajax({
			url:'${ctx}/cms/displaySetting/homeTheme',
			type : 'GET',
			dataType : 'json',
			data : {
				id : $('#id').val()
			},
			success : function(data) {
				$('.addColorLi').siblings().remove();
				strs = data.body.themes;
				var html = '';
				for (var i = 0; i < strs.length; i++) {
					html = html
					+ "<li style='background-color: "+strs[i]+"'>"
					+ "<span class='deleteColor' color='"+strs[i]+"'><span class='glyphicon glyphicon-remove-circle'></span></span>"
					+ "</li>";
				}
				$('#themeUl').prepend(html);
			}
		})
	}
</script>
</head>
<body>
	<div>
		<div class="row">
			<div class="col-sm-3">
				<div class="list-group bannerList col-sm-2">
					<a href="#sysName" class="list-group-item active"> 系统名称 </a> <a
						href="#logo" class="list-group-item">LOGO</a> <a href="#carousel"
						class="list-group-item">轮播图</a> <a href="#theme"
						class="list-group-item">主题</a> <a href="#home"
						class="list-group-item">首页排版</a> <a href="#navigation"
						class="list-group-item">导航</a>
				</div>
			</div>
			<input type="hidden" value="${display.id }" id="id">
			<div class="col-sm-9">
				<div id="sysName">
					<h4 class="setTitle">系统名称</h4>
					<div class="row">
						<div class="col-sm-6">
							<input type="text" id="systemName"
								class="form-control" value="${display.systemName }">
						</div>
						<div class="col-sm-2">
							<button class="btn btn-primary" id="sysNameSave">保存</button>
						</div>
					</div>
				</div>
				<div id="logo">
					<h4 class="setTitle">LOGO</h4>
					<div class="row">
						<div class="col-sm-10">
							<div class="outLineDiv">
								<div class="row">
									<div class="col-sm-6">
										<input type="text" id="picname" class="form-control"
											placeholder="只支持jpeg、jpg、png格式。">
									</div>
									<div class="col-sm-1">
										<button name="button" type="button" class="btn btn-primary"
											onclick="file.click();">选择</button>
										<input type="file" id="file" name="file"
											accept="image/jpeg,image/jpg,image/png"
											onchange="picname.value=this.value" style="display: none">
									</div>
									<div class="col-sm-1">
										<button type="button" class="btn btn-primary" onclick="upload()">保存</button>
									</div>
								</div>
								<div class="row">
									<div id="delLogo" class="col-sm-8">
										<c:if test="${display.logo ne null}">
											<img class="logoImg" alt="logo" style="background-color: black;"
												src="${display.logo }">
											<span class="deleteLogo"><span
												class="glyphicon glyphicon-remove-circle"></span></span>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="carousel">
					<h4 class="setTitle">轮播图</h4>
					<div class="row">
						<div class="col-sm-10">
							<div class="outLineDiv">
								<div class="row">
									<div class="col-sm-12">
										<div class="row">
											<div class="col-sm-6">
												<input type="text" id="picname1" class="form-control"
													placeholder="只支持jpeg、jpg、png格式。">
											</div>
											<div class="col-sm-1">
												<button name="button" type="button" class="btn btn-primary"
													onclick="files.click();">选择</button>
												<input type="file" id="files" name="files" multiple="multiple"
													accept="image/jpeg,image/jpg,image/png"
													style="display: none">
											</div>
										</div>
									</div>
								</div>
								<div>
									<div class="col-sm-12">
										<div class="fileImgs">
										
										</div>
										<div id="carousel-example-generic" class="carousel slide"
											data-ride="carousel">
											<!-- Indicators -->
											<ol class="carousel-indicators">
												<li data-target="#carousel-example-generic"
													data-slide-to="0" class="active"></li>
												<li data-target="#carousel-example-generic"
													data-slide-to="1"></li>
												<li data-target="#carousel-example-generic"
													data-slide-to="2"></li>
											</ol>

											<!-- Wrapper for slides -->
											<div class="carousel-inner listbox" role="listbox">
												<c:if test="${display.carousel ne null && display.carousel ne '' }">
													<c:forEach varStatus="status" var="carousel" items="${fn:split(display.carousel, ',')}">
														<div class="item <c:if test="${status.index ==0 }">active</c:if>">
															<img src="${carousel }" alt="轮播图预览"/>
														</div>
													</c:forEach>
												</c:if>
											</div>

											<!-- Controls -->
											<a class="left carousel-control"
												href="#carousel-example-generic" role="button"
												data-slide="prev"> <span
												class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
												<span class="sr-only">Previous</span>
											</a> <a class="right carousel-control"
												href="#carousel-example-generic" role="button"
												data-slide="next"> <span
												class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
												<span class="sr-only">Next</span>
											</a>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-2">
										<p class="refreshText">刷新频率</p>
									</div>
									<div class="col-sm-2">
										<input type="text" class="form-control" id="freq"
											value="${display.frequency }">
									</div>
									<div class="col-sm-2">
										<p class="refreshText">秒</p>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-2 col-sm-offset-5">
										<button class="btn btn-primary" id="uploadPics" style="width:100%">保存</button>								
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="theme">
					<h4 class="setTitle">主题</h4>
					<div class="row">
						<div class="col-sm-10">
							<div class="outLineDiv">
								<div class="row">
									<ul class="themeUl" id="themeUl">
										<c:if test="${display.theme ne null && display.theme ne '' }">
											<c:forEach var="theme"
												items="${fn:split(display.theme, ',')}">
												<li style="background-color: ${theme}"><span
													class="deleteColor" color="${theme}"> <span
														class="glyphicon glyphicon-remove-circle"></span>
												</span></li>
											</c:forEach>
										</c:if>
										<li class="addColorLi"><span class="addColor"><span
												title="添加主题色" class="glyphicon glyphicon-plus"></span></span></li>
									</ul>
								</div>

								<div class="row addColorDiv hide">
									<div class="col-sm-4">
										<div id="cp2" class="input-group colorpicker-component">
											<input type="text" name="colorInput" value="#00AABB"
												class="form-control" id="colorInput" /> <span
												class="input-group-addon"><i></i></span>
										</div>
									</div>
									<div class="col-sm-1">
										<button class="btn btn-primary sureAddColor">保存</button>
									</div>
									<div class="col-sm-1">
										<button class="btn btn-primary cancelAddColor">取消</button>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
				<div id="home">
					<h4 class="setTitle">首页排版</h4>
					<div class="row">
						<div class="col-sm-7">
							<div class="outLineDiv">
								<div class="row" id="homeList">
									
								
								</div>
								<div class="row">
									<div class="col-sm-4 col-sm-offset-4">
										<button class="btn btn-primary" id="savaHome" style="width:100%">保存</button>								
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="navigation">
					<h4 class="setTitle">导航</h4>
					<div class="row">
						<div class="col-sm-10 outLineDiv">
							<div class="navSetting" id="navSetting">
								<button style="width: 100%; margin-bottom: 10px;" type="button"
									class="btn btn-primary" id="naviBtn">添加一级导航</button>
								<c:forEach items="${navi}" var="navi">
									<c:if test="${navi.parentId eq null || navi.parentId eq ''}">
									<div class="moduleNav">
										<div class="row oneTemplate">
											<input type="hidden" value="${navi.id }" class="naviOneId selfId">
											<div class="col-sm-2">
												<input type="text" class="form-control firstTitle" placeholder="标题" value="${navi.naviName }">
											</div>
											<div class="col-sm-7">
												<input type="text" class="form-control firstUrl" placeholder="链接地址" value="${navi.url }">
											</div>
											<div class="col-sm-3">
												<div class="iconChoice">
													<span class="glyphicon glyphicon-plus addTwo" title="添加子导航"></span>
													<span class="glyphicon glyphicon-eye-open <c:if test='${navi.status}'>hide</c:if>" title="显示导航"></span>
													<span class="glyphicon glyphicon-eye-close <c:if test='${!navi.status}'>hide</c:if>" title="隐藏导航"></span>
													<span class="glyphicon glyphicon-menu-up" title="上移导航"></span>
													<span class="glyphicon glyphicon-menu-down" title="下移导航"></span>
													<span class="glyphicon glyphicon-remove" title="删除导航"></span>
												</div>
											</div>
										</div>
									<c:if test="${navi.children ne null}">
										<c:forEach items="${navi.children }" var="child">
											<div class="row twoTemplate">
												<input type="hidden" value="${child.id }" class="naviTwoId selfId">
												<input type="hidden" value="${child.parentId }" id="naviTwoParentId">
												<div class="col-sm-1"></div>
												<div class="col-sm-8">
													<input type="text" class="form-control secondTitle" placeholder="标题" value="${child.naviName }">
												</div>
												<div class="col-sm-3 secondIconList">
													<div class="iconChoice">
														<span class="glyphicon glyphicon-plus addThree" title="添加子导航"></span>
														<span class="glyphicon glyphicon-eye-open <c:if test='${child.status}'>hide</c:if>" title="显示导航"></span>
														<span class="glyphicon glyphicon-eye-close <c:if test='${!child.status}'>hide</c:if>" title="隐藏导航"></span>
														<span class="glyphicon glyphicon-menu-up" title="上移导航"></span>
														<span class="glyphicon glyphicon-menu-down" title="下移导航"></span>
														<span class="glyphicon glyphicon-remove" title="删除导航"></span>
													</div>
												</div>
												<c:if test="${child.children ne null }">
													<c:forEach items="${child.children }" var="kid">
													<div class="col-md-12 threeTemplate">
														<input type="hidden" value="${kid.id }" class="naviThreeId selfId">
														<input type="hidden" value="${kid.parentId }" id="naviThreeParentId">
														<div class="col-sm-1"></div>
														<div class="col-sm-1">
															<span class="glyphicon glyphicon-calendar iconFont"
																title="选择图标"></span>
														</div>
														<div class="col-sm-2">
															<input type="text" class="form-control thirdTitle" placeholder="标题" value="${kid.naviName }">
														</div>
														<div class="col-sm-5">
															<input type="text" class="form-control thirdUrl" placeholder="链接地址" value="${kid.url }">
														</div>
														<div class="col-sm-3">
															<div class="iconChoice">
																<span class="glyphicon glyphicon-eye-open <c:if test='${kid.status}'>hide</c:if>" title="显示导航"></span>
																<span class="glyphicon glyphicon-eye-close <c:if test='${!kid.status}'>hide</c:if>" title="隐藏导航"></span>
																<span class="glyphicon glyphicon-menu-up" title="上移导航"></span>
																<span class="glyphicon glyphicon-menu-down" title="下移导航"></span>
																<span class="glyphicon glyphicon-remove" title="删除导航"></span>
															</div>
														</div>
													</div></c:forEach></c:if>
											</div></c:forEach></c:if>
									</div></c:if>
								</c:forEach>	
							</div>
							<div class="row">
								<div class="col-sm-2 col-sm-offset-5">
									<button class="btn btn-primary" id="saveNavigation" style="width:100%">保存</button>								
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script id="tpl-oneNav" type="text/html">
	<!-- 一级 -->
	<div class="moduleNav">
		<div class="row oneTemplate">
			<input type="hidden" class="naviOneId">
			<div class="col-sm-2">
				<input type="text" class="form-control firstTitle" placeholder="标题">
			</div>
			<div class="col-sm-7">
				<input type="text" class="form-control firstUrl" placeholder="链接地址">
			</div>
			<div class="col-sm-3">
				<div class="iconChoice">
					<span class="glyphicon glyphicon-plus addTwo" title="添加子导航"></span>
					<span class="glyphicon glyphicon-eye-open hide" value="true" id="#oneShow" title="显示导航"></span>
					<span class="glyphicon glyphicon-eye-close" value="false" title="隐藏导航"></span>
					<span class="glyphicon glyphicon-menu-up" title="上移导航"></span>
					<span class="glyphicon glyphicon-menu-down" title="下移导航"></span>
					<span class="glyphicon glyphicon-remove" title="删除导航"></span>
				</div>
			</div>
		</div>
	</div>
</script>
<script id="tpl-twoNav" type="text/html">
	<div class="row twoTemplate">
		<input type="hidden" class="naviTwoId">
		<div class="col-sm-1"></div>
		<div class="col-sm-8">
			<input type="text" class="form-control secondTitle" placeholder="标题" id="twoName">
		</div>
		<div class="col-sm-3 secondIconList">
			<div class="iconChoice">
				<span class="glyphicon glyphicon-plus addThree" title="添加子导航"></span>
				<span class="glyphicon glyphicon-eye-open hide" value="true" id="#twoShow" title="显示导航"></span>
				<span class="glyphicon glyphicon-eye-close" value="false" title="隐藏导航"></span>
				<span class="glyphicon glyphicon-menu-up" title="上移导航"></span>
				<span class="glyphicon glyphicon-menu-down" title="下移导航"></span>
				<span class="glyphicon glyphicon-remove" title="删除导航"></span>
			</div>
		</div>
	</div>
</script>

<script id="tpl-threeNav" type="text/html">
	<div class="col-md-12 threeTemplate">
		<input type="hidden" class="naviThreeId">
		<div class="col-sm-1"></div>
		<div class="col-sm-1">
			<span class="glyphicon glyphicon-calendar iconFont"
				title="选择图标" id="threeIcon"></span>
		</div>
		<div class="col-sm-2">
			<input type="text" class="form-control thirdTitle" placeholder="标题" id="threeName">
		</div>
		<div class="col-sm-5">
			<input type="text" class="form-control thirdUrl" placeholder="链接地址" id="threeUrl">
		</div>
		<div class="col-sm-3">
			<div class="iconChoice">
				<span class="glyphicon glyphicon-eye-open hide" value="true" id="#threeShow" title="显示导航"></span>
				<span class="glyphicon glyphicon-eye-close" value="false" title="隐藏导航"></span>
				<span class="glyphicon glyphicon-menu-up" title="上移导航"></span>
				<span class="glyphicon glyphicon-menu-down" title="下移导航"></span>
				<span class="glyphicon glyphicon-remove" title="删除导航"></span>
			</div>
		</div>
	</div>
</script>

<script id="typesettingTemplate" type="text/html">
	{{each list value index}}
		{{if value.type == 1}}
			<div class="col-sm-12 typeset" data-id="{{value.id}}" data-sort="{{value.sort}}">
				<div class="col-sm-11">
					<div class="moduleDiv">{{value.composingName}}</div>
				</div>
				<div class="col-sm-1">
					<ul class="iconList">
						<li class="{{value.status==true?'hide':''}}"><span class="glyphicon glyphicon-eye-open" title="显示"></span></li>
						<li class="{{value.status==true?'':'hide'}}"><span class="glyphicon glyphicon-eye-close" title="隐藏"></span></li>
						<li><span class="glyphicon glyphicon-menu-up {{index==0?'disabled':''}}" title="上移"></span></li>
						<li><span class="glyphicon glyphicon-menu-down {{index==(list.length-1)?'disabled':''}}" title="下移"></span></li>
					</ul>
				</div>
			</div>
		{{else}}
			<div class="col-sm-6 typeset" data-id="{{value.id}}" data-sort="{{value.sort}}">
				<div class="col-sm-10">
					<div class="moduleDiv">{{value.composingName}}</div>
				</div>
				<div class="col-sm-2">
					<ul class="iconList">
						<li class="{{value.status==true?'hide':''}}"><span class="glyphicon glyphicon-eye-open" title="显示"></span></li>
						<li class="{{value.status==true?'':'hide'}}"><span class="glyphicon glyphicon-eye-close" title="隐藏"></span></li>
						<li><span class="glyphicon glyphicon-menu-up {{index==0?'disabled':''}}" title="上移"></span></li>
						<li><span class="glyphicon glyphicon-menu-down {{index==(list.length-1)?'disabled':''}}" title="下移"></span></li>
					</ul>
				</div>
			</div>
		{{/if}}
	{{/each}}
</script>
<script type="text/javascript">
	var typeSet_html = {};
	var subNavFlag = true;
	
	$(function(){
		$("#files").change(function(){
			var msg = this.files.length;
			if (msg > 0 ) {
				if(msg == 1){
					$("#picname1").val(this.files[0].name);
				} else {
					$("#picname1").val("你已添加"+msg+"个文件");
				}
			}
		});
		$("#uploadPics").on("click",function(){
			var url = "${ctx}/cms/displaySetting/savePics";
			$.ajaxFileUpload({
				url:url,
				type : 'POST',
				dataType : "json",
				data : {
					id : $("#id").val(),
					frequency : $('#freq').val()
				},
				fileElementId : 'files', //这里对应html中上传file的id
				contentType : "application/json;charset=UTF-8",
				success : function(data) {
					reloadPics();
				}
			});
		})
		
		/* 导航-显示隐藏眼镜    */
		$('#navigation').on('click','.glyphicon-eye-open',function(){
			$(this).addClass('hide').siblings('.glyphicon-eye-close').removeClass('hide');
		});
		$('#navigation').on('click','.glyphicon-eye-close',function(){
			$(this).addClass('hide').siblings('.glyphicon-eye-open').removeClass('hide');
		});
		/* 首页排版显示隐藏  */
		$('#homeList').on('click','.glyphicon-eye-open',function(){
			$(this).parent().addClass('hide').next().removeClass('hide');
		});
		$('#homeList').on('click','.glyphicon-eye-close',function(){
			$(this).parent().addClass('hide').prev().removeClass('hide');
		});
		
		/* 添加一级菜单  */
		$('#naviBtn').on('click',function(){
			addOneNav($('#navSetting'));
		});
		/* 添加二级菜单  */
		$('#navSetting').on('click','.addTwo',function(){
			var obj = $(this).parent().parent().parent().parent();
			var length = obj.find('.twoTemplate').length;
			if (length >= 3){
				layer.alert('最多添加三个二级导航类别',{icon: 2})
			}else{
				addTwoNav(obj);
			}
		});
		/* 添加三级菜单   */
		$('#navSetting').on('click','.addThree',function(){
			addThreeNav($(this).parent().parent().parent());
		});
		/* 渲染首页排版模板  */
		getTypesetting();
		/* 保存首页排版  */
		$('#savaHome').on('click',function(){
			var status = [];
			var objs = $('.typeset');
			if (objs.length === 0){
				return ;
			};
			for (var i=0;i<objs.length;i++){
				var obj = {};
				obj.id = $(objs[i]).attr('data-id');
				obj.sort = $(objs[i]).attr('data-sort');
				if ($(objs[i]).find('.glyphicon-eye-close').parent().hasClass('hide')){
					obj.status = false;
				}else{
					obj.status = true;
				}
				status[i] = obj;
			};
			
			saveTypesetting(status);
		});
		/* 首页排版上下排序   */
		$('#homeList').on('click','.glyphicon-menu-up',function(){
			var index = $(this).parent().parent().parent().parent().index();
			var temp = typeSet_html.list[index];
			typeSet_html.list[index] = typeSet_html.list[index-1];
			typeSet_html.list[index-1] = temp;
			var _html = template('typesettingTemplate', typeSet_html);
			$('#homeList').html(_html);
		});
		$('#homeList').on('click','.glyphicon-menu-down',function(){
			var index = $(this).parent().parent().parent().parent().index();
			var temp = typeSet_html.list[index];
			typeSet_html.list[index] = typeSet_html.list[index+1];
			typeSet_html.list[index+1] = temp;
			var _html = template('typesettingTemplate', typeSet_html);
			$('#homeList').html(_html);
		});
		
		/* 保存导航  */
		$('#saveNavigation').on('click',function(){
			var data = [];
			var objs = $('#navSetting').find('.moduleNav');
			if (objs.length == 0){
				return ;
			};
			subNavFlag = true;
			for (var i=0;i<objs.length;i++){
				var obj = {};
				var oneObj = $(objs[i]).find('.oneTemplate');
				obj.naviName = oneObj.find('.firstTitle').val()||'';
				if (obj.naviName === ''){
					layer.alert('请填写一级标题 ',{icon:0});
					subNavFlag = false;
					break;
				};
				obj.id = oneObj.find('.naviOneId').val()||'';
				obj.url = oneObj.find('.firstUrl').val()||'';
				obj.sort = i;
				
				var displaySetting = {id: $("#id").val()};
				obj.displaySetting = displaySetting;
				if (oneObj.find('.glyphicon-eye-close').hasClass('hide')){
					obj.status = false;
				}else{
					obj.status = true;
				};
				obj.children = calcuTwoTemp($(objs[i]).find('.twoTemplate'));
				data[i] = obj;
			};
			if (subNavFlag){
				naviSave(data);
			};
		});
		/* 上移导航  */
		$('#navigation').on('click','.glyphicon-menu-up',function(){
			var obj = $(this).parent().parent().parent();
			var index;
			if (obj.hasClass('oneTemplate')){
				obj = $(this).parent().parent().parent().parent();
				index = obj.parent().find('.moduleNav').index(obj);
			}else if (obj.hasClass('twoTemplate')){
				index = obj.parent().find('.twoTemplate').index(obj);
			}else{
				index = obj.parent().find('.threeTemplate').index(obj);
			}
			if (index != 0 && index != -1){
				obj.prev().before(obj);
			};
		})	
		/* 下移导航  */
		$('#navigation').on('click','.glyphicon-menu-down',function(){
			var obj = $(this).parent().parent().parent();
			var index,length;
			if (obj.hasClass('oneTemplate')){
				obj = $(this).parent().parent().parent().parent();
				index = obj.parent().find('.moduleNav').index(obj);
				length = obj.parent().find('.moduleNav').length;
			}else if (obj.hasClass('twoTemplate')){
				index = obj.parent().find('.twoTemplate').index(obj);
				length = obj.parent().find('.twoTemplate').length;
			}else{
				index = obj.parent().find('.threeTemplate').index(obj);
				length = obj.parent().find('.threeTemplate').length;
			}
			if (index <= (length-1)){
				obj.next().after(obj);
			};
		})	
		/* 删除导航  */
		$('#navigation').on('click','.glyphicon-remove',function(){
			var obj = $(this).parent().parent().parent();
			if (obj.hasClass('oneTemplate')){
				obj = $(this).parent().parent().parent().parent();
			};
			layer.confirm('是否删除导航？',function(index){
				var selfObj = obj.find('.selfId');
				if (selfObj.length == 0){
					obj.remove();
					layer.close(index);
					layer.alert('删除成功',{icon:1})
				}else{
					var id = selfObj.val();
		 			$.ajax({
		 				url:'${ctx}/cms/navigation/delete',
		 				type: 'GET',
		 				data: {
		 					id: id
		 				},
		 				success:function(result){
		 					layer.close(index);
		 					if (result.code === '10000'){
		 						layer.alert(result.msg,{icon:1},function(index){
		 							layer.close(index);
		 							obj.remove();
		 						});
		 					}else{
		 						layer.alert(result.msg,{icon:2})	
		 					}
		 				}
		 			});
				}
				
			});

		})	
	});
	function calcuTwoTemp(objs) {
		var ary = [];
		if (objs.length != 0){
			for (var i=0;i<objs.length;i++){
				var obj = {};
				var oneObj = $(objs[i]);
				obj.naviName = oneObj.find('.secondTitle').val()||'';
				if (obj.naviName === ''){
					layer.alert('请填写二级标题',{icon:0});
					subNavFlag = false;
					break;
				};
				obj.id = oneObj.find('.naviTwoId').val()||'';
				obj.sort = i;
				obj.parentId = $("#naviTwoParentId").val();
				var displaySetting = {id: $("#id").val()};
				obj.displaySetting = displaySetting;
				if (oneObj.find('.secondIconList .glyphicon-eye-close').hasClass('hide')){
					obj.status = false;
				}else{
					obj.status = true;
				};
				obj.children = calcuThreeTemp($(objs[i]).find('.threeTemplate'));
				ary[i] = obj;
			};
		}
		return ary;
	}
	
	function calcuThreeTemp(objs) {
		var ary = [];
		if (objs.length != 0){
			for (var i=0;i<objs.length;i++){
				var obj = {};
				var oneObj = $(objs[i]);
				obj.naviName = oneObj.find('.thirdTitle').val()||'';
				if (obj.naviName == ''){
					layer.alert('请填写三级标题',{icon:0});
					subNavFlag = false;
					break;
				};
				obj.id=oneObj.find('.naviThreeId').val()||'';
				obj.url = oneObj.find('.thirdUrl').val()||'';
				obj.sort = i;
				obj.icon = '';
				obj.parentId = $("#naviThreeParentId").val();
				var displaySetting = {id: $("#id").val()};
				obj.displaySetting = displaySetting;
				if (oneObj.find('.glyphicon-eye-close').hasClass('hide')){
					obj.status = false;
				}else{
					obj.status = true;
				};
				ary[i] = obj;
			};
		}
		return ary;
	}
	
	function naviSave(data){
		$.ajax({
			url:'${ctx}/cms/navigation/naviSave',
			type: 'POST',
			dataType: 'json',
// 			contentType:'application/json',
			data: {"value":JSON.stringify(data)},
			success:function(result){
				if (result.code === '10000'){
					layer.alert(result.msg,{icon:1},function(){
						window.location.reload();
					})
				}else{
					layer.alert(result.msg,{icon:2})	
				}
				
			}
		});
	};
	
	function getTypesetting() {
		$.ajax({
			url:'${ctx}/cms/composing',
			type: 'get',
			dataType: "json",
			success: function(data) {
				if (data.code === '10000'){
					typeSet_html = {
						list: data.body.compos
					};
					var _html = template('typesettingTemplate', typeSet_html);
					$('#homeList').html(_html);
				}else{
					layer.alert(data.msg,{icon:2})	
				}
			}
		});
	};
	/**/
	function saveTypesetting(data) {
		console.log(data);
		$.ajax({
			url:'${ctx}/cms/composing/save',
			type: 'POST',
			contentType:'application/json',
			dataType: 'json',
			data: JSON.stringify(data),
			success: function(result) {
				if (result.code === '10000'){
					layer.alert(result.msg,{icon:1})
				}else{
					layer.alert(result.msg,{icon:2})	
				}
			}
		});
	};
	
	function addOneNav(obj) {
		var _html = template('tpl-oneNav', {});
		obj.append(_html);
	}
	
	function addTwoNav(obj) {
		var _html = template('tpl-twoNav', {});
		obj.append(_html);
	}
	/* 这里因为icon添加的id必须不一样   */
	var iconId = 1;
	function addThreeNav(obj) {
		var data = { idName: 'icon'+iconId }
		var _html = template('tpl-threeNav',data);
		iconId++;
		obj.append(_html);
	}
	
	function reloadPics(){
		$.ajax({
			url:"${ctx}/cms/displaySetting/homePics",
			type : 'POST',
			dataType : "json",
			data : {
				id : $("#id").val()
			},
			success : function(data) {
				$(".item").siblings().remove();
				var picUrls = data.body.homePics;
				var html = "";
				var clz = "";
				for(var i=0;i<picUrls.length;i++){
					if(i==0){
						clz = "<div class='item active'</div>"
					} else {
						clz = "<div class='item'</div>"
					}
					html = html + clz
					+ "<img src='"+picUrls[i]+"' alt='轮播图预览'/></div>"
				}
				$(".listbox").prepend(html);
			}
		});
	}

</script>
</body>
</html>
