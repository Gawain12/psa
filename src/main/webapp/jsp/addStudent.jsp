<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<% String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	application.setAttribute("basePath", basePath);
%>
<form class="form-horizontal">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h1>添加学生：</h1>
	<div class="alert alert-danger alert-dismissible fade in hidden" role="alert" id="adderrormessage">
		<button type="button" class="close" aria-label="Close" id="closemessage_id"><span
				aria-hidden="true">&times;</span>
		</button>
		<strong>添加失败!</strong> 请检查网络连接！
	</div>
	<div class="form-group">
		<label for="username" class="col-sm-2 control-label">学号：</label>
		<div class="col-sm-10">
			<input type="number" class="form-control" id="username" placeholder="请输入学号...">
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-2 control-label">姓名：</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="name" placeholder="请输入姓名...">
		</div>
	</div>
	<div class="form-group">
		<label for="percode" class="col-sm-2 control-label">身份：</label>
		<div class="col-sm-10">
			<label>
				<select class="form-control" id="percode">
					<option value=user>学生</option>
					<option value=admin>老师</option>
				</select>
			</label>
		</div>
	</div>
	</div>
	</div>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<button type="button" class="btn btn-default" onclick="add()">添加</button>
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		</div>
	</div>
</form>
<script>
	function add() {
		var username = $("#username").val();
		var name = $("#name").val();
		var percode = $("#percode").val();
		$.get("${basePath }addStudent?username=" + username + "&name=" + name + "&percode=" + percode, function (data) {
			if (data) {
				$('#addmodel').modal('hide');
				window.location.reload();
			} else {
				$("#adderrormessage").removeClass("hidden");
			}
		});
	}
	$("#closemessage_id").click(function () {
		$("#adderrormessage").addClass("hidden");
	});
</script>