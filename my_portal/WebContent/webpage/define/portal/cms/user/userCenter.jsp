<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head lang="zh-cn">
    <meta charset="UTF-8">
    <!--2 viewport-->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <!--3、x-ua-compatible-->
    <meta http-equiv="x-ua-compatible" content="IE=edge">
    <title>个人中心</title>
    <!--4、引入两个兼容文件-->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <!--6、引入 bootstrap.css-->
    <link rel="stylesheet" href="${ctxStatic }/user/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic }/user/css/userCenter.min.css">
    <link rel="stylesheet" href="${ctxStatic }/user/css/animate.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/commonHeader.css">
     <link rel="stylesheet" href="${ctxStatic }/layer-v2.3/layer/skin/layer.css" id="layui_layer_skinlayercss">
     <link rel="stylesheet" href="${ctxStatic }/portal/solrShow/css/animate.css">
    <style type="text/css">
        .pageiframe {
	width:100%;
    height: 100%;
}
    thead td{
        color:#575d65 !important;
    }
    .wrap-user-head .show-user-info li{
        color: #575d65 !important;
    }
    #skin .dropdown-menu li:hover {
        color: #ffffff !important;
    }
    #show-app .item ul li img{
        width: 64px;
        height: 64px;
    }
   .distance30{
   padding-left:0px;
   }
   #show-app .item ul li a img{
     box-shadow: 0 0 8px #dadada;
   }
/*    #show-app .item ul li:hover img{ */
/*    width:80px; */
/*    height:80px; */
/*    } */
   
   #show-app .item ul li{
     position: relative;
     transition:all .5s linear;
   }
   #show-app .item ul li:hover{
   	transform:scale(1.1);
   }
  .app_bottom{
      display:none;
	  position:absolute;
	  width:80px;
	  height:25px;
	  bottom:25px;
	  left:0px;
	  background-color: rgba(0, 0, 0, 0.45);
  }
   .app_bottom a{
	   text-align: center;
	   padding:2px 5px;
   }
   #entrance-service .modal-dialog{
    width: 70%;
    position:absolute;
    left:50%;
    top:50%;
    transform: translate(-50%,-50%);
}
#entrance-service .modal-dialog .modal-body{
    min-height:500px;
    overflow-y: scroll;
    overflow-x:hidden;
}
#window-size{
    color:#ccc;
}
#window-size:hover{
    color:#808080;
}
#entrance-service{
	position:fixed;
	left: 0; 
	right: 0; 
	top: 0; 
	bottom: 0; 
	z-index: 11234;
	display: none;
	background-color: #fff;
}
.delIcon{
	font-size:20px;
	color: #1482C7;
	position: absolute;
	right:0px;
	top: 0px;
	text-align: center;
	cursor:pointer;
}
.loading{
	position: absolute;
	left:50%;
	top:50%;
	transform:translate(-50%,-50%);
	z-index: -1;
}
.right-content{
padding-bottom: 40px!important;
}
 #footer{
   margin-top:0px !important;
 }  
    </style>
    <script src="${ctxStatic }/portal/notice/js/jquery-1.11.3.js"></script>
    <script src="${ctxStatic }/layer-v2.3/layer/layer.js"></script>
    <script src="${ctxStatic }/portal/solrShow/js/jquery.raty.min.js"></script>
</head>
<body class="body">
<%@ include file="/webpage/define/portal/cms/front/include/commonHeader.jsp"%>
    <div id="skin">
        <%@ include file="/webpage/define/portal/cms/user/skin.jsp"%>
    </div>
    <div class="container-fluid wrapAll">
        <div class="col-sm-12 right-content">
            <div class="row">
                <div class="col-md-3 col-md-offset-1">
                    <!-- <iframe src="../../../pluginpage/mymessage/index3.html" style="width: 100%;height: 400px;"></iframe> -->
                    <div class="wrap-style">
                        <div class="common-style boxShadow borderRadius no-margin">
                            <div class="header borderRadius header-purple">
                                <p>重要提醒</p>
                                <p>Important reminder</p>
                                <img src="${ctxStatic }/user/images/blueCircle02.png">
                            </div>
                            <div class="content the-height">
                                <ul class="remind-content">
                                    <li><span class="glyphicon glyphicon-bell"></span> <span class="text">系统消息</span> 
                                                          <a href="../../a/notice/oaNotify/self" >
									<span class="right-tips">未读<sapn id="my-message-count"></sapn>条</span></a></li>
                                    <li><span class="glyphicon glyphicon-envelope"></span> <span class="text">邮箱提醒</span>
                                    <a href="../../a/iim/mailBox/list" > <span class="right-tips">未读<span id="mail-unread-count"></span>封</span></a></li>
