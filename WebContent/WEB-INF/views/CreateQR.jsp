<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>制作二维码</title>

<link rel="stylesheet" type="text/css" href="css/CreateQR.css">
<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>

<script type="text/javascript">

	function submitQRData(){
		var json = {
				"cid": $("#pihao").val(),
				"item": $("#item").val(),
				"channel": $("#channel").val(),
				"t_l": $("#t_l").val(),
				"waitt": $("#waitt").val(),
				"c_l": $("#c_l").val(),
				"outdate": $("#outdate").val(),
				"fend1": $("#fend1").val(),
				"fend2": $("#fend2").val(),
				"qu1_a": $("#qu1_a").val(),
				"qu1_b": $("#qu1_b").val(),
				"qu1_c": $("#qu1_c").val(),
				"qu2_a": $("#qu2_a").val(),
				"qu2_b": $("#qu2_b").val(),
				"qu2_c": $("#qu2_c").val(),
				"qu3_a": $("#qu3_a").val(),
				"qu3_b": $("#qu3_b").val(),
				"qu3_c": $("#qu3_c").val(),
		    };

		$.ajax(
			{
				url : "CreateQRAction",
				type : "POST",
				data : json,
				success : function(data){
					alert(data)
				},
				error : function(data){
					alert("Error")
				}
			}
		);
	}

	$(function(){
		$("[name='qunum']").on("change", 
			function (e) { 
				var quNum = $(e.target).val();
				if(quNum == 1)
				{
					$(".fend1P").hide();
					$(".qu2P").hide();
					$(".fend2P").hide();
					$(".qu3P").hide();
				}
				else if(quNum == 2)
				{
					$(".fend1P").show();
					$(".qu2P").show();
					$(".fend2P").hide();
					$(".qu3P").hide();
				}
				else if(quNum == 3)
				{
					$(".fend1P").show();
					$(".qu2P").show();
					$(".fend2P").show();
					$(".qu3P").show();
				}

				$("#fend1").val(0);
				$("#fend2").val(0);
				$("#qu2_a").val(0);
				$("#qu2_b").val(0);
				$("#qu2_c").val(0);
				$("#qu3_a").val(0);
				$("#qu3_b").val(0);
				$("#qu3_c").val(0);
			}
		);
	});
	
</script>
</head>
<body>
	<%@include file="menu.jsp"%>
	
	<div>
		<p>批号：<input type="text" id="pihao"></p>
		<p>项目名称：<input type="text" id="item"></p>
		<p>通道号：<input type="text" id="channel"></p>
		<p>T线位置：<input type="text" id="t_l"></p>
		<p>C线位置：<input type="text" id="c_l"></p>
		<p>层析时间：<input type="text" id="waitt"></p>
		<p>过期日期：<input type="text" id="outdate"></p>
		<p>曲线数目：
			<ul>
				<li>一条曲线<input id="qunum1" type="radio" name="qunum" value="1" checked="checked"/></li>
				<li>二条曲线<input id="qunum2" type="radio" name="qunum" value="2" /></li>
				<li>三条曲线<input id="qunum3" type="radio" name="qunum" value="3" /></li>
			</ul>
		</p>
		<p>曲线1：<input type="text" id="qu1_a">x^2  <input type="text" id="qu1_b">x  <input type="text" id="qu1_c"></p>
		<p class="fend1P">临界值1：<input type="text" id="fend1"></p>
		<P class="qu2P">曲线2：<input type="text" id="qu2_a">x^2  <input type="text" id="qu2_b">x  <input type="text" id="qu2_c"></p>
		<p class="fend2P">临界值2：<input type="text" id="fend2"></p>
		<P class="qu3P">曲线3：<input type="text" id="qu3_a">x^2  <input type="text" id="qu3_b">x  <input type="text" id="qu3_c"></p>

		<p><input name="Submit1" type="button" value="提交" onClick="submitQRData();"></p>
	</div>
</body>
</html>