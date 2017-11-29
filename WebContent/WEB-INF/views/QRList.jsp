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

<script type="text/javascript">

	function queryLastPage()
	{
		var start = $("#currentPageIndex").text();
		if(start > 1)
		{
			start -= 2;
			queryReport(start);
		}
	}
	
	function queryNextPage()
	{
		var start = $("#currentPageIndex").text();
		var num = $("#totalPageNum").text();
		
		if(start < num)
			queryReport(start);
	}

	//查询
	function queryReport(startIndex){

		var json = {
				"lot": $("#lotInput").val(),
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
		                trHTML += "<th>";
		                trHTML += "<input id=\"UserActionButton\" type=\"button\" value=\"查看\" >";
		                if(datajson[7] != "PASS")
		                {
		                	if(datajson[4] == "${ncd_user.name}")
		                		trHTML += "<input class=\"UserActionButton\" type=\"button\" value=\"编辑\" >";
		                		
			                trHTML += "<input class=\"UserActionButton\" type=\"button\" value=\"审核\" >";
		                }
		                
		                trHTML += "</th></tr>";
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

		$("#ReportTableBody").on('click','input',function(){
			var bn = $(this).val();
			
			var selectId = $(this).parent().parent().children().eq(1).text();
			
			$(".selectId").val(selectId);
			
			//查看
			if(bn == "查看")
			{
				$(".infoForm").submit();
			}
			//编辑
			else if(bn == "编辑")
			{
				$(".editForm").submit();
			}
			//审核
			if(bn == "审核")
			{
				$(".CheckForm").submit();
			}

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
						<th width="100">创建时间</th>
						<th width="100">创建人</th>
						<th width="100">审核时间</th>
						<th width="100">审核人</th>
						<th width="100">状态</th>
						<th width="100">操作</th>
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
				<th onclick="queryLastPage();" class="prePageTh"><span class="icon icon-mid"><span class="icon-rewind"></span></span></th>
				<th onclick="queryNextPage();" class="nextPageTh"><span class="icon icon-mid"><span class="icon-forward"></span></span></th>
			</tr>
		</table>
	</div>
	
<form class="infoForm" action="QRComAction" method="post" style="display:none;">
	<input type="text" class="selectId" name="selectId"/>
	<input type="text" name="actionName" value="QRInfo">
</form>

<form class="CheckForm" action="QRComAction" method="post" style="display:none;">
	<input type="text" class="selectId" name="selectId"/>
	<input type="text" name="actionName" value="gotoCheckQR">
</form>

<form class="editForm" action="QRComAction" method="post" style="display:none;">
	<input type="text" class="selectId" name="selectId"/>
	<input type="text" name="actionName" value="gotoCreateQR">
</form>

</body>
</html>