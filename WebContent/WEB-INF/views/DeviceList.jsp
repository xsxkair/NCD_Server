<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>纽康度</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/DeviceList.css">

<script src="https://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>
<script type="text/javascript">
	
	function queryAllYGFXYDevice(deviceType)
	{
		if(deviceType == "YGFXY_1")
			$(".FirstDeviceDiv").empty();
		else if(deviceType == "YGFXY_2")
			$(".SecondDeviceDiv").empty();
		
		var json = {
				"deviceType": deviceType,
		    };
		
		$.ajax(
				{
					url : "queryAllDevice",
					type : "POST",
					data : json,
					success : function(data){
						var html;
						var myDate = new Date().getTime();
						var miltime = 0;
						$.each(data, function (index, obj) 
						{
							miltime = obj.time;
							html = "<div id=\"" + obj.did + "\" ";
							
							if(myDate - miltime < 4200000)
							{
								html += "class=\"online\" " ;
							}
							html += "><h4>";
							html += obj.did;
							html += "</h4><p>";
							html += obj.addr;
							html += "</p><p><span>";
							html += obj.dversion;
							html += "</span><span class=\"needupdateclass\">";
							
							if(!obj.newest)
								html += "(需要更新)";
							
							html += "</span></p></div>";
							
							if(obj.type == "YGFXY_1")
								$(".FirstDeviceDiv").append(html);
							else if(obj.type == "YGFXY_2")
								$(".SecondDeviceDiv").append(html);

						});
					},
					error : function(data){
						alert("Fail");
					}
				}
		);
	}
	
	$(function(){
		queryAllYGFXYDevice("YGFXY_1");
		queryAllYGFXYDevice("YGFXY_2");
		
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
	<div class="FirstDevice">
		<h3>第一代荧光免疫分析仪</h3>
		<div class="FirstDeviceDiv dataDiv"></div>
	</div>
	<div class="SecondDevice">
		<h3>半自动荧光免疫分析仪</h3>
		<div class="SecondDeviceDiv dataDiv"></div>
	</div>
</div>

<form class="form" action="queryOneDevice" method="post" style="display:none;">
	<input type="text" id="did" name="did">
</form>


</body>
</html>