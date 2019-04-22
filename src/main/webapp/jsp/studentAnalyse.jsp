<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ page isELIgnored="false" %>
<% String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    application.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<head>
    <style>
        .userinfo {
            line-height: 48px;
        }

        .userinfo img {
            margin-right: 10px;
        }

        #bs-collapse {
            line-height: 48px;
        }

        tr > td > p {
            margin-top: 8px;
            margin-bottom: 8px;
        }
    </style>
    <meta charset="utf-8">
    <link href="${basePath }weblib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${basePath }css/base.css">
    <title>ECharts</title>
</head>
<body>
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
                        <img src="${basePath }/img/headdefault.jpg" alt="headImg" class="img-circle" style="width: 30px">
                        <span>登录用户：${user.name }</span>
                    </div>
                </div>
                <div class="collapse navbar-collapse navbar-right" id="bs-collapse">
                    <span><a href="${basePath }logout" class="btn btn-danger">退出</a></span>
                    <span><a href="${basePath }cpasswd" class="btn btn-primary">修改密码</a></span>
                    <span><a href="${basePath }mStudent" class="btn btn-danger">返回</a></span>
                </div>
            </div>
        </div>
    </nav>
</header>

<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<!-- ECharts单文件引入 -->

<!--历史-->
<section>
    <div class="container">
        <hr>
        <div class="history">
            <p>上得分记录</p>
<div class="table-responsive">
    <table class="table table-hover">
        <tr>
            <td>任务</td>
            <td>内容</td>
            <td>上传时间</td>
            <td>分数</td>
        </tr>
        <c:forEach items="${userHistoryList }" var="userHistory">
            <tr id="${userHistory.hid }">
                <td><p>${userHistory.osubject}</p></td>
                <td><p>${userHistory.oname}</p></td>
                <td><p><fmt:formatDate value="${userHistory.uptime }" pattern="yyyy年MM月dd日 HH:mm:ss"/></p>
                </td>
                <td><p><c:if test="${empty userHistory.score}">未打分</c:if>${userHistory.score}</p></td>
                </td>
                </button><p style="display:none;" id="jsonStr">${userHistory.huid}</p>   </td>
            </tr>
        </c:forEach>
    </table>
</div>
        </div>
    </div>
</section>
<script src="http://echarts.baidu.com/build/dist/echarts-all.js"></script>
<script src="${basePath }js/echarts.js"></script>

<script type="text/javascript" src="${basePath }js/jquery-1.11.1.min.js"></script>
<div id="main" style="width: 900px;height:500px;"></div>

<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    var option = {
        tooltip: {
            show: true
        },
        legend: {
            data: ['学习情况']
        },
        title: {
            text: '学习情况'
        },
        xAxis: [
            {
                type: 'category',
                data: (function show(huid){
                    var jsonStr = $("#jsonStr").html();
     //               var obj = eval("(" + jsonStr + ")");
     //               var huid = $("#huid").val();
                    var arr=[];
                    $.ajax({
                        type : "post",
                        async : false, //同步执行
                        url : "${basePath }getAllecharts",
                        data : {uid:jsonStr},
                        dataType : "json", //返回数据形式为json
                        success : function(json) {
                            if (json) {
                                for(var i=0;i<json.length;i++){
                                    console.log(json[i].context);
                                    arr.push(json[i].user.oname);
                                }
                            }
                        },
                        error : function(errorMsg) {
                            alert("不好意思,图表请求数据失败啦!");
                            myChart.hideLoading();
                        }
                    })
                    return arr;
                })()
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                'name': '分数',
                'type': 'line',
                'data':(function(){
                    var arr=[];
                    var jsonStr = $("#jsonStr").html();
                    $.ajax({
                        type : "post",
                        async : false, //同步执行
                        url : "${basePath }getAllecharts",
                        data : {uid:jsonStr},
                        dataType : "json", //返回数据形式为json
                        success : function(json) {
                            if (json) {
                                for(var i=0;i<json.length;i++){
                                    console.log(json[i].context);

                                    arr.push(json[i].user.score);
                                }
                            }
                        },
                        error : function(errorMsg) {
                            alert("不好意思,图表请求数据失败啦!");
                            myChart.hideLoading();
                        }
                    })
                    return arr;
                })()
            }
        ]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
</body>