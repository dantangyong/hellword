<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>进入插件</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(function(){
			location.href=$("#url").text();
		});
		
	</script>
</head>
<body>
	<p id="url" style="display: none">${pluginUrl }</p>
</body>
</html>