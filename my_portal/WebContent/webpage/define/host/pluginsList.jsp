<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>插件列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	jQuery(function($){
	    // 备份jquery的ajax方法  
	    var _ajax=$.ajax;
	    // 重写ajax方法，先推断登录在运行success函数 
	    $.ajax=function(opt){
	        var _success = opt && opt.success || function(a, b){};
	        var _opt = $.extend(opt, {
	            success:function(data, textStatus){
	                // 判断是否session失效
	                if(typeof(data.code) == "undefined") {
	                    _success(data, textStatus);
	                }else{
	                    if(data.code=="0302"){
	                    	$('.logout', window.parent.document).trigger("click");
	                    }else{
	                        _success(data, textStatus);
	                    }
	                }
	                  
	            }  
	        });
	        _ajax(_opt);
	    };
	});
		function createSQL(obj){
			var $this = $(obj);
			top.layer.confirm("确认要创建该插件数据库吗？", {icon: 3, title:'系统提示'}, function(index){
				top.layer.close(index);
				loading('正在创建数据库，请稍等...');  
				//var name=$this.attr("pluginName")
				$.ajax({
	                type: "GET",
	                url: "${ctx}/plugin/host/plugins/api/createSQL",
	                data: {name:$this.attr("pluginName")},
	                dataType: "json",
	                success: function(data){
	                    closeTip();
	                    if(data.code=="0"){
	                        layer.msg(data.msg,{icon:1,time:1000});
	                    }else{
	                        layer.msg(data.msg,{icon:2,time:1000});
	                    }
	                },
	                error: function(XMLHttpRequest, textStatus, errorThrown){
	                    closeTip();
	                    top.layer.confirm(XMLHttpRequest.responseText, {icon: 2, title:'系统提示'});
	                }
	                
	            });
			});
		}
		function dropSQL(obj){
			var $this = $(obj);
			top.layer.confirm("确认要删除该插件数据库吗？", {icon: 2, title:'系统提示'}, function(index){
				top.layer.close(index);
                loading('正在删除数据库，请稍等...');  
                //var name=$this.attr("pluginName")
                $.ajax({
                    type: "GET",
                    url: "${ctx}/plugin/host/plugins/api/dropSQL",
                    data: {name:$this.attr("pluginName")},
                    dataType: "json",
                    success: function(data){
                        closeTip();
                        if(data.code=="0"){
                            layer.msg(data.msg,{icon:1,time:1000});
                        }else{
                            layer.msg(data.msg,{icon:2,time:1000});
                        }
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown){
                        closeTip();
                        top.layer.confirm(XMLHttpRequest.responseText, {icon: 2, title:'系统提示'});
                    }
                    
                });
			});
		}
		function setAuthCache(pluginCode,authData){
		    sessionStorage.setItem("auth_"+pluginCode, JSON.stringify(authData));
		}
		function into(obj){
			var $this = $(obj);
            //alert($this.attr("pluginCode"));
            //获取用户拥有该插件的权限，将插件权限缓存在浏览器中
            $.ajax({
                type : "GET",
                url : "${ctx}/plugin/host/plugins/api/getUserAuthByPlugin",
                data : {
                    code : $this.attr("pluginCode")
                },
                dataType : "json",
                success : function(data) {
                    //判断权限不为空
                    if(data&&data.length){
                        //缓存权限
                        setAuthCache($this.attr("pluginCode"),data);
                        //跳转页面到插件
                        window.open("${ctx}/pluginjsp/host/plugins/view?pluginUrl="+$this.attr("url"));  
                    }else{
                    	layer.msg("您没有该插件的权限",{icon:2,time:1000});
                        //alert("当前用户没有该插件的权限");
                    }
                }
            });
		}
		
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content" style="height: 100%">
	<div class="ibox" style="height: 100%">
	<div class="ibox-title">
			<h5>插件列表 </h5>
			<div class="ibox-tools">
				<a class="collapse-link">
					<i class="fa fa-chevron-up"></i>
				</a>
				
				<a class="close-link">
					<i class="fa fa-times"></i>
				</a>
			</div>
	</div>
    <div class="ibox-content" style="height: 100%">
	<sys:message content="${message}"/>
	
		<!-- 查询条件 -->
	<div class="row">
	<div class="col-sm-12">
	
	<br/>
	</div>
	</div>
<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			
		</div>
	</div>
	</div>	
	
	<table id="contentTable" style="table-layout: fixed;" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<!-- <th>图标</th> -->
				<th class=" ">应用名称</th>
				<th class=" ">应用编码</th>
				<th class=" " style="width: 50px">排序</th>
				<th class=" " style="width: 100px">类别</th>
				<th class=" " style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;max-width: 30%;">描述</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${list}" var="plugin">
			<tr>
			<!-- <td><img src="${ctxStatic}/images/application.png" style="width: 50px;height: 50px"/></td> -->
                <td>${plugin.name}</td>
                <td>${plugin.code }</td>
                <td>${plugin.order }</td>
                <td>${plugin.category }</td>
                <td style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;max-width: 30%;" title="${plugin.desc }">${plugin.desc }</td>
				<td>
				<a href="javascript:void(0)" onclick="into(this)" pluginName="${plugin.name }" pluginCode="${plugin.code }" url="${plugin.homePage }" class="btn btn-info btn-xs"><i class="fa fa-mail-forward"></i>前往</a>
				<c:if test="${not empty plugin.aboutView }">
				<a href="${plugin.aboutView }" target="_blank" pluginName="${plugin.name }" pluginCode="${plugin.code }" class="btn btn-info btn-xs"><i class="fa fa-mail-forward"></i>说明</a>
				</c:if>
				    <shiro:hasPermission name="plugin:host:plugins:createSQL">
				    <c:if test="${plugin.createSQL }">
                    <a href="javascript:void(0)" onclick="createSQL(this)" pluginName="${plugin.name }" class="btn btn-success btn-xs"><i class="fa fa-edit"></i>创建数据库</a>
                    </c:if>
                    </shiro:hasPermission>
				    <shiro:hasPermission name="plugin:host:plugins:dropSQL">
				    <c:if test="${plugin.dropSQL }">
                        <a href="javascript:void(0)" onclick="dropSQL(this)" pluginName="${plugin.name }" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除数据库</a>
                    </c:if>
                    </shiro:hasPermission>
                    <c:if test="${plugin.license }">
                    <a href="#" onclick="openDialog('保存证书', '${ctx}/pluginjsp/host/license/saveLicenseView?code=${plugin.code }','500px', '450px')" pluginName="${plugin.name }" pluginCode="${plugin.code }" class="btn btn-primary btn-xs"><i class="fa fa-lock"></i>证书</a>
                    </c:if>
                    <c:if test="${plugin.customDataSource }">
                    <a href="#" onclick="openDialog('设置数据源', '${ctx}/pluginjsp/host/plugins/dataSourceView?code=${plugin.code }','500px', '500px')" pluginName="${plugin.name }" pluginCode="${plugin.code }" class="btn btn-primary btn-xs"><i class="fa fa-database"></i>数据源</a>
                    </c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	</div>
	</div>
</body>
</html>
