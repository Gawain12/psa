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
        table, td,th
        {
            border-collapse:collapse;
            border:2px solid gray;
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
                    <span><a href="${basePath }cpasswd" class="btn btn-primary">修改密码</a></span>
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
        <h1>任务管理</h1>
        <span><a href="${basePath }admin" class="btn btn-danger">返回文件页面</a></span>
        <button type="button" id="upfilebutton_id" class="btn btn-primary"
                data-toggle="modal" data-remote="${basePath }jsp/addsubjectui.jsp" data-target=".bs-modal-lg">添加任务或内容
        </button>
        <div class="modal fade bs-modal-lg" id="addmodel" tabindex="-1" role="dialog"
             aria-labelledby="myLargeModalLabel">
            <div class="modal-dialog modal-lg">
                <div class="modal-content"></div>
            </div>
        </div>
    </div>
 </section>
<div class="table-responsive">
    <table class="table table-hover">
        <tr>
            <td>任务名称</td>
            <td>具体内容</td>
            <td>发布教师</td>
            <td>上次操作时间</td>
            <td>操作</td>
        </tr>
        <tbody>
        <c:forEach items="${allOrderInfo }" var="allorderinfo">
            <tr <c:if test="${!allorderinfo.ostate}">class='danger'</c:if> id="${allorderinfo.oid }">
                <td><p>${allorderinfo.osubject }</p></td>
                <td><p>${allorderinfo.oname }</p></td>
                <td><p>${allorderinfo.ouid }</p></td>
                <td><p><fmt:formatDate value="${allorderinfo.otime }" pattern="yyyy年MM月dd日 HH:mm:ss"/></p></td>
                <td>
                    <button type="button" class="btn btn-info btn-warning" onclick="edit(${allorderinfo.oid })">编辑
                    </button>
                    <button type="button" class="btn btn-info btn-danger" onclick="del(${allorderinfo.oid })">删除
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="panel-footer">
        <c:if test="${pagingVO != null}">
            <nav style="text-align: center">
                <ul class="pagination">
                    <li><a href="${basePath }subjectui?page=${pagingVO.upPageNo}">&laquo;上一页</a></li>
                    <li class="active"><a href="">${pagingVO.curentPageNo}</a></li>
                    <c:if test="${pagingVO.curentPageNo+1 <= pagingVO.totalCount}">
                        <li><a href="${basePath }subjectui?page=${pagingVO.curentPageNo+1}">${pagingVO.curentPageNo+1}</a></li>
                    </c:if>
                    <c:if test="${pagingVO.curentPageNo+2 <= pagingVO.totalCount}">
                        <li><a href="${basePath }subjectui?page=${pagingVO.curentPageNo+2}">${pagingVO.curentPageNo+2}</a></li>
                    </c:if>
                    <c:if test="${pagingVO.curentPageNo+3 <= pagingVO.totalCount}">
                        <li><a href="${basePath }subjectui?page=${pagingVO.curentPageNo+3}">${pagingVO.curentPageNo+3}</a></li>
                    </c:if>
                    <c:if test="${pagingVO.curentPageNo+4 <= pagingVO.totalCount}">
                        <li><a href="${basePath }subjectui?page=${pagingVO.curentPageNo+4}">${pagingVO.curentPageNo+4}</a></li>
                    </c:if>
                    <li><a href="${basePath }subjectui?page=${pagingVO.totalCount}">最后一页&raquo;</a></li>
                </ul>
            </nav>
        </c:if>
    </div>
</div>
            </div>
        </div>
</div>
<script src="${basePath }weblib/jquery/jquery-3.2.1.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${basePath }weblib/bootstrap/js/bootstrap.min.js"></script>
<script src="${basePath }js/base.js"></script>
<script>


    function del(oid) {
        $.get("${basePath }delOrderinfoByOID?oid=" + oid, function (data) {
            if (data) {
                window.location.reload();
            }
        });
    }

    function edit(oid) {
        console.log("edit" + oid);
    }
</script>
</div>
</body>
</html>