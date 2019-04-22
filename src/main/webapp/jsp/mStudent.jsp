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
        table,td,th
        {
            border-collapse:collapse;
            border:2px solid gray;
        }
        #bs-collapse {
            line-height: 48px;
        }
        tr > td > p {
            margin-top: 8px;
            margin-bottom: 8px;
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
                    <span><a href="${basePath }fileupload" class="btn btn-danger">返回</a></span>
                </div>
            </div>
        </div>
    </nav>
</header>
<div class="col-md-10">
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="row">
                <section>
                    <div class="container">
                <h1 class="col-md-5">学生名单管理</h1>
                    <button type="button" id="upfilebutton_id" class="btn btn-primary"
                            data-toggle="modal" data-remote="${basePath }jsp/addStudent.jsp" data-target=".bs-modal-lg">添加用户信息
                    </button>
                </button>
                <div class="modal fade bs-modal-lg" id="addmodel" tabindex="-1" role="dialog"
                     aria-labelledby="myLargeModalLabel">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content"></div>
                    </div>
                </div>
                    </div>
                </section>
            <div class="alert alert-danger alert-dismissible fade in hidden" role="alert" id="delalert_id">
                <h4 class="glyphicon glyphicon-warning-sign"> 确定删除吗？</h4>
                <p>注意：该操作不可逆！</p>
                <p>
                    <button type="button" class="btn btn-danger" id="delalert_true">确定删除</button>
                    <button type="button" class="btn btn-default" id="delalert_cancel">取消</button>
                </p>
            </div>

            <table class="table table-bordered">
            <thead>
            <tr>
                <th>学号</th>
                <th>姓名</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach  items="${studentList}" var="item">
                <tr>
                    <td>${item.username}</td>
                    <td>${item.name}</td>
                    <td>
                        <button class="btn btn-default  btn-info" onClick="location.href='${basePath }editStudent?uid=${item.uid}'">修改</button>
                        <button type="button" class="btn btn-info btn-danger" onclick="del(${item.uid })">删除</button>
                        <button class="btn btn-info btn-warning"onClick="location.href='${basePath }studentAnalyse?uid=${item.uid}'">查看学习情况</button>
                        <!--弹出框-->
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="panel-footer">
            <c:if test="${pagingVO != null}">
                <nav style="text-align: center">
                    <ul class="pagination">
                        <li><a href="${basePath }mStudent?page=${pagingVO.upPageNo}">&laquo;上一页</a></li>
                        <li class="active"><a href="">${pagingVO.curentPageNo}</a></li>
                        <c:if test="${pagingVO.curentPageNo+1 <= pagingVO.totalCount}">
                            <li><a href="${basePath }mStudent?page=${pagingVO.curentPageNo+1}">${pagingVO.curentPageNo+1}</a></li>
                        </c:if>
                        <c:if test="${pagingVO.curentPageNo+2 <= pagingVO.totalCount}">
                            <li><a href="${basePath }mStudent?page=${pagingVO.curentPageNo+2}">${pagingVO.curentPageNo+2}</a></li>
                        </c:if>
                        <c:if test="${pagingVO.curentPageNo+3 <= pagingVO.totalCount}">
                            <li><a href="${basePath }mStudent?page=${pagingVO.curentPageNo+3}">${pagingVO.curentPageNo+3}</a></li>
                        </c:if>
                        <c:if test="${pagingVO.curentPageNo+4 <= pagingVO.totalCount}">
                            <li><a href="${basePath }mStudent?page=${pagingVO.curentPageNo+4}">${pagingVO.curentPageNo+4}</a></li>
                        </c:if>
                        <li><a href="${basePath }mStudent?page=${pagingVO.totalCount}">最后一页&raquo;</a></li>
                    </ul>
                </nav>
            </c:if>
        </div>
            </div>
        </div>
    </div>
</div>
</nav>
</header>
<!--/头部-->
<!--内容-->
<!--/内容-->
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="${basePath }weblib/jquery/jquery-3.2.1.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${basePath }weblib/bootstrap/js/bootstrap.min.js"></script>
<script src="${basePath }js/base.js"></script>
<script>
    function del(uid) {
        alert("删除成功！");
        $.get("${basePath }delStudentByUID?uid=" + uid, function (data) {
            if (data) {
                window.location.reload();
            }
        });
    }
    function edit(uid) {
        console.log("edit" + uid);
    }
</script>
</div>
</body>
</html>