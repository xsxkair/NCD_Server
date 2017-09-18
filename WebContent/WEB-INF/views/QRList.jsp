<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>制作二维码</title>

<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/cikonss.css">
<link rel="stylesheet" type="text/css" href="css/QRList.css">
<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="scripts/menu.js"></script>

<script type="text/javascript">

	function queryLastPage()
	{
		var start = $("#currentPageIndex").val();
		if(start > 1)
		{
			start -= 2;
			queryReport(start);
		}
	}
	
	function queryNextPage()
	{
		var start = $("#currentPageIndex").val();
		var num = $("#totalPageNum").text();
		
		if(start < num)
			queryReport(start);
	}

	//查询
	function queryReport(startIndex){

		var json = {
				"lot": $("#lotInput").val(),
				"time": $("#timeInput").val(),
				"startIndex": startIndex,
		    };

		$.ajax(
			{
				url : "QueryQRAction",
				type : "POST",
				data : json,
				success : function(data){
					var json = data.datas;  //自定义一个json数组
					var i,num;
					var currentPageIndex = data.currentPageIndex+1;
					var totalPage = data.totalPageNum;

					//显示当前页数
					$("#currentPageIndex").text(currentPageIndex);
					$("#totalPageNum").text(totalPage);
					$("#totalNum").text(data.totalNum);

					$("#ReportTableBody").empty();
					num = data.currentPageIndex*20;
					
		            $.each(json, function (index, obj) {
		                var datajson = obj;
		                index += num;
		                var trHTML = "<tr><th>"+index+"</th>";

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
	       	var url = "QRInfoAction?qrId=";
	       	url += x.text();
	       	location.href = url;
	    });
		
		queryReport(0);
	});
	
</script>
</head>
<body>

	<%@include file="menu.jsp"%>
	
	<div class="mainBodyDiv">
		<table class="dataBodyHeadTable">
			<tr>
				<th>批号: <input id="lotInput" type="text"></th>
				<th>提交时间: <input id="timeInput" type="text" placeholder="yyyy-mm-dd"/></th>
				<th><input name="Submit" type="button" value="查询" onClick="queryReport(0);"></th>
			</tr>
		</table>

		<div id="dataTableDiv">
			<table id="dataTable">
				<thead style="background-color: #3295D3;">
					<tr>
						<th width="50">编号</th>
						<th width="50">数据库索引</th>
						<th width="100">批号</th>
						<th width="100">名称</th>
						<th width="100">提交时间</th>
						<th width="100">提交人</th>
						<th width="100">审核时间</th>
						<th width="100">审核人</th>
						<th width="100">状态</th>
					</tr>
				</thead>
				<tbody id="ReportTableBody" />
			</table>
		</div>

		<table class="ControlBodyTable">
			<tr>
				<th>当前显示第
				<em id="currentPageIndex">0</em>
				/
				<em id="totalPageNum">0</em>
				页 (共
				<em id="totalNum"> 50 </em>
				条记录) </th>
				<th onclick="queryLastPage();"><span class="icon icon-mid"><span class="icon-rewind"></span></span></th>
				<th onclick="queryNextPage();"><span class="icon icon-mid"><span class="icon-forward"></span></span></th>
			</tr>
		</table>

	</div>

</body>
</html>