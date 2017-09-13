<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>纽康度</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/cikonss.css">
<link rel="stylesheet" type="text/css" href="css/reportList.css">

<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>
<script type="text/javascript">

	function queryReportFromStart()
	{
		queryReport(0);
	}
	
	function queryReportFromIndex()
	{
		var start = $("#targetPageIndex").val();
		var num = $("#totalPageNum").text();
		
		if(start > num)
			queryReport(num - 1);
		else
		{
			start = start-1;
			if(start < 0)
				start = 0;
			queryReport(start);
		}
	}
	function queryReportFromIndex2(pageindex)
	{
		queryReport(pageindex - 1);
	}
	
	function queryReportFromEnd()
	{
		var num = $("#totalPageNum").text();
		
		if(num > 0)
			queryReport(num-1);
	}
	
	//查询
	function queryReport(startIndex){

		var json = {
				"lot": $("#lotInput").val(),
				"time": $("#timeInput").val(),
				"device": $("#deviceInput").val(),
				"sample": $("#sampleInput").val(),
				"pageSize": $("#pageSizeSelect").val(),
				"startIndex": startIndex,
		    };

		$.ajax(
			{
				url : "queryReportAction",
				type : "POST",
				data : json,
				success : function(data){
					var json = data.datas;  //自定义一个json数组
					var i,num;
					var currentPageIndex = data.currentPageIndex+1;
					var totalPage = data.totalPageNum;
					
					num = currentPageIndex - 5;
					if(num <= 0)
						num = 1;
					
					$("#derictPage").empty();
					var htmlText = "<ul>"
					for(i=num; i<currentPageIndex; i++)
					{
						htmlText += "<li onclick=\"queryReportFromIndex2(";
						htmlText += i;
						htmlText += ");\">";
						htmlText += i;
						htmlText += "</li>";
					}
					 
					 num = currentPageIndex + 5;
						if(num > totalPage)
							num = totalPage;

						for(i=currentPageIndex+1; i<=num; i++)
						{
							htmlText += "<li onclick=\"queryReportFromIndex2(";
							htmlText += i;
							htmlText += ");\">";
							htmlText += i;
							htmlText += "</li>";
						}
						htmlText += "</ul>";
						 $("#derictPage").append(htmlText);
					 
					//显示当前页数
					$("#currentPageIndex").text(currentPageIndex);
					$("#totalPageNum").text(totalPage);
					$("#totalNum").text(data.totalNum);

					$("#ReportTableBody").empty();
					num = data.currentPageIndex*$("#pageSizeSelect").val();
					
		            $.each(json, function (index, obj) {
		                var datajson = obj;
		                var trHTML = "<tr";
		                index += num;
		                if(datajson[3].indexOf("Error") >= 0)
		                	trHTML += " class=\"errorItem\"><th>"+index+"</th>";
		                else
		                	trHTML += "><th>"+index+"</th>";

		                $.each(datajson, function (index2, item){
		                	if(index2 == 0)
		                		trHTML += "<th id=\""+item+"\">"+item+"</th>";
		                	else
		                		trHTML += "<th>"+item+"</th>";
		                });
		                trHTML += "</tr>";
		                $("#ReportTableBody").append(trHTML);
		            });
				},
				error : function(data){
					$("#ReportTableBody").empty();
				}
			}
		);
	}
	
	//显示详情
	$(document).ready(function(){
		$("#ReportTableBody").on('click','tr',function(){
	       	x = $(this).children().eq(1);
	       	var url = "queryReportDetailAction?reportId=";
	       	url += x.text();
	       	location.href = url;
	    });
	});
</script>
</head>

<body class="dowebok">
<div class="header">
	<div class="inner">
		<h1><a href="http://www.116.62.108.201:8080/NCD_Server/"><img src="image/logo.png" alt="logo"></a></h1>
		<ul class="nav">
			<li><a>报告查询</a></li>
			<li><a>二维码</a></li>
		</ul>
	</div>
</div>
<br>

<div class="mainBodyDiv">
	<table class="dataBodyHeadTable">
		<tr>
			<th>批号<input id="lotInput" type="text"></th>
			<th>测试时间<input id="timeInput" type="text" placeholder="yyyy-mm-dd"/></th>
			<th>测试设备<input id="deviceInput" type="text"></th>
			<th>样本编号<input id="sampleInput" type="text"></th>
			<th><input name="Submit" type="button" value="查询" onClick="queryReportFromStart();"></th>
		</tr>
	</table>

	<div id="dataTableDiv">
		<table id="dataTable">
			<thead style="background-color: #3295D3;">
				<tr>
					<th width="50">编号</th>
					<th width="50">数据库索引</th>
					<th width="100">试剂卡编号</th>
					<th width="100">测试时间</th>
					<th width="80">测试结果</th>
					<th width="100">测试设备</th>
					<th width="100">样本编号</th>
				</tr>
			</thead>
			<tbody id="ReportTableBody" />
		</table>
	</div>

	<table class="ControlBodyTable">
		<tr>
			<th>每页：
			<select id="pageSizeSelect" onchange="queryReportFromStart();">
		        <option value ="5">5</option>
		        <option value ="50">50</option>
		        <option value="100">100</option>
		        <option value="200">200</option>
		    </select>
		    条</th>
			<th>当前显示第
			<em id="currentPageIndex">0</em>
			/
			<em id="totalPageNum">0</em>
			页 (共
			<em id="totalNum"> 50 </em>
			条记录) </th>
			<th onclick="queryReportFromStart();"><span class="icon icon-mid"><span class="icon-prev"></span></span></th>
			<th  id="derictPage"/>
			<th class="inputPageIndex"><div>跳转到</div><input id="targetPageIndex" type="text"><div><span class="icon icon-mid"><span class="icon-play" onclick="queryReportFromIndex();"></span></span></div></th>
			<th onclick="queryReportFromEnd();"><span class="icon icon-mid"><span class="icon-next"></span></span></th>
		</tr>
	</table>

</div>


</body>
</html>