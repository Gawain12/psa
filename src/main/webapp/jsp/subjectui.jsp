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
    <title>任务管理-研究生学习评测系统</title>
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
            width: 250px;
        }
        tr > td > p {
            margin-top: 8px;
            margin-bottom: 8px;
        }
        .col-md-10
        {
            width:100%;
        }
        input{
            border: 1px solid #ccc;
            border-radius: 3px;
            height: 30px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
        }
        input:focus{
            border-color: #66afe9;
            outline: 0;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
        }
        .button {
            justify-content: center;
            align-items: center;
            display: inline-block;
            padding: 0px 12px;
            font-size: 14px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #fff;
            height:33px ;
            border-radius: 15px;
            box-shadow: 0 4px #999;
            border: none;
        }
        .button1 {
            height:55px ;
            border-radius: 50%;
            background-color: #808040;
            font-size: 19px;
            padding: 12px 18px;
        }
        .button2 {
            background-color: #4F9D9D;
        }
        .button3 {
            background-color: #7373B9;
        }
        .button4 {
            background-color: #804040;
        }
        .button:hover {background-color: #A6A600}

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
                    <button name="quit"onclick="window.location.href='${basePath }logout'" class="button button2" style="height:48px;font-size: 17px" ;>退出</button>
                    <button name="back"onclick="window.location.href='${basePath }admin'" class="button button4"style="height:48px;font-size: 17px" >返回主页</button>
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
        <button type="button" id="upfilebutton_id" class="button button1"
                data-toggle="modal" data-remote="${basePath }jsp/addsubjectui.jsp" data-target=".bs-modal-lg">添加任务或内容
        </button>
        <button type="button" id="btn" onclick="display()"class="button button3">编辑内容</button>
        <div class="modal fade bs-modal-lg" id="addmodel" tabindex="-1" role="dialog"
             aria-labelledby="myLargeModalLabel">
            <div class="modal-dialog modal-lg">
                <div class="modal-content"></div>
            </div>
        </div>
    </div><br/>
 </section>
<div class="table-responsive">
    <table class="table table-hover" id="edit"  style="display:none">
        <tr>
            <td>任务名称</td>
            <td>具体内容</td>
            <td>上次操作教师</td>
            <td>上次操作时间</td>
            <td>操作</td>
        </tr>
        <tbody >

        <c:forEach items="${allOrderInfo }" var="allorderinfo">
            <tr>
                <td><p>${allorderinfo.osubject }</p></td>
                <td class="oname"><p>${allorderinfo.oname }</p>
                        <form action="${basePath }updateName" method="post" class="changename"  type="hidden">
                        <input type="hidden" name="oid" value="${allorderinfo.oid }"/>
                        <input type="text" name="oname" class="input" />
                        <input type="submit" value="保存" class="button button2" id="saveName">
                       <%-- <a href="#" class="resetName" id="resetName" id="cancel" onclick="display()">X</a>--%>
                        </form>
                </td>
                <td><p>${allorderinfo.ouid }</p></td>
                <td><p><fmt:formatDate value="${allorderinfo.otime }" pattern="yyyy年MM月dd日 HH:mm:ss"/></p></td>
                <td class="oname">
                    <button type="button" class="button button4" onclick="del(${allorderinfo.oid })">删除
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
        <table class="table table-hover" id="order">
            <tr>
                <td>任务名称</td>
                <td>具体内容</td>
                <td>上次操作教师</td>
                <td>上次操作时间</td>
                <td>操作</td>
            </tr>
        <tbody   >
        <c:forEach items="${allOrderInfo }" var="allorderinfo" >
            <tr>
            <td><p>${allorderinfo.osubject }</p></td>
            <td class="oname"><p>${allorderinfo.oname }</p></td>
            <td><p>${allorderinfo.ouid }</p></td>
            <td><p><fmt:formatDate value="${allorderinfo.otime }" pattern="yyyy年MM月dd日 HH:mm:ss"/></p></td>
            <td class="oname">
                <button type="button" class="button button4" onclick="del(${allorderinfo.oid })">删除
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
   /* function lclose()
    {
        var ad=document.getElementById("edit")
        ad.style.display=(ad.style.display == 'none')?'block':'none';
    }*/
    var order=document.getElementById("order");
    var edit=document.getElementById("edit");
    var btn=document.getElementById("btn");
    var cancel=document.getElementById("cancel");
    var flag=false;
   function display(){
        if(flag){
            order.style.display="block";
            edit.style.display="none";
            $("#btn").html('编辑内容');
            flag=false;
        }
        else{
            edit.style.display="block";
            order.style.display="none";
            $("#btn").html('取消编辑');
            flag=true;
        }
    }
</script>
</div>
</body>
</html>