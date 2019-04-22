<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<% String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	application.setAttribute("basePath", basePath);
%>
<form class="form-horizontal" method="post" action="${basePath }editStudent2" onsubmit="return check()" name="reset">
	<h1>学生信息：</h1>
	<div class="alert alert-danger alert-dismissible fade in hidden" role="alert" id="adderrormessage">
		<button type="button" class="close" aria-label="Close" id="closemessage_id"><span
				aria-hidden="true">&times;</span>
		</button>
		<strong>编辑失败!</strong> 请检查网络连接！
	</div>
	<div class="form-group">
		<label for="inputEmail" class="col-sm-2 control-label">学生号</label>
		<div class="col-sm-10">
			<input   type="text" class="form-control" name="uid" value="${user.uid }">
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail" class="col-sm-2 control-label">学号</label>
		<div class="col-sm-10">
			<input  type="text" class="form-control" name="filepath" id="inputEmail" value="${user.username }">
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail" class="col-sm-2 control-label">姓名</label>
		<div class="col-sm-10">
			<input  type="text" class="form-control" name="filepath" id="inputname" value="${user.name }">
		</div>
	</div>
	<div class="form-group">
		<label for="inputPassword" class="col-sm-2 control-label">密码</label>
		<div class="col-sm-10">
			<input type="text" name="password" class="form-control" id="inputPassword" value="${user.password }" placeholder="请输入密码">
		</div>
	</div>
	<div class="form-group" style="text-align: center">
		<button class="btn btn-default" type="submit">提交</button>
		<button class="btn btn-default">重置</button>
	</div>
</form>
<script>
	$("#closemessage_id").click(function () {
		$("#adderrormessage").addClass("hidden");
	});
	$("#nav li:nth-child(1)").addClass("active")
	function check() {
		if(reset.score.value==""||reset.score.value==null)
		{alert("请输入成绩");return false;}
	}

</script>