<!--                                     <li><span class="glyphicon glyphicon-credit-card"></span> <span class="text">校园一卡通</span> <span class="right-tips">余额不足10元</span></li> -->
<!--                                     <li><span class="glyphicon glyphicon-volume-up"></span> <span class="text">成绩通知</span> <span class="right-tips">大学英语60分</span></li> -->
<!--                                     <li><span class="glyphicon glyphicon-book"></span> <span class="text">图书馆</span> <span class="right-tips">还书日期还有2天</span></li> -->
                                </ul>
                            </div>
                            <footer>
                                <a href="javascript:void(0)" menu_name='importantRemind' class="more">MORE</a>
                            </footer>
                        </div>
                    </div>
                </div>
                <div class="col-md-7 distance30">
                    <div class="wrap-style">
                        <div class="common-style boxShadow borderRadius no-margin">
                            <div class="header borderRadius header-lightblue">
                                <p>我的收藏</p>
                                <p>My collection</p>
                                <img src="${ctxStatic }/user/images/blueCircle01.png">
                            </div>
                            <div>
                                <div id="show-app" class="carousel slide" data-ride="carousel" data-interval=false>
                                    <div class="carousel-inner" id="MyCollectionPortal">
                                        
                                    </div>
                                </div>
                            </div>
                            <footer>
                                <a href="javascript:void(0);" menu_name='myCollection' class="more">MORE</a>
                            </footer>
                        </div>
                    </div>
                </div>
                <div class="col-md-5 middle-margin col-md-offset-1">
                    <div class="wrap-style">
                        <div class="common-style boxShadow borderRadius no-margin">
                            <div class="header borderRadius header-orange">
                                <p>我的申请</p>
                                <p>My application</p>
                                <img src="${ctxStatic }/user/images/blueCircle01.png">
                            </div>
                            <div class="content">
                                <div class="table-responsive" id="MyApplyPortal">
                                    <table class="table">
	                                    <thead class="thead">
		                                    <tr>
		                                    <td>申请事项</td>
		                                    <td>当前步骤</td>
		                                    <td>提交时间</td>
		                                    </tr>
	                                    </thead>
                                        <tbody class="to-do">
                                        <tr>
                                            <td title="转正试用申请111111111111"><a href="#">转正试用申请111111111111</a></td>
                                            <td>认识审核中</td>
                                            <td>2017-07-06 &emsp;14:52</td>
                                        </tr>
                                        <tr>
                                            <td>转正试用申请111</td>
                                            <td>认识审核中</td>
                                            <td>2017-07-06 &emsp;14:52</td>
                                        </tr>
                                        <tr>
                                            <td>转正试用申请aaaaaaaaaaaaa</td>
                                            <td>认识审核中</td>
                                            <td>2017-07-06 &emsp;14:52</td>
                                        </tr>
                                        <tr>
                                            <td>转正试用申请</td>
                                            <td>认识审核中aaaaaaa</td>
                                            <td>2017-07-06 &emsp;14:52</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <footer>
                                <a href="javascript:void(0);" menu_name='myApplication' class="more">MORE</a>
                            </footer>
                        </div>
                    </div>

                </div>
                <div class="col-md-5 middle-margin">
                    <div class="wrap-style">
                        <div class="common-style boxShadow borderRadius no-margin">
                            <div class="header borderRadius header-green">
                                <p>我的待办</p>
                                <p>My agent</p>
                                <img src="${ctxStatic }/user/images/blueCircle02.png">
                            </div>
                            <div class="content">
                                <div class="table-responsive" id="MyToDoPortal">
                                    <table class="table">
                                    <thead class="thead">
                                    <tr><td>申请事项</td><td>当前步骤</td><td>提交时间</td></tr>
                                    </thead>
                                        <tbody class="to-do">
                                            <tr>
                                            <td title="转正试用申请111111111111">
                                                <img src="${ctxStatic }/user/images/headLog.png" style="width: 40px;height: 40px;margin-right:10px;">
                                                转正试用申请11111111111111
                                            </td>
                                            <td>认识审核中aaa</td>
                                            <td>2017-07-06 &emsp;14:52</td>
                                        </tr>
                                            <tr>
                                                <td>
                                                    <img src="${ctxStatic }/user/images/headLog.png" style="width: 40px;height: 40px;margin-right:10px;">
                                                    转正试用申请
                                                </td>
                                                <td>认识审核中aaaaaaaaa</td>
                                                <td>2017-07-06 &emsp;14:52</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="${ctxStatic }/user/images/headLog.png" style="width: 40px;height: 40px;margin-right:10px;">
                                                    转正试用申请111111aaa
                                                </td>
                                                <td>认识审核中</td>
                                                <td>2017-07-06 &emsp;14:52</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="${ctxStatic }/user/images/headLog.png" style="width: 40px;height: 40px;margin-right:10px;">
                                                    转正试用申请
                                                </td>
                                                <td>认识审核中</td>
                                                <td>2017-07-06 &emsp;14:52</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <footer>
                                <a href="javascript:void(0);" menu_name='myToDo' class="more">MORE</a>
                            </footer>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <!--弹出服务容器  -->
  <div class="container" id="detail"></div> 
  <!--进入服务内容  -->
  <div id="entrance-service" class="wow lightSpeedIn"
	data-wow-duration=".8s" data-wow-delay=".5s" >
		<img class="loading" src="/mht_service/static/images/loading.gif">
		<span class="delIcon"> <img
			src="/mht_service/static/images/close.png">
		</span>
	    <iframe id="myIframe" width="100%" height="100%;" src=""></iframe>
 </div>
  <input type="hidden" id="userid" value="${fns:getUser().id }">
    <script src="${ctxStatic }/user/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    /*导航菜单高亮 */
    $(document).ready(function(){
    	$("#personal-highlight").css({"background":"#64b8fd"});
    });  
    $(function(){
    	$(".user-menu").click(function(){
    		$("#footer").css("display","none");
    		var $this=$(this);
    		var a=$this.find("a");
    		if($this.hasClass("active")){
    			
    		}else{
    			$(".user-menu").removeClass("active");
                $this.addClass("active")
    			if($this.attr("name")=="userCenter"){
    				$(".wrapAll").show();
    				$(".showIframe").removeClass("showIframe").hide();
    				
    			}else{
    				$(".wrapAll").hide();
    				$(".showIframe").removeClass("showIframe").hide();
    				if($("#"+$this.attr("name")).length>0){
    					$("#"+$this.attr("name")).show().addClass("showIframe");
    				}else{
    					var html='<iframe src="'+a.attr("url")+'" id="'+$this.attr("name")+'" name="'+$this.attr("name")+'" class="showIframe pageiframe"></iframe>';
    					$("body").append(html);
    				}
    				//alert(a.attr("url"));
    			}
                //var url=location.href;
                //alert(url);
                //url=url.split("?")[0];
                location.href="#view_"+$this.attr("name");
    		}
    		
    	})
    	$(".more").click(function(){
    		var $this=$(this);
    		var name=$this.attr("menu_name");
    		$("li[name='"+name+"']").trigger("click");
    	});
    	var localView=location.hash;
    	console.log(localView);
    	if(localView){
    		localView=localView.substring(1);
    		localView=localView.split("_")[1];
    		var ums=$(".user-menu");
            for(var i=0;i<ums.length;i++){
                var um=$(ums[i]);
                if(um.attr("name")==localView){
                    um.trigger("click");
                    break;
                }
            }
    	}
    	getMyCollection();
    	getMyToDo();
    	getUnReadMail();
    	getMessages();
    	getMyApply();
    });
    function getUnReadMail(){
        $.ajax({
            type : "post",
            url : "../../a/plugin/mymessage/mailBox/unread",
            dataType: 'json',
            accept : "application/json",
            success : function(data) {
                $("#mail-unread-count").html(data.noReadCount);
            }
        });
    }
    function getMessages(){
        $.ajax({
            type : "post",
            url : "../../a/notice/oaNotify/self/counts",
            dataType: 'json',
            accept : "application/json",
            success : function(data) {
                $("#my-message-count").html(data);
            }
        });
    }
    function getMyApply(){
        $.ajax({
            type: "GET",
            url: "../../../mht_act/a/api/act/task/apply?loginName=${loginName}",
            data: null,
            dataType: "json",
            success: function(data){
                var html="";
                if(data&&data.length){
                    html+='<table class="table">';
                    html+='<thead class="thead">';
                    html+='<tr>';
                    html+='<td>申请事项</td>';
                    html+='<td>当前步骤</td>';
                    html+='<td>提交时间</td>';
                    html+='</tr>';
                    html+='</thead>';
                    html+='<tbody class="to-do" >';
                    for(var i=0;i<4;i++){
                        if(i<data.length){
                            html+='<tr>';
                            html+='<td title="'+data[i].taskName+'"><a href="'+data[i].url+'" target="_blank" >';
                            html+=data[i].taskName;
                            html+='</a></td>';
                            html+='<td title="'+data[i].actType+'">'+data[i].actType+'</td>';
                            html+='<td title="'+data[i].beginDate+'">'+data[i].beginDate+'</td>';
                            html+='</tr>';
                        }else{
                            break;
                        }
                    }
                    html+='</tbody>';
                    html+='</table>';
                }else{
                    html+=getEmptyHtml();
                }
                $("#MyApplyPortal").html(html);
            },
            error:function(){
                var html="";
                html+=getEmptyHtml();
                $("#MyApplyPortal").html(html);
            }
        })
    }
    function getMyToDo(){
    	$.ajax({
            type: "GET",
            url: "../../../mht_act/a/api/act/task/todo?loginName=${loginName}",
            data: null,
            dataType: "json",
            success: function(data){
            	var html="";
            	if(data&&data.length){
                	html+='<table class="table">';
                	html+='<thead class="thead">';
                    html+='<tr>';
                    html+='<td>申请事项</td>';
                    html+='<td>当前步骤</td>';
                    html+='<td>提交时间</td>';
                    html+='</tr>';
                    html+='</thead>';
                    html+='<tbody class="to-do" >';
                    for(var i=0;i<4;i++){
                    	if(i<data.length){
                    		html+='<tr>';
                            html+='<td title="'+data[i].procDefName+'">';
                            if(data[i].userAvatar){
                            	html+='<img src="'+data[i].userAvatar+'" style="width: 40px;height: 40px;margin-right:10px;">';
                            }else{
                            	html+='<img src="${ctxStatic }/user/images/headLog.png" style="width: 40px;height: 40px;">';
                            }
                            html+=data[i].procDefName;
                            html+='</td>';
                            html+='<td title="'+data[i].taskName+'"><a href="'+data[i].url+'" target="_blank" >'+data[i].taskName+'</a></td>';
                            html+='<td title="'+data[i].taskCreateTime+'">'+data[i].taskCreateTime+'</td>';
                            html+='</tr>';
                    	}else{
                    		break;
                    	}
                    }
                    html+='</tbody>';
                    html+='</table>';
                }else{
                	html+=getEmptyHtml();
                }
                $("#MyToDoPortal").html(html);
            },
            error:function(){
            	var html="";
            	html+=getEmptyHtml();
            	$("#MyToDoPortal").html(html);
            }
    	})
    }
    function getEmptyHtml(){
    	return '<img src="${ctxStatic }/user/images/empty.png" style="position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);"/>';
    }
    function getMyCollection(){
    	$.ajax({
            type: "GET",
            url: "../../a/plugin/mycollection/getMyCollectionGroup",
            data: null,
            dataType: "json",
            success: function(data){
                var html="";
                if(data&&data.length){
                	var pagenum=Math.ceil(data.length/18);
                	for(var i=0;i<pagenum;i++){
                		if(i==0){
                			html+='<div class="item active">';
                		}else{
                			html+='<div class="item">';
                		}
                		html+='<ul>';
                		var j=18;
                		if((18*(i+1))>data.length){
                			j=data.length-(i*18);
                		}
                		for(var m=0;m<j;m++){
                			var t=i*18+m;
//                 			html+='<li><a href="'+data[t].serviceUrl+'" target="_blank" >';
                            html+='<li id=li_0'+m+'><a href="#">';
                            html+='<img src="'+data[t].serviceImg+'" alt=""><br>';  
                            html+='<span class="show-one" style="display: inline-block;max-width: 80px;" title="'+data[t].serviceName+'">'+data[t].serviceName+'</span></a>';
                            html+='<div class="app_bottom"><a href="#" class="serviceItem btn btn-success btn-xs" data-id="'+data[t].id+'">查看</a></div>';
                            html+='</li>';
                		}
                		html+='</ul>';
                		html+='</div>';
                	}
                	html+='<ul class="carousel-indicators">';
                	for(var i=0;i<pagenum;i++){
                		if(i==0){
                			html+='<li class="active" data-target="#show-app" data-slide-to="0"></li>'
                		}else{
                			html+='<li data-target="#show-app" data-slide-to="'+i+'"></li>'
                		}
                	}
                    
                    html+='</ul>'
                }else{
                	html+=getEmptyHtml();
                }
                
                $("#MyCollectionPortal").html(html);
                
            },
            error:function(){
            	
            }
    	})
    }
    </script>
    <script type="text/javascript">
    var validator =null;
    $(function () {
        $('.modify-password').click(function () {
            $('#show-password').modal('show');
        });
        $('.modify-avatar').click(function () {
            $('#show-avatar').modal('show');
        });
 /*=================收藏服务======start====================*/       
        starShow();
        /*收藏移入移出效果*/
     $(document).on("mouseenter","#show-app .item ul li",function(){
    	 $(this).find(".app_bottom").show();
     });
     $(document).on("mouseleave","#show-app .item ul li",function(){
    	 $(this).find(".app_bottom").hide();
     });
     
     /* 待移出li:id 全局变量 */
     var li_index = null;
     $(document).on("click",".serviceItem",function(){
    	 li_index = $(this).parent().parent("li").attr("id");
			$.ajax({
				url : '/mht_service/a/service/serviceFrontManage/detail',
				type : 'GET',
				data : {
					id : $(this).attr("data-id"),
					userid : $("#userid").val(),
				},
				success : function(data) {
					//$("#detail").empty();
					$("#detail").empty().html(data);
					$('#detailModal').modal('show');
				}
			});
		})
        
		/*展示星星*/
		 function starShow(){
			 $(".readonly-rate").raty({
			        readOnly:true,
			        number : 5,//星星个数
			        path : '/mht_portal/static/portal/images/',//图片路径
			        starOn : 'yellowStar-s.png',
			        starHalf:'halfStar.png',
			        starOff : 'grayStar-s.png',
			        hints : ['很差','一般','不错','很好','满意'],
			        score: function() {
			            return $(this).attr('data-score');
			        }
			    });
			    $(".rate").raty({
			        number : 5,//星星个数
			        path : '/mht_portal/static/portal/images/',//图片路径
			        starOn : 'yellowStar.png',
			        starOff : 'grayStar.png',
			        starHalf:'halfStar.png',
			        target : '.title',//
			        hints : ['很差','一般','不错','很好','满意'],
			        score: function() {
			            return $(this).attr('data-score');
			        }
			    });
		 }
        /* 点击移出收藏则把所在li去掉  */
        $(document).on("click","button:contains('移出收藏')",function(){
        	if(li_index!= null){
        		$("#"+li_index).remove();
        	}
 	     })
/*=================收藏服务======end====================*/        
        /*var targetUrl=$('.head-logo>img').attr('src');
        $('.preview-img>img').attr('src',targetUrl);
        $("#select-skin").change(function () {
            var $file = $(this);
            var fileObj = $file[0];
            var windowURL = window.URL || window.webkitURL;
            var dataURL;
            var $img = $(this).parent().next().children("img");
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
                    $("#show-own-img").attr("src",dataURL);
                    $('button.confirm').click(function () {
                        $('.head-logo>img').attr('src',dataURL);
                        $('#show-avatar').modal('hide');
                    });
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
        })*/
    });
</script>
 <!-- footer -->
<%@ include file="/webpage/define/portal/cms/front/include/footer.jsp"%>
<iframe name="iframename" width="0" src="/mht_act/a" style="display:none"
	sandbox="allow-forms allow-scripts allow-same-origin"></iframe>
<iframe name="iframename" width="0" src="/mht_service/a" style="display:none"
	sandbox="allow-forms allow-scripts allow-same-origin"></iframe>	
</body>
</html>