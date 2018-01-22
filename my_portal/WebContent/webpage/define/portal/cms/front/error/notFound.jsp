<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="front/include/taglib.jsp"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>页面丢失</title>
    <style>
        body{
            background-color:#F1F4F8;
        }
        img{
            max-width: 100%;
            position: absolute;
            top:50%;
            left:50%;
            transform: translate(-50%,-50%);
            height:auto;
        }
    </style>
</head>
<body>
    <img src="${ctxStatic}/portal/images/notFound.png">
</body>
</html>