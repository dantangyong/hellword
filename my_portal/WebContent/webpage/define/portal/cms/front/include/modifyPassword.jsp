<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<style>
label.error {
    color: #cc5965;
    display: inline-block;
    margin-left: 5px;
    margin-bottom: 0px !important;
}
</style>

<div class="modal fade" id="show-password">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h5 class="modal-title">修改密码</h5>
            </div>
            <div class="modal-body">
                <form action="" method="post" id="form-pwd" onsubmit="return false;">
                    <div class="form-group">
                        <label for="oldPwd">旧密码</label>
                        <input type="text" class="form-control" id="oldPwd" name="oldPwd" placeholder="旧密码" autocomplete="off" onfocus="this.type='password'" >
                    </div>
                    <div class="form-group">
                        <label for="newPwd">新密码</label>
                        <input type="text" class="form-control" id="newPwd" name="newPwd" placeholder="新密码" autocomplete="off" onfocus="this.type='password'" >
                    </div>
                    <div class="form-group">
                        <label for="repeatPwd">确认密码</label>
                        <input type="text" class="form-control" id="repeatPwd" name="repeatPwd" placeholder="确认密码" autocomplete="off" onfocus="this.type='password'" >
                    </div>
                </form>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="confirm" id="submit">确认</button>
                <button type="button" class="cancel" data-dismiss="modal" id="pwdCancel">关闭</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="show_msg">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h5 class="modal-title">消息提示</h5>
            </div>
            <div class="modal-body">
                <p id="pwd_msg" style="margin-left: 10px;margin-right: 10px"></p>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="confirm" data-dismiss="modal">确认</button>
            </div>
        </div>
    </div>
</div>
<script src="${ctxStatic}/jquery-validation/1.14.0/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.14.0/localization/messages_zh.min.js" type="text/javascript"></script>
<script type="text/javascript">
var validator =null;
$(function () {
    $('.modify-password').click(function () {
        $('#show-password').modal('show');
    });

    validator =$("#form-pwd").validate({
        rules:{
            oldPwd:{
                required:true,
                minlength:6,
                maxlength:20
            },
            newPwd:{
                required:true,
                minlength:6,
                maxlength:20
            },
            repeatPwd:{
                required:true,
                minlength:6,
                maxlength:20,
                equalTo: "#newPwd"  
            }
        },
        messages:{
            oldPwd:{
                required:"旧密码必须填写",
                minlength:"至少输入6个字符",
                maxlength:"不能超过20个字符"
            },
            newPwd:{
                required:"新密码必须填写",
                minlength:"至少输入6个字符",
                maxlength:"不能超过20个字符"
            },
            repeatPwd:{
                required:"确认密码必须填写",
                equalTo:"确认密码不等于新密码"
            }
        },
        onkeyup:false,
        focusCleanup:true,
        success:"valid",
        errorPlacement:function(error,element) {  
            //console.log(error);
            //console.log(element);
            if(error&&error.length){
            	var errorhtml=$("#"+error[0].id);
            	if(errorhtml&&errorhtml.length){
            		errorhtml.text(error[0].outerText);
            	}else{
            		var html='<div id="'+error[0].id+'" style="color:red;">'+error[0].outerText+'</div>';
                    $(element).after(html);
            	}
            }
        },
        submitHandler:function(form){
            
        }
    });
    $("#pwdCancel").on("click",function(){
    	$("#oldPwd").val("");
        $("#newPwd").val("");
        $("#repeatPwd").val("");
    });
    $("#submit").on("click",function(){
        if(validator.form()){
            if($("#submit").hasClass("ing")){
                return;
            }
            $("#submit").addClass("ing");
            $.ajax({
                type: "POST",
                url: "${ctx}/cms/usercenter/modifyPwd",
                data: {
                    oldPwd:$("#oldPwd").val(),
                    newPwd:$("#newPwd").val()
                    },
                dataType: "json",
                success: function(data){
                    $("#submit").removeClass("ing");
                    if(data.code==0){
                        $("#pwd_msg").text(data.msg);
                        $('#show-password').modal('hide');
                        $('#show_msg').modal('show');
                        $("#oldPwd").val("");
                        $("#newPwd").val("");
                        $("#repeatPwd").val("");
                    }else{
                        $("#pwd_msg").text(data.msg);
                        $('#show_msg').modal('show');
                    }
                },
                error:function(XMLHttpRequest, textStatus, errorThrown){
                    
                }
            });
        }else{
        }
    });

});
</script>