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
			$("#submit").click(function(){
				$.ajax({
					type: "POST",
                    url: "${ctx}/pluginjsp/host/license/getLicense",
                    data: {code:$("#code").val(),month:$("#month").val()},
                    dataType: "json",
                    success: function(data){
                        if(data.code=="0"){
                            //layer.msg(data.msg,{icon:1,time:1000});
                            $("#license").text(data.msg);
                            $("#license").parents("tr").show();
                        }else{
                            layer.msg(data.msg,{icon:2,time:1000});
                        }
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown){
                        top.layer.confirm(XMLHttpRequest.responseText, {icon: 2, title:'系统提示'});
                    }
				});
			});
		});
		
	</script>
</head>
<body class="hideScroll">
	<form id="inputForm" method="post" onsubmit="return false;" class="form-horizontal">
		
		
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		      <tr>
                  <td  class="width-20" class="active"><label class="pull-right"><font color="red">*</font>插件:</label></td>
                  <td class="width-30" style="width: 350px">
                      <input id="name" name="name" type="" class="form-control" value="${pi.name}" readonly="readonly">
                  </td>
              </tr>
              <tr>
                  <td  class="width-20" class="active"><label class="pull-right"><font color="red">*</font>编码:</label></td>
                  <td class="width-30">
                      <input id="code" name="code" type="" class="form-control" value="${pi.code}" readonly="readonly">
                  </td>
              </tr>
		      <tr>
		          <td  class="width-20" class="active"><label class="pull-right"><font color="red">*</font>时间(月数):</label></td>
		          <td class="width-30">
		              <select id="month" name="month" class="form-control">
			              <option value="1">1</option>
			              <option value="3">3</option>
			              <option value="6">6</option>
			              <option value="12">12</option>
			              <option value="24">24</option>
			              <option value="36">36</option>
		              </select>
		          </td>
		      </tr>
		      <tr style="display: none;">
		         <td  class="width-20" class="active"><label class="pull-right">证书:</label></td>
		         <td class="width-30"><p id="license" name="license"  class="form-control" readonly="readonly" style="word-wrap:break-word;word-break:break-all;height: 150px"></p></td>
		      </tr>
		      <tr>
		         <td colspan=2" style="text-align: center;">
		             <a href="javascript:void(0);" id="submit" class="btn btn-primary btn-sm" >生成证书</a>
		         </td>
		      </tr>
	      </tbody>
	      </table>
	</form>
</body>
</html>