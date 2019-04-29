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
        main
        {
            text-align:center;
        }
        .button {
            justify-content: center;
            align-items: center;
            display: inline-block;
            padding: 0px 12px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #fff;
            height:50px ;
            border-radius: 15px;
            box-shadow: 0 6px #999;
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
        .button:hover {background-color: #3e8e41}
        .button1:active {
            background-color: #3e8e41;
            box-shadow: 0 5px #666;
            transform: translateY(4px);
        }
    </style>
    <meta charset="utf-8">
    <link href="${basePath }weblib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${basePath }css/base.css">
    <title>学习情况查看-研究生学习评测系统</title>
    <link rel="shortcut icon" href="${basePath }img/favicon.ico"/>
    <link rel="bookmark" href="${basePath }img/favicon.ico"/>
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
                    <button name="quit"onclick="window.location.href='${basePath }logout'" class="button button2">退出</button>
                    <button name="password"onclick="window.location.href='${basePath }cpasswd'" class="button button3">修改密码</button>
                   <button name="back"onclick="window.location.href='${basePath }mStudent'" class="button button4">返回</button>
                </div>
            </div>
        </div>
    </nav>
</header>

<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<!-- ECharts单文件引入 -->

<!--历史-->
<section>
    <button id="week"  value="${basePath }getlastweek" class="button button1" name="week"onclick="change()">切换本周</button></p>
   <%-- <button id="month" value="${basePath }getAllecharts" class="btn btn-danger" onclick="del()">month</button>--%>
    <div id="main" style="width: 1000px;height:600px;" ></div>
    <div class="container">
        <hr>
        <div class="history">
            <p>${student.name }的所有得分记录</p>
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
               <td> </td>
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
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
    var option1 = {
        tooltip: {
            show: true
        },
        legend: {
            data: ['学习情况']
        },
        title: {
            text: '${student.name }本月学习情况'
        },
        xAxis: [
            {   'name': '任务内容',
                'type': 'category',
                'data': (function show(){
                    //ht = $(this).val();
                    //alert(ht);
                    var jsonStr = $("#jsonStr").html();
                    var arr=[];
                    $.ajax({
                        type : "post",
                        async : false, //同步执行
                        url : "${basePath }getlastmonth",
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
                            alert("获取内容失败!");
                            myChart.hideLoading();
                        }
                    })
                    return arr;
                }

                )()
            }
        ],
        yAxis: [
            {
                'name': '分数/(分)',
                'type': 'value'
            }
        ],
        series: [
            {
                'type': 'line',
                'data':(function show(){
                    var arr=[];
                    var jsonStr = $("#jsonStr").html();
                    console.log(jsonStr);
                    $.ajax({
                        type : "post",
                        async : false, //同步执行
                        url : "${basePath }getlastmonth",
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
                            alert("获取分数失败!");
                            myChart.hideLoading();
                        }
                    })
                    return arr;
                })()
            }
        ]
    };
    // 使用刚指定的配置项和数据显示图表。
    var option = {
        tooltip: {
            show: true
        },
        legend: {
            data: ['本周学习情况']
        },
        title: {
            text: '${student.name }本周学习情况'
        },
        xAxis: [
            {   'name': '任务内容',
                'type': 'category',
                'data': (function show(){
                        //ht = $(this).val();
                        //alert(ht);
                        var jsonStr = $("#jsonStr").html();
                        var arr=[];
                        $.ajax({
                            type : "post",
                            async : false, //同步执行
                            url : "${basePath }getlastweek",
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
                                alert("获取内容失败!");
                                myChart.hideLoading();
                            }
                        })
                        return arr;
                    }

                )()
            }
        ],
        yAxis: [
            {
                'name': '分数/(分)',
                'type': 'value'
            }
        ],
        series: [
            {
                'type': 'line',
                'data':(function show(){
                    var arr=[];
                    var jsonStr = $("#jsonStr").html();
                    console.log(jsonStr);
                    $.ajax({
                        type : "post",
                        async : false, //同步执行
                        url : "${basePath }getlastweek",
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
                            alert("请求分数失败!");
                            myChart.hideLoading();
                        }
                    })
                    return arr;
                })()
            }
        ]
    };
    myChart.setOption(option1);
    counter =false;
    function change(){
            if(counter){
                myChart.setOption(option1);
                $("#week").html('切换本周');
             counter= false;
         }else{
                myChart.setOption(option);
                $("#week").html('切换本月');
            counter= true;
        }
    }
 //   console.log(this.thumbs);
</script>
</body>