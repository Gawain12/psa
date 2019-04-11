<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<% String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    application.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>正在加载主页...</title>
    <link rel="shortcut icon" href="${basePath }img/favicon.ico"/>
    <link rel="bookmark" href="${basePath }img/favicon.ico"/>
    <style>
        body {
            overflow: hidden;
        }

        div {
            margin: 20px 50%;
            width: 200px;
            position: absolute;
            right: -120px;
            top: 50px;
        }
    </style>
</head>
<body>
<div><p>正在加载主页，请稍等...</p></div>
<script>
    window.location.href = "${basePath }fileupload";
</script>
</body>
</html>