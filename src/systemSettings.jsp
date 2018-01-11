<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<link href="${ctxStatic}/swjtu/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
<script src="${ctxStatic}/common/ajaxfileupload.js"></script>
<style>
label.error{
color:red;
}
</style> 
<div class="common-style" id="system">
    <div class="col-xs-12 common-style-right">
        <p class="bold-font">学校简介</p>
        <div class="school-intro border-style">
            <form class="form-horizontal" id="settingForm">
                <input type="hidden" name="id" id="id" value="">
                <div class="form-group">
                    <label for="title" class="col-sm-1 control-label">标 题:</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control required" id="title" name="name">
                    </div>
                </div>
                <div class="form-group">
                    <label for="aliasName" class="col-sm-1 control-label">英文名:</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" id="aliasName" name="aliasName">
                    </div>
                </div>
                <div class="form-group">
                    <label for="key-words" class="col-sm-1 control-label">关键词:</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" id="key-words" name="keyWord">
                    </div>
                </div>
                <div class="form-group">
                    <label for="content" class="col-sm-1 control-label">内 容:</label>
                    <div class="col-sm-10">
                        <p class="text-danger" style="display: none;margin:10px 0;">输入字数不能超过200！</p>
                        <textarea type="text" class="form-control" id="content" name="description" rows="8" placeholder="请输入内容，不超过200字"></textarea>
                    </div>
                </div>
                <div class="form-group text-right btn-position">
                    <button class="btn btn-md confirm" type="button">保存</button>
                </div>
            </form>
        </div>
        <p class="bold-font distance">教师墙</p>
        <div class="border-style parent">
            <div class="modify-content">
                <div class="row">
                    <form class="form-horizontal" id="settingForm">
                     <div class="col-sm-3">
                        <div class="wrap-img text-center">
                            <img src="${ctxStatic}/swjtu/images/header1.png" class="img-circle">
                            <a href="javascript:void(0);" class="file">修改图像
                                <input type="file" name="file" class="choose-file" id="file" style="opacity: 0;">
                            </a>
                        </div>
                    </div>
                    <div class="col-sm-9">
                       
                            <div class="form-group">
                                <label for="uname" class="col-sm-1 control-label">姓 名:</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control required" id="title" name="name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="job" class="col-sm-1 control-label">职 位:</label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control" id="job" name="keyWord">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="intro" class="col-sm-1 control-label">介 绍:</label>
                                <div class="col-sm-10">
                                    <p class="text-danger" style="display: none;margin:10px 0;">输入字数不能超过50！</p>
                                    <textarea type="text" class="form-control" name="description" id="intro" rows="4" placeholder="请输入介绍，不超过50字"></textarea>
                                </div>
                            </div>
                            <div class="form-group text-right btn-position">
                                 <button class="btn btn-md confirm" type="button" value="image" id="uploadImage">保存</button>
                            </div>
                      </div>
                    </form>
                </div>
            </div>
        </div>
        <p class="bold-font distance">异常判定标准</p>
        <div class="back-white">
            <div class="table-responsive">
                <div class="head" content="text-right" id="head">
                    <button class="btn btn-md add">
                        <span class="fa fa-plus"></span> 添加
                    </button>
                </div>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>项目</th>
                        <th>项目值</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="standardContent">
		               
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!--学校简介，教师墙操作提示框-->
<div class="modal fade warning-text">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-center text-danger">确认操作</h4>
            </div>
            <div class="modal-body">
                <p class="text-center text-warning">确认进行 <span class="key text-danger"></span> 操作？</p>
            </div>
            <div class="modal-footer text-right">
                <button type="button" class="btn btn-md confirm" id="settingSave">确认</button>
                <button type="button" class="btn btn-md normal" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!--异常操作提示框-->
<div class="modal fade standard-text">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-center text-danger">确认操作</h4>
            </div>
            <div class="modal-body">
                <p class="text-center text-warning">确认进行 <span class="key text-danger"></span> 操作？</p>
            </div>
            <div class="modal-footer text-right">
                <button type="button" class="btn btn-md confirm" id="standard">确认</button>
                <button type="button" class="btn btn-md normal" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!--添加参数-->
