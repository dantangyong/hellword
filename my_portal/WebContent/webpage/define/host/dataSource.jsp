<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>证书生成</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	var validateForm;
	
    function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
      if(validateForm.form()){
          $("#inputForm").submit();
          return true;
      }

      return false;
    }
    $(document).ready(function() {
        $("#name").focus();
        validateForm = $("#inputForm").validate({
            submitHandler: function(form){
                loading('正在提交，请稍等...');
                form.submit();
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
        $("#test").click(function(){
        	if(validateForm.form()){
        		$.ajax({
                    type: "POST",
                    url: "${ctx}/plugin/host/plugins/api/testDataSource",
                    data: {jdbcUrl:$("#jdbcUrl").val(),driverClassName:$("#driverClassName").val(),
                    	username:$("#username").val(),password:$("#password").val()
                    },
                    dataType: "json",
                    success: function(data){
                        if(data.code=="0"){
                            //layer.msg(data.msg,{icon:1,time:1000});
                        	top.layer.confirm(data.msg, {icon: 1, title:'系统提示'});
                        }else{
                        	top.layer.confirm(data.msg, {icon: 2, title:'系统提示'});
                        }
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown){
                        top.layer.confirm(XMLHttpRequest.responseText, {icon: 2, title:'系统提示'});
                    }
                });
        	}
            
        });
    });
    jQuery.extend(jQuery.validator.messages, {
        rangelength: jQuery.validator.format("请输入 一个长度介于 {0} 和 {1} 之间的字母和数字")
    });
		
	</script>
</head>
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="post" action="${ctx}/pluginjsp/host/plugins/saveDataSource" method="post" class="form-horizontal">
		
		
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		      <tr>
                  <td  class="width-20" class="active"><label class="pull-right"><font color="red">*</font>插件:</label></td>
                  <td class="width-30" style="width: 350px" colspan="2">
                      <input id="name" name="name" type="" class="form-control" value="${pi.name}" readonly="readonly">
                  </td>
              </tr>
              <tr>
                  <td  class="width-20" class="active"><label class="pull-right"><font color="red">*</font>编码:</label></td>
                  <td class="width-30" colspan="2">
                      <input id="code" name="code" type="" class="form-control" value="${pi.code}" readonly="readonly">
                  </td>
              </tr>
		      <tr>
		         <td  class="width-20" class="active"><label class="pull-right"><font color="red">*</font>数据库连接:</label></td>
		         <td class="width-30" colspan="2">
		              <input id="jdbcUrl" name="jdbcUrl" type="" class="form-control required" value="${dsi.jdbcUrl}" maxlength="200">
		         </td>
		      </tr>
		      <tr>
                 <td  class="width-20" class="active"><label class="pull-right"><font color="red">*</font>驱动类:</label></td>
                 <td class="width-30" colspan="2">
                      <input id="driverClassName" name="driverClassName" type="" class="form-control required" value="${dsi.driverClassName}" maxlength="100">
                 </td>
              </tr>
              <tr>
                 <td  class="width-20" class="active"><label class="pull-right"><font color="red">*</font>数据库账号:</label></td>
                 <td class="width-30" >
                      <input id="username" name="username" type="text" class="form-control required" value="${dsi.username}" maxlength="64" autocomplete="off">
                 </td>
                 <td rowspan="2">
                     <a href="javascript:void(0);" id="test" class="btn btn-primary btn-sm" >测试连接</a>
                 </td>
              </tr>
              <tr>
                 <td  class="width-20" class="active"><label class="pull-right"><font color="red">*</font>数据库密码:</label></td>
                 <td class="width-30" >
                      <input id="password" name="password" type="password" class="form-control required" value="${dsi.password}" maxlength="64" autocomplete="off">
                 </td>
              </tr>
              
	      </tbody>
	      </table>
	</form:form>
</body>
</html>