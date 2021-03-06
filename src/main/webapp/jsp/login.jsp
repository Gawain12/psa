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
    <title>研究生学习评估系统-登录</title>
    <link rel="shortcut icon" href="${basePath }/img/favicon.ico"/>
    <link rel="bookmark" href="${basePath }/img/favicon.ico"/>
    <link href="${basePath }/weblib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${basePath }/css/base.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <![endif]-->
    <style>
        h1.head{
            color:white;
            text-shadow:0 0 8px;
            margin-top:60px;
            text-align: center;
        }
        .form-control {
            margin-bottom: 20px;
        }
        .col-md-6 {
            margin-top: 1em;
        }
        .background {
            background: url("${basePath }/img/backgroundimg.jpeg") fixed center;
            background-size: cover;
        }
        .blur {
            background: rgba(233, 233, 233, .6);
            border-radius: 10px;
        }
        .button {
             justify-content: center;
             display: inline-block;
             cursor: pointer;
             text-align: center;
             text-decoration: none;
             outline: none;
             color: #fff;
             width: 250px;
             box-shadow: 0 4px #999;
             border: none; height:65px ;
             border-radius: 50%;
             background-color: #808040;
             font-size: 30px;
             padding: 12px 25px;
            margin: 0;
         }
    </style>
</head>
<body class="background">
<section>
    <div class="container blur">
        <h1 class="head" >CUIT研究生学习考核系统</h1>
        <form class="form-signin" method="post" action="${basePath }login">
            <h2 class="form-signin-heading">请登录：<p style="color: red" id="errorinfo_id">${returninfo }</p></h2>
            <div class="form-group" id="Id_div">
                <input type="text" name="username" class="form-control" id="inputID" placeholder="学号" required
                       autofocus>
                <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
            </div>
            <div class="form-group" id="Password_div">
                <input type="password" name="password" class="form-control" id="inputPassword"
                       placeholder="密码 (首次登陆，密码与学号相同)" required>
                <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="rememberMe"> 记住我
                </label>
            </div>
            <div class="row" style="text-align:center">
                    <button class="button" type="button" id="submit_id">登  录</button>
            </div>
        </form>
        <p style="height: 8px"></p>
    </div> <!-- /container -->
</section>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="${basePath }weblib/jquery/jquery-3.2.1.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${basePath }weblib/bootstrap/js/bootstrap.min.js"></script>
<script src="${basePath }js/base.js"></script>
<script>
    $(function () {
        var height = $(window).height(); //浏览器当前窗口可视区域高度
        var section_height = $("section").outerHeight(true);
        $("section").css("margin-top", (height / 2) - (section_height / 2));
        $(window).resize(function () {
            var height = $(window).height(); //浏览器当前窗口可视区域高度
            var section_height = $("section").outerHeight(true);
            $("section").css("margin-top", (height / 2) - (section_height / 2));
        });
        var idlength = 0;
        var passwdlength = 0;
        $("#inputID").blur(function () {
            var inputID = $(this).val();
            idlength = inputID.length;
            if (idlength !== 0) {
                if (!isNaN(inputID)) {
                    if (idlength !== 12) {
                        $("#errorinfo_id").text("学号长度为12位数字，请输入正确的学号！");
                        $("#Id_div").addClass("has-error has-feedback");
                    }
                    else {
                        $("#errorinfo_id").text("");
                        $("#Id_div").removeClass("has-error has-feedback");
                    }
                } else {
                    $("#errorinfo_id").text("请输入正确的学号！");
                    $("#Id_div").addClass("has-error has-feedback");
                }
            }
        });
        $("#inputPassword").blur(function () {
            var inputPassword = $(this).val();
            passwdlength = inputPassword.length;
            if (passwdlength !== 0) {
                if (passwdlength === 0 || passwdlength < 8) {
                    $("#errorinfo_id").text("密码不能为空/密码长度至少8位");
                    $("#Password_div").addClass("has-error has-feedback");
                } else {
                    $("#errorinfo_id").text("");
                    $("#Password_div").removeClass("has-error has-feedback");
                }
            }
        });
        $("#submit_id").click(function () {
            if (idlength === 12 && passwdlength !== 0 && passwdlength >= 8) {
                document.forms[0].submit();
            }
            else {
                $("#errorinfo_id").text("请输入学号和密码！");
                $("#Id_div").addClass("has-error has-feedback");
                $("#Password_div").addClass("has-error has-feedback");
            }
        });
    });
</script>
</body>
</html>