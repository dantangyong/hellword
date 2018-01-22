<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

		<div class="row">
  <div class="col-xs-12 news-distance">
                <div class="row">
                    <div class="col-xs-12 col-md-7 border-radius">
                        <h4 style="padding-left:15px">${channel.name}/${channel.target }</h4>
                       	<c:forEach items="${requestScope.channellist}" var="document">
						<c:choose>
						<c:when test="${document['article'].image ne null && document['article'].image ne ''&& document['article'].image ne 'null'}">
							<div class="img-text-new">
								<div class="img-content" style="width:120px;height:120px">
										<img alt="图片走丢了" src="${document['article'].image }" />
								</div>
								<div class="news-content">
									<h5>
									   <c:if test="${not empty document['article'].link }">
									       <a href="${document['article'].link }" target="_blank" class='show-one'>${document["article"].title}</a>
									   </c:if>
									   <c:if test="${empty document['article'].link }">
									       <a onclick="newsDetail('${document.id}')" class='show-one'>${document["article"].title}</a>
									   </c:if>
										
										<span class="pull-right"><fmt:formatDate
												value="${document['article'].updateDate}"
												pattern="yyyy-MM-dd HH:mm" /></span>
									</h5>
									<p class="show-three">${document["article"].description}</p>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="text-new">
								<div class="news-content text-left" style="margin-left:17px">
									<h5>
									      <c:if test="${not empty document['article'].link }">
									       <a href="${document['article'].link }" target="_blank" class='show-one'>${document["article"].title}</a>
									   </c:if>
									   <c:if test="${empty document['article'].link }">
									       <a onclick="newsDetail('${document.id}')" class="show-one">${document["article"].title}</a>
									   </c:if>
										<span class="pull-right"><fmt:formatDate value="${document['article'].updateDate}" pattern="yyyy-MM-dd HH:mm"/></span>
									</h5>
									<p class='show-three'>
									${document["article"].description}
									</p>
								</div>
							</div>
						</c:otherwise>
						</c:choose>
						</c:forEach>
                    </div>
                    <div class="col-xs-12 col-md-4 col-md-offset-1 border-radius">
                        <h4 class="specialH4" style="margin-left:15px;margin-bottom:20px">近期热点</h4>
                        <ul class="recent-news">
                        <c:forEach items="${requestScope.hotlist}" var="document">
                           <li>
                                <c:if test="${not empty document['article'].link }">
							       <a href="${document['article'].link}" target="_blank"><span class="rect"></span>${document["article"].title}</a>
							   </c:if>
							   <c:if test="${empty document['article'].link }">
							        <a onclick="newsDetail('${document.id}')"><span class="rect"></span> ${document["article"].title}  </a>
							   </c:if>
                              
                           </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
		</div>
<input type="hidden" id="foot_helper" value="${fn:length(channellist)}">
	<!--5、引入 jquery，bootstrap js-->
	<c:if test="${pageBean.totalPage gt 1}">
	<div class='2323' style="text-align: center;">
		<a href="javascript:goPage(1,'${channel.name}')" id="first"><button type="button"
				class="btn btn-sm btn-default active">首页</button></a> <a
			href="javascript:goPage('${pageBean.pageCode-1}','${channel.name}')" id="first"><button
				type="button" class="btn btn-sm btn-default active">上一页</button></a>
		<c:forEach begin="${pageBean.begin }"
			end="${pageBean.end }" var="p">
			<a href="javascript:goPage('${p}','${channel.name}')"><button type="button"
					class="btn btn-sm btn-default active">${p}</button></a>
		</c:forEach>
		<input type="hidden" value="" name="key"> 
		<a href="javascript:goPage('${pageBean.pageCode+1}','${channel.name}')" id="first">
		<button type="button" class="btn btn-sm btn-default active" > 下一页 </button></a> 
		<a href="javascript:goPage('${pageBean.totalPage}','${channel.name}')" id="last">
		<button type="button" class="btn btn-sm btn-default active">尾页</button></a>
		 <span>当前第${pageBean.pageCode}页/共${pageBean.totalPage}页</span>
	</div>
	</c:if>
	<script type="text/javascript">
		var a = true;
		function goPage(p,name) {
			
			//切换新闻栏目,去掉页脚固定到页面底部属性
	    	$("#footer").removeClass("footer");
			if (p<1 || p>${pageBean.totalPage}) {
				return;
			}
				$("#page").val(p);
				$.ajax({
		    		type:"POST",
		    		url:"${ctx}/cms/solr/otherChannel",
		    		data:{
		    			name:name,
		    			pageCode:p
		    			},
		    		success:function(date){
		    			$("#secondHotChannel").empty();
		    			$("#secondHotChannel").html(date);
		    			}
		    		});
		}
	function newsDetail(id){
		$.ajax({
    		type:"POST",
    		url:"${ctx}/cms/solr/newsDetailJsp",
    		data:{
    			name:id,
    			},
    		success:function(date){
    			$("#secondHotChannel").empty();
    			$("#secondHotChannel").html(date);
    			}
    		});
	}
	 $(document).ready(function(){
	        var flag = true;
	        var footV = $("#foot_helper").val();
	        /*鼠标滑轮滚动事件的处理*/ 
	        var scrollFunc=function(e){
	            var direct=0; 
	            e=e || window.event; 
	            if(e.wheelDelta){//IE/Opera/Chrome
	                if(flag){
	                    pageTurring(e.wheelDelta);
	                }else{
	                    flag = true;
	                }
	            }else if(e.detail){//Firefox 
	                pagepageTurringFirefox(e.detail);
	            } 
	            ScrollText(direct); 
	        }

	        /*注册事件*/ 
	        if(document.addEventListener){
	            document.addEventListener('DOMMouseScroll',scrollFunc,false);
	        }
	        window.onmousewheel=document.onmousewheel=scrollFunc;//IE/Opera/Chrome

	        //其他浏览器翻页，根据参数的进行翻页(负数为下一页，)
	        function pageTurring(e){
	            flag = false;
	        }
	        //火狐翻页，根据参数的进行翻页(正数为下一页，)
	        function pagepageTurringFirefox(e){
	        }
	      //新闻条数少于4，就把页脚固定到底部
	       if(footV==''|| footV==0 || footV<=4){
	    	   $("#footer").addClass("footer");
	       } 
	    })
	 
	 
	</script>
