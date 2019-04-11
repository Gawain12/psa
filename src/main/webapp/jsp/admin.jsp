<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>研究生学习评测系统-后台管理</title>
    <link rel="shortcut icon" href="${basePath }img/favicon.ico"/>
    <link rel="bookmark" href="${basePath }img/favicon.ico"/>
    <link href="${basePath }weblib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${basePath }css/base.css">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        .userinfo {
            line-height: 48px;
        }
        .userinfo img {
            margin-right: 10px;
        }
        .background {
            background: url("${basePath }/img/interstellar.jpg") fixed center;
            background-size: cover;
        }
        h1 {font-color:white;}
        .blur {
            background: rgba(233, 233, 233, .9);
            border-radius: 15px;
        }
        #bs-collapse {
            line-height: 48px;
        }
        table, th,td
        {
            border-collapse:collapse;
            border:2px solid gray;
        }
        tr > td > p {
            margin-top: 8px;
            margin-bottom: 8px;
        }
        .button1 {
            display:inline-block;
            border-radius:4px;
            background-color:#f4511e;
            trasnsition:all 0.5s;
            cursor:pointer;
            color:#FFFFFF;
            font-size:30px;
            padding:20px;
            width:180px;
            height:60px;
            margin:2px;
        }
        .button1 span{
            cursor:pointer;
            display:inline-block;
            position: relative;
            trasnsition: 0.5s;
        }
        .button1 span:after{
            content:'>>';
            posintion:absolute;
            opacity:0;
            right:-10px;
            top:0;
            transition:0.5s;
        }
        .button1:hover span {
            padding-right: 20px;
        }
        .button1:hover span:after {
            opacity: 1;
            right: 0;
        }

    </style>
</head>
<body class="background">
<!--头部-->
<header>
    <nav class="navbar navbar-default">
        <div class="container">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                            data-target="#bs-collapse" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <div class="userinfo">
                        <img src="${basePath }img/headdefault.jpg" alt="headImg" class="img-circle" style="width: 30px">
                        <span>登录用户：${user.name }</span>
                    </div>
                </div>
                <div class="collapse navbar-collapse navbar-right" id="bs-collapse">
                    <span><a href="${basePath }logout" class="btn btn-danger">退出</a></span>
                    <span><a href="${basePath }cpasswd" class="btn btn-primary">修改密码</a></span>
                    <span><a href="${basePath }mStudent" class="btn btn-danger">查看学生信息</a></span>
                </div>
            </div>
        </div>
    </nav>
</header>
<!--/头部-->
<section>
    <div class="container">
        <h1>任务管理</h1>
        <button type="button" class="button1"  onclick="entry()" ><span>进入</span></button>
    </div>
    <div class="modal fade bs-modal-lg" id="addmodel" tabindex="-1" role="dialog"
         aria-labelledby="myLargeModalLabel">
        <div class="modal-dialog modal-lg">
            <div class="modal-content"></div>
        </div>
</section>

<!--内容-->
<section>
    <div class="container blur">
        <div>
            <h1>下载已上传的任务</h1>
            <label for="subject_ID">
                <select name="subject" id="subject_ID" class="form-control">
                    <option value="none">请选择任务...</option>
                    <c:forEach items="${orderInfoList }" var="orderInfo">
                        <option value="${orderInfo }">${orderInfo }</option>
                    </c:forEach>
                </select>
            </label>
            <label for="oid_id">
                <select name="oid" id="oid_id" class="form-control">
                    <option value="none">请选择次序...</option>
                </select>
            </label>
        </div>
        <div id="fileList">

        </div>
    </div>
    <p></p>
    </div>
</section>
<!--/内容-->
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="${basePath }weblib/jquery/jquery-3.2.1.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${basePath }weblib/bootstrap/js/bootstrap.min.js"></script>
<script src="${basePath }js/base.js"></script>
<script>
    $(function () {
        $("#loadsubject").load("${basePath}subjectui");
        var file_subject = "";
        var file_oid = "";
        $("#subject_ID").change(function () {
            file_subject = $(this).val();
            $.get("${basePath }getOnameBysubjectOfAll?subject=" + file_subject, function (data) {
                $("#oid_id").empty();
                $("#upfilebutton_id").removeAttr("disabled");
                $.each(data, function (key, value) {
                    if (key === 0) {
                        file_oid = value.oid;
                        flushFileList();
                    }
                    $("#oid_id").append("<option value=" + value.oid + ">" + value.oname + "</option>");
                });
            });
        });
        $("#oid_id").change(function () {
            file_oid = $(this).val();
            console.log("file_oid" + file_oid);
            flushFileList();
        });

        function flushFileList() {
            $("#fileList").load("${basePath }getFileList?hoid=" + file_oid);
        }
    });
    function entry() {
        window.open("${basePath }subjectui", "_blank");
    }
</script>
</body>
</html>