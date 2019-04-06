<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<% String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	application.setAttribute("basePath", basePath);
%>
<form class="form-horizontal">
	<div class="row">
		<h1 style="text-align: center;">添加学生信息</h1>
	</div>
	</div>
	<div class="panel-body">
		<form class="form-horizontal" role="form" action="/admin/addStudent" id="editfrom" method="post">
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">学号</label>
				<div class="col-sm-10">
					<input type="number" class="form-control" id="inputEmail3" name="userid" placeholder="请输入学号"
					<c:if test='${student!=null}'>
						   value="${student.userid}"
					</c:if>>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-2 control-label">姓名</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputPassword3" name="username" placeholder="请输入姓名"
					<c:if test='${student!=null}'>
						   value="${student.username}"
					</c:if>>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-2 control-label">性别</label>
				<div class="col-sm-10">
					<label class="checkbox-inline">
						<input type="radio" name="sex" value="男" checked>男
					</label>
					<label class="checkbox-inline">
						<input type="radio" name="sex" value="女">女
					</label>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-2 control-label">出生年份</label>
				<div class="col-sm-10">
					<input type="date" value="1996-09-02" name="birthyear"/>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-2 control-label" name="grade">入学时间</label>
				<div class="col-sm-10">
					<input type="date" value="2015-09-02" name="grade"/>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-2 control-label" name="grade">所属院系</label>
				<div class="col-sm-10">
					<select class="form-control" name="collegeid">
						<c:forEach items="${collegeList}" var="item">
							<option value="${item.collegeid}">${item.collegename}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group" style="text-align: center">
				<button class="btn btn-default" type="submit">提交</button>
				<button class="btn btn-default" type="reset">重置</button>
			</div>
		</form>
	</div>
	</div>
</form>
<script>
	$("#closemessage_id").click(function () {
		$("#adderrormessage").addClass("hidden");
	});
</script>