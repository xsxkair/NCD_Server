<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<link rel="stylesheet" type="text/css" href="css/LoginPageCss.css">

<script src="https://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="layui/css/layui.css">
<script src="layui/layui.all.js" type="text/javascript"></script>

<script>

	$(function(){
		layui.use('form', function(){
			  var form = layui.form;
			  form.render();
			  //各种基于事件的操作，下面会有进一步介绍
			});
	});

</script>
</head>
<body>
	<form class="layui-form" action="loginNotJson" method="post">
		<h1  >Welcome</h1>
  <div class="layui-form-item">
    <label class="layui-form-label">账号</label>
    <div class="layui-input-block">
      <input type="text" name="account" required  lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">密码</label>
    <div class="layui-input-block">
      <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
    </div>
  </div>
    <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit lay-filter="formDemo">提交</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
  </div>
  </form>
</body>
</html>