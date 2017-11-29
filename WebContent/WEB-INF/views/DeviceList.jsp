<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>纽康度</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/DeviceList.css">

<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
	
	//查询
	function queryAllDevice(){

		$(".soldDeviceDiv").empty();
		$(".soldDeviceDiv").empty();
		
		$.ajax(
			{
				url : "queryAllDevice",
				type : "POST",
				success : function(data){
					var html;
					var myDate = new Date().getTime();
					var miltime = 0;
					$.each(data, function (index, obj) 
					{
						miltime = obj.time;
						html = "<div id=\"" + obj.did + "\" ";
						
						if(myDate - miltime < 300000)
						{
							html += "class=\"online\" " ;
						}
						html += "><h4>";
						html += obj.did;
						html += "</h4><p>";
						html += obj.addr;
						html += "</p></div>";
						
						if(obj.sold)
							$(".soldDeviceDiv").append(html);
						else
							$(".notSoldDeviceDiv").append(html);
					});
				},
				error : function(data){
					alert("Fail");
				}
			}
		);
	}
	
	$(function(){
		queryAllDevice();
		
		$(".dataDiv").on('click','div',function(){
	       	x = $(this).find('h4');
	       	
	       	$("#did").val(x.text());
	       	$(".form").submit();
	    });
	});

</script>
</head>

<body>

<%@include file="menu.jsp"%>

<div class="mainBodyDiv">
	<div class="soldPanel">
		<h3>医院</h3>
		<div class="soldDeviceDiv dataDiv"></div>
	</div>
	<div class="notSoldPanel">
		<h3>公司</h3>
		<div class="notSoldDeviceDiv dataDiv"></div>
	</div>
</div>

<form class="form" action="queryOneDevice" method="post" style="display:none;">
	<input type="text" id="did" name="did">
</form>


</body>
</html>