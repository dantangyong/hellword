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
    });
    jQuery.extend(jQuery.validator.messages, {
        rangelength: jQuery.validator.format("请输入 一个长度介于 {0} 和 {1} 之间的字母和数字")
    });
		
	</script>
</head>
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="post" action="${ctx}/pluginjsp/host/license/saveLicense" method="post" class="form-horizontal">
		
		
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
		         <td  class="width-20" class="active"><label class="pull-right"><font color="red">*</font>证书:</label></td>
		         <td class="width-30"><textarea id="license" name="license"  class="form-control required" style="word-wrap:break-word;word-break:break-all;height: 150px;resize: none"></textarea></td>
		      </tr>
		      
	      </tbody>
	      </table>
	</form:form>
</body>
</html>