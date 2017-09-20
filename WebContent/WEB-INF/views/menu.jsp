<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
$(document).ready(function(){
	var userName = "${sessionScope.ncd_name}";
	$("#UserName").text(userName);
});
</script>
<div class="menuDiv">
	<div class="logoDiv">
		<h1><a href="HomePage"><img src="image/logo.png" alt="logo"></a></h1>
	</div>
	<div class="nav">

	  <ul>

	    <li><a href="#">用户</a>

	       <ul>

	            <li><a href="queryUser">个人信息</a></li>

	            <li><a href="UserListPage">人员管理</a></li>

	        </ul>

	    </li>

	    <li><a href="#">试剂卡管理</a>

	      <ul>

	            <li><a href="#">用量查询</a></li>

	            <li><a href="#">试剂卡查询</a></li>

	            <li><a href="QRCreatePage">二维码制作</a></li>

	            <li><a href="QRListPage">二维码查询</a></li>

	        </ul>

	    </li>

	    <li><a href="#">设备查询</a></li>

	    <li><a href="ReportPage">报告查询</a></li>

	    <li><a href="HomePage">首页</a></li>

	  </ul>

	</div>

	<div class="UserDiv">
		<form action="execute" method="post">
			<button type="submit" >注销</button>
		</form>
		<a id="UserName" href="queryUser"></a>
	</div>
</div>