<div class="modal fade add-info">
    <div class="modal-dialog modal-lg change-size">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-center text-danger">添加项目</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-12 col-sm-2 rules">
                        <p>项目:</p>
                        <p>项目值:</p>
                        <p class="empty"></p>
                        <p>状态</p>
                    </div>
                    <div class="col-xs-12 col-sm-5">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="item-name" class="col-sm-3 control-label">项目名称</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="item-name" name="standardName">
                                </div>
                            </div>
                            <div class="form-group show-time-range">
                                <label class="col-sm-3 control-label">时间区间</label>
                                <div class="col-sm-9 time-range">
					                <div class="input-group date form_time col-md-5" data-date="" data-date-format="hh:ii" data-link-field="dtp_input3" data-link-format="hh:ii">
					                    <input class="form-control" size="16" type="text" value="" id="startTime" name="startTime" readonly>
					                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					                </div>
					                <div class="input-group date form_time col-md-5" data-date="" data-date-format="hh:ii" data-link-field="dtp_input3" data-link-format="hh:ii">
					                    <input class="form-control" size="16" type="text" value="" id="endTime" name="endTime" readonly>
					                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					                </div>
<!-- 									<input type="hidden" id="dtp_input3" value="" /><br/> -->
<!--                                     <input type="time" class="form-control" id="timeRangeEnd" placeholder="请输入结束时间"> -->
                                </div>
                            </div>
                            <div class="form-group show-time-length">
                                <label for="longtime" class="col-sm-3 control-label">时间长度</label>
                                <div class="col-sm-9">
                                    <input type="number" class="form-control" id="longtime" value="0" name="outStandard">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="choose" class="col-sm-3 control-label">状态设置</label>
                                <div class="col-sm-9">
                                    <select type="number" class="form-control" id="choose" name="status">
                                        <option value="1">启用</option>
                                        <option value="2">禁用</option>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-xs-12 col-sm-5 rules colors">
                        <p>截止配置时间,最后通过记录不是刷卡进入则为未归</p>
                        <p>添加项目时,时间区间和时间长度任选其一</p>
                        <p>在起始配置时间后刷卡出去，则记为晚出</p>
                        <p>在配置时间内刷卡，则记为晚归</p>
                        <p>人员超过配置的小时数未打卡，则记为长时间未出入</p>
                       
                    </div>
                </div>
            </div>
            <div class="modal-footer text-right">
                <button type="button" class="btn btn-md confirm" id="standardSave">确认</button>
                <button type="button" class="btn btn-md normal" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>



<script src="${ctxStatic}/jquery-validation/1.14.0/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.14.0/localization/messages_zh.min.js" type="text/javascript"></script>
<!-- 引入自定义的jQuery validate的扩展校验 -->
<script src="${ctxStatic}/common/validateExtend.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.14.0/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/swjtu/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctxStatic}/swjtu/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
	$('.form_time').datetimepicker({
	    language:  'zh-CN',
	    weekStart: 1,
	    todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 1,
		minView: 0,
		minuteStep:5,
		maxView: 1,
		forceParse: 0
	});
 
	
  $("tbody").on("click","button:contains('编辑')",function () {
    var html=$(this).parent().prev().prev().prev().html();
    var standardId = this.value;
    updateStandard(standardId);
   
      $(".add-info").modal("show");
      $(".add-info .empty").show();
      $(".add-info .show-time-range").show();
      $(".add-info .show-time-length").show();
    
  });
  $(".head button:contains('添加')").click(function () {
    $(".add-info").modal("show");
    $(".add-info .empty").show();
    $(".add-info .show-time-range").show();
    $(".add-info .show-time-length").show();
  })
  

  
  
