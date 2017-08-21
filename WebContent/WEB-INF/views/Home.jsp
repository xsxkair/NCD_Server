<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>纽康度</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>

<script type="text/javascript">

	//查询
	function queryReport(){

		var json = {
				"lot": $("#lotInput").val(),
				"time": $("#timeInput").val(),
				"device": $("#deviceInput").val(),
				"sample": $("#sampleInput").val(),
		    };

		$.ajax(
			{
				url : "queryReportAction",
				type : "POST",
				data : json,
				success : function(data){
					var json = data.datas;  //自定义一个json数组
		            $.each(json, function (index, obj) {
		                var datajson = obj;
		                var trHTML = "<tr><td>"+index+"</td>";
		                $.each(json, function (lot, time, result,device, sample){
		                	trHTML += "<td>"+lot+"</td><td>"+time+"</td><td>"+device+"</td><td>"+sample+"</td><td>"+result+"</td></tr>";
		                }
		                $(".dataTable").append(trHTML);
		            });
				}
			}
		);
	}
</script>
</head>

<body class="dowebok">
<div class="header">
	<div class="inner">
		<h1><a href="http://www.116.62.108.201:8080/NCD_Server/login.com/"><img src="image/logo.png" alt="logo"></a></h1>
		<ul class="nav">
			<li><a>报告查询</a></li>
			<li><a>二维码</a></li>
		</ul>
	</div>
</div>
<br>
<div style="margin-top: 300px; text-align: center; color: #f50;">
	批号<input id="lotInput" type="text">
	测试时间<input id="timeInput" type="text">
	测试设备<input id="deviceInput" type="text">
	样本编号<input id="sampleInput" type="text">
	<input name="Submit" type="button" value="查询" onClick="queryReport();">	
</div>

<table class="dataTable">
	
</table>

</body>
</html>