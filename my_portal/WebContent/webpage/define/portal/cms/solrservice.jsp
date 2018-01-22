﻿<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<style>
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

.pa{
	position:absolute;
	right:8%;
	top:0;
}
</style>
<div class="news-distance">
	<div class="row">
		<div class="col-xs-12 col-md-7 left-list border-radius pictips_content">
		   <c:if test="${empty documentList}"> 
		       <img src="${ctxStatic }/portal/images/infoNotFound.png" class="imgtips_content"   alt="图片走丢了" >
		        <script>
		            $("#pic_helper").val("true");
		        </script>
		   </c:if>
		   <c:if test="${not empty documentList}">  
			<c:forEach items="${documentList}" var="document" varStatus="status">
				<div class="result-item">
					<div class="left">
						<img src="${document['service_img'][0]}">
						<div class="wrap-star">
							<div class="starts" data-score="2"></div>
							<span class="title"></span>
						</div>
					</div>
					<div class="right pr">
						<h5 class="show-one">
							<span class="bigger"><a href="#" class="serviceItem" data-id="${document['id'][0]}" >${document["service_name"][0]}</a></span>
<%-- 						| <span><a href="#">服务分类:${document["classify_name"][0]}</a></span>  | --%>
                             <span class="readonly-rate pa" data-score="${document['star'][0]}" ></span> 
						</h5>
						 <p class="show-two">服务简介:${document["service_details"][0]}</p>
					</div>
				</div>
			</c:forEach>
		</c:if>
		</div>
		<div
			class="col-xs-12 col-md-4 col-md-offset-1 border-radius include-search">
			<h4>热门搜索</h4>
			<div class="hot-content">
				<ul class="recent-news" id="hot-contentss">
				</ul>
			</div>
		</div>
	</div>
</div>
<div class="container" id="detail"></div> 
<!--进入服务内容  -->
<div id="entrance-service" class="wow lightSpeedIn"
	data-wow-duration=".8s" data-wow-delay=".5s">
	<img class="loading" src="/mht_service/static/images/loading.gif">
	<span class="delIcon"> <img
		src="/mht_service/static/images/close.png">
	</span>
    <iframe id="myIframe" width="100%" height="100%;" src=""></iframe>
</div>
<iframe name="iframename" width="0" src="/mht_service/a"
	sandbox="allow-forms allow-scripts allow-same-origin"></iframe>
 <div class="col-xs-12 col-md-7 text-center">
<c:if test="${total gt 5}">
	<c:forEach items="${divedPage}" var="showPage">
		<c:forEach items="${showPage}" var="map">
			<c:choose>
				<c:when test="${map.key == '上一页' }">
					<button type="button" class="btn btn-sm btn-default prev" 
						onclick="button(${showPage.value})">上一页</button>
				</c:when>
				<c:when test="${map.key == '其他页' }">
					<button type="button" class="btn btn-sm btn-default" 
						onclick="button(${map.value})">${map.value}</button>
				</c:when>
				<c:when test="${map.key == '当前页' }">
					<button type="button" class="btn btn-sm btn-default currentv" 
						onclick="button(${map.value})">${map.value}</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-sm btn-default next" 
						onclick="button(${map.value})">下一页</button>
				</c:otherwise>

			</c:choose>
		</c:forEach>
	</c:forEach>

</c:if>
</div>
<script src="${ctxStatic }/portal/solrShow/js/operation.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".search-nav li:eq(1)").addClass("active");
	filter();
	changeBackground();
	starShow();
});
 function filter(){
	 $(".show-two").each(function(){
		 var s = $(this).html();
		 var arrEntities = {
			        'lt': '<',
			        'gt': '>',
			        'nbsp': ' ',
			        'amp': '&',
			        'quot': '"'
			    };
		 var ddds = s.replace(/&(lt|gt|nbsp|amp|quot);/ig,
			    function(all, t) {
			        return arrEntities[t];
			    });
		 var dd=ddds.replace(/<\/?.+?>/g,"");
		 var s = dd.replace(/;/gi,'<');
		   s = s.replace(/<\s*script[^>]*>(.|[\r\n])*?<\s*\/script[^>]*>/gi, '');
          s = s.replace(/<\s*style[^>]*>(.|[\r\n])*?<\s*\/style[^>]*>/gi, '');
          s = s.replace(/<\/?[^>]+>/g, '');
          s = s.replace(/<[^<>]+?>/g,'');
          s = s.replace(/\&[a-z]+;/gi, '');
          s = s.replace(/</gi, '');
          s = s.replace(/\/*/gi, '');
          s = s.replace(/>/gi, '');
		        console.log(s);
		        $(this).html(s);
	});
 }

   $(function(){
		$.ajax({
			url:"${ctx}/cms/solr/hotName",
			type:"GET",
			data : {
				service:"2"
			},
			success:function(data){
				$("#hot-contentss").empty();
				var compos = data.body.composes;
				for(var i=0; i < compos.length; i++){
					var url = compos[i].name == null ? "" : compos[i].name;
					$("#hot-contentss").append("<li><a id=li"+compos[i].id+" class='show-one' >"+'<span class="number">'+(i+1)+'</span>'+compos[i].name+"</a></li>");
					$("#li"+compos[i].id).attr("href","#");
					$("#li"+compos[i].id).attr("onclick","myAjax('"+compos[i].name+"','"+compos[i].service+"')");
				}
			}
		})
		$(".serviceItem").on("click",function(){
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
	})

	function button(page){
	$.ajax({
		url : "${ctx}/cms/solr/change",
		type : "post",
		data : {
			type : record,
			solr : $("#solr").val(),
			mypage:page
		},
		success : function(data) {
			if(record == 0 || record == 1){
				$('#news').html(data);}
				if(record == 2)
					{$("#service-application").html(data);
					
					return;
					}
				if(record == 3)
					{$("#show-message").html(data);return;}
				if(record == 4){
					$("#pingan-video").html(data);return;
				}
		}
	});
	
	}
	function myAjax(name,service){
		$("#solr").val(name);
	    serviceapp(2)
	}
	</script>

