<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head lang="zh-cn">
    <meta charset="UTF-8">
    <!--2 viewport-->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <!--3、x-ua-compatible-->
    <meta http-equiv="x-ua-compatible" content="IE=edge">
    <title>后勤频道</title>
    <!--4、引入两个兼容文件-->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <!--6、引入 bootstrap.css-->
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/bootstrap.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/notice/css/common-channel.css">
</head>
<body>
<!--导航栏-->
<%@ include file="/webpage/define/portal/cms/front/include/navigation.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-xs-12">
                <jsp:include page="newsChannel.jsp"></jsp:include> 
        </div>
        <div class="col-xs-12 news-distance">
            <div class="row">
                <div class="col-xs-12 col-md-7">
                    <h4>后勤频道/LOGISTICS</h4>
                    <c:forEach items="${requestScope.channellist}" var="document">
						<c:choose>
						<c:when test="${document['article'].image ne null && document['article'].image ne ''&& document['article'].image ne 'null'}">
							<div class="img-text-new">
								<div class="img-content">
										<img alt="图片走丢了" src="${document['article'].image }" />
								</div>
								<div class="news-content">
									<h5>
										<a href="${ctx}/cms/solr/newsDetailJsp?name=${document.id}">${document["article"].title}</a>
										<span class="pull-right"><fmt:formatDate
												value="${document['category'].updateDate}"
												pattern="yyyy-MM-dd HH:mm" /></span>
									</h5>
									<p>${document["article"].description}</p>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="text-new">
								<div class="news-content text-left">
									<h5>

										<a href="${ctx}/cms/solr/newsDetailJsp?name=${document.id}">${document["article"].title}</a>
										<span class="pull-right"><fmt:formatDate value="${document['category'].updateDate}" pattern="yyyy-MM-dd HH:mm"/></span>
									</h5>
									<p>
									${document["article"].description}
									</p>
								</div>
							</div>
						</c:otherwise>
						</c:choose>
						</c:forEach>
                </div>
                <div class="col-xs-12 col-md-4 col-md-offset-1">
                    <h4>近期热点/HOT NEWS</h4>
                    <ul class="recent-news">
                        <c:forEach items="${requestScope.hotlist}" var="document">
                       	 	<li><a href="${ctx}/cms/solr/newsDetailJsp?name=${document.id}">${document["article"].title}</a></li>
                       	</c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!--5、引入 jquery，bootstrap js-->
<script src="js/jquery-1.11.3.js"></script>
<script src="js/bootstrap.js"></script>
<div class='2323' style="text-align: center;">
		<a href='javascript:goPage(1)' id="first"><button type="button"
				class="btn btn-sm btn-default active">首页</button></a> <a
			href='javascript:goPage(${pageBean.pageCode-1})' id="first"><button
				type="button" class="btn btn-sm btn-default active">上一页</button></a>
		<c:forEach begin="${pageBean.begin }"
			end="${pageBean.end }" var="p">
			<a href="javascript:goPage('${p}')"><button type="button"
					class="btn btn-sm btn-default active">${p}</button></a>
		</c:forEach>
		<!-- <input type="hidden" name="pageCode" id="page" value="1" /> -->
		<input type="hidden" value="" name="key"> <a href='javascript:goPage(${pageBean.pageCode+1})' id="first"><button
				type="button" class="btn btn-sm btn-default active" />下一页
			</button></a> <a href='javascript:goPage(${pageBean.totalPage})' id="last"><button
				type="button" class="btn btn-sm btn-default active">尾页</button></a> <span>当前第${pageBean.pageCode}页/共${pageBean.totalPage}页</span>
	</div>
	<script type="text/javascript"
		src="http://apps.bdimg.com/libs/jquery/2.1.1/jquery.js"></script>
	<script type="text/javascript">
		function goPage(p) {
			if (p<1 || p>${pageBean.totalPage}) {
				return;
			}
			$("#page").val(p);
			location.href = "${ctx}/cms/solr/newsChannel?name=后勤频道&pageCode="+p;
		};
	</script>
</body>
</html>