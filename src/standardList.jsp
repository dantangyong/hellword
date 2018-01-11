<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
				<c:forEach items="${listStandard}" var="standard">
					<tr>
						<td><span id="standardName">${standard.standardName}</span></td>
						<c:if test="${standard.type =='1'}">
							<td>起始时间：<span id="start_time">${standard.startTime}</span>-截止时间：<span id="end_time">${standard.endTime}</span></td>
						</c:if>
				
						<c:if test="${standard.type =='2'}">
							<td>${standard.outStandard}小时</td>
						</c:if>
						<td>${standard.status =="1"? "已启用":"已禁用"}</td>
						<td>
							<button class="edit" type="button" value="${standard.id}" id="changeToInput">编辑</button>
							<button class="use" value="${standard.id}">${standard.status =="1"? "禁用":"启用"}</button>
							<button class="delete" value="${standard.id}">删除</button>
						</td>
					</tr>
				</c:forEach>
<!-- 消息作提示框 -->
<div class="modal fade" id="standard-message">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-center text-danger">消息提示</h4>
            </div>
            <div class="modal-body">
                <p class="text-center text-warning"> <span class="standard-message"></span></p>
            </div>
            <div class="modal-footer text-right">
                <button type="button" class="btn btn-md normal" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>				
<script>

/*启用功能*/
$("tbody button:contains('启用')").click(function () {
	  $(".standard-text .key").html("启用");
    id = this.value;
    status = "启用" ;
  $(".standard-text").modal("show");
});
/*禁用功能 */
$("tbody button:contains('禁用')").click(function () {
	   $(".standard-text .key").html("禁用");
	    id = this.value;
	    status = "禁用";
	    $(".standard-text").modal("show");
	  });
/*删除功能*/
$("tbody button:contains('删除')").click(function () {
  $(".standard-text .key").html("删除");
   id = this.value;
   status = "删除";
  $(".standard-text").modal("show");
});

/* 异常启动，禁用  */
 var status;
 var id;
 $("#standard").one("click",function(){
	   /* 启用  */
	   if ("启用" == status) {
		   $(".standard-text").modal("hide");
		   status = "";
		   $.ajax({
				type:"POST",
				url:"${ctx}/swjtu/standard/enable",
			    data:{"id":id },
				success:function(date){
					if(date.success){
						 $(".add-edit").modal("hide");
						 
					};
					 $(".office-message").html(date.msg);
			    }
			});
		   refresh();
		   $("#office-message").modal("show");
	   };
	   /* 禁用   */
     if ("禁用" == status) {
  	   $(".standard-text").modal("hide");
		   status = "";
  	   $.ajax({
				type:"POST",
				url:"${ctx}/swjtu/standard/disable",
			    data:{"id":id },
				success:function(date){
					if(date.success){
						 $(".add-edit").modal("hide");
					};
					 $(".office-message").html(date.msg);
			    }
			});
  	   refresh();
  	   $("#office-message").modal("show");
  	
     } ;
     /* 删除  */
     if ("删除" == status) {
   	 
  		$(".standard-text").modal("hide");
			 status = "";
	    	   $.ajax({
					type:"POST",
					url:"${ctx}/swjtu/standard/delete",
					data: {"id":id },
					success:function(date){
						if(date.success){
							 $(".add-edit").modal("hide");
						};
						 $(".office-message").html(date.msg);
				    }
				});  
	    	   refresh();
	    	   $("#office-message").modal("show");
     };
 });
 $("#changeToInput").click(function(){
	 
	 alert(standardId);
	 
 });
//  $("#changeToInput").click(function(){
// 	  $("#standardName").html("<input type='text' value='' style='width:40px;border:1px solid gray;border-radius:8px;'>");
// 	  $("#start_time").html("<input type='text' value='' style='width:40px;border:1px solid gray;border-radius:8px;'>");
// 	  $("#end_time").html("<input type='text' value='' style='width:40px;border:1px solid gray;border-radius:8px;'>");
 
//  })
</script>