</script>
<script type="text/javascript">
  $(function () {
    $("#content").keyup(function () {
      var len=this.value.length;
      if(len>200)
        $(this).prev().show();
      else
        $(this).prev().hide();
    });
    $("#intro").keyup(function () {
      var len=this.value.length;
      if(len>50)
        $(this).prev().show();
      else
        $(this).prev().hide();
    });
    /*改头像*/
    $("#system").on("change",".choose-file",function () {
      var $file = $(this);
      var fileObj = $file[0];
      var windowURL = window.URL || window.webkitURL;
      var dataURL;
      var $img = $(this).parent().prev();
      if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        var file = this.files[0];//上传的图片的所有信息
        //首先判断是否是图片
        if(!/image\/\w+/.test(file.type)){
          alert('上传的不是图片');
          return false;
        }
        //在此限制图片的大小
        var imgSize = file.size;
        //35160  计算机存储数据最为常用的单位是字节(B)
        //在此处我们限制图片大小为2M
        if(imgSize>2*1024*1024){
          alert('上传的图片的大于2M,请重新选择');
          $(this).val('');
          return false;
        }
        else{
          $img.attr('src', dataURL);
        }
      } else {
        dataURL = $file.val();
        var imgObj = $img;
        // 两个坑:
        // 1、在设置filter属性时，元素必须已经存在在DOM树中，动态创建的Node，也需要在设置属性前加入到DOM中，先设置属性在加入，无效；
        // 2、src属性需要像下面的方式添加，上面的两种方式添加，无效；
        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
        imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;
      }
    }).on("click","button:contains('保存')",function () {
      $(".warning-text").modal("show");
      imageValue = this.value;
      $(".warning-text p span").html(this.innerHTML);
    });
  });

  /*验证  */
  var validateForm;
 $(document).ready(function() { 
	  validateForm = $("#settingForm").validate({
			rules: {
				name:{
					remote:{                                         
		               type:"POST",
		               url:"${ctx}/swjtu/setting/checkName",
		               data:{
		                 name:function(){return $("#title").val();},
		               } 
		            }
				},
			},
			messages: {
				   name: {remote: "名称已存在"
					   },
				}
		});
 }); 
 
 /* 初始化数据  */
 $(document).ready(function(){
 	
 	 getStandardList();
		
	});
 function getStandardList(){
	 $.ajax({
			type:"POST",
			url:"${ctx}/swjtu/setting/list",
			success:function(date){
				$("#standardContent").empty();
				$("#standardContent").html(date);
			}
		});  
 }
 
 
 /* 保存 学校简介，教师墙信息 */
 var imageValue;
  $("#settingSave").click(function(){
	  $(".warning-text").modal("hide");
	 if ("image" == imageValue) {
		 var uname = $("#uname").val();
		 var keyword = $("#job").val();
		 var drc = $("#intro").val();
		 $.ajaxFileUpload({  
			    type: 'post',
	            url:'${ctx}/swjtu/setting/uploadFile?name='+uname+"&keyWord="+keyword+"&description="+drc, 
	            fileElementId: 'file',
	            dataType: 'JSON',
	            contentType:"application/json",
	            success: function (date) {  
	            	 $(".setting-message").html(date.msg);
	            }
	     });
		 $("#setting-message").modal("show");
	 } else {
		 $.ajax({
				type:"POST",
				url:"${ctx}/swjtu/setting/save",
			    data:$("#settingForm").serialize(),
				success:function(date){
					 $(".setting-message").html(date.msg);
			    }
			});
	
		 $("#setting-message").modal("show");
     }
  
  });

  
  function refresh(){
	  getStandardList();
  }
  
  
/* 添加异常 判断  */  
 $("#standardSave").click(function(){
	 var standardName = $("#item-name").val();
	 var startTime = $("#startTime").val();
	 var endTime = $("#endTime").val();
 	 var outStandard = $("#longtime").val();
	 var status = $("#choose").val();
	 var id =  $("#id").val();
     $(".add-info").modal("hide");
	 $.ajax({
			type:"POST",
			url:"${ctx}/swjtu/standard/save",
		    data:{
		    	standardName:standardName,
		    	startTime:startTime,
		    	endTime:endTime,
 		    	outStandard:outStandard,
			    status:status,
			    id:id
		    },
			success:function(date){
				 $(".standard-message").html(date.msg);
		    }
		});

	 $("#standard-message").modal("show");
 
 
 });
 
 /* update 数据回显  */
	function updateStandard(id){
		 $.ajax({
			  type:"POST",
			  url:"${ctx}/swjtu/standard/get",
			  dataType: 'json',
			  data: {"id":id},
				success:function(date){
					$("#item-name").val(date.standardName);
					$("#id").val(date.id);
				    $("#startTime").val(date.startTime);
				    $("#endTime").val(date.endTime);
	 				$("#longtime").val(date.outStandard);
					if ("1" == date.status) {
	 					$("#choose option[value='1']").attr("selected","selected");
					} else {
	 					$("#choose option[value='2']").attr("selected","selected");
	 				}
	 			}
	 		});
	    
	}
  
  
</script>