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
<script src="scripts/menu.js"></script>

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
	
	function checkQR(){
		var json = {
				"cid": $("#pihao").val(),
		    };

		$.ajax(
			{
				url : "CheckQRAction",
				type : "POST",
				data : json,
				success : function(data){
					alert(data)
					location.reload();
				},
				error : function(data){
					alert("Error")
				}
			}
		);
	}
	
	function downQR(){
		var url = "DownloadQR?cid=";
       	url += $("#pihao").val();
       	location.href = url;
	}
	
	function fresh(){
		$("#pihao").val("${qrdata.cid}");
		$("#item").val("${qrdata.item}");
		$("#channel").val("${qrdata.channel}");
		$("#t_l").val("${qrdata.t_l}");
		$("#waitt").val("${qrdata.waitt}");
		$("#c_l").val("${qrdata.c_l}");
		$("#outdate").val("${qrdata.outdate}");
		$("#fend1").val("${qrdata.fend1}");
		$("#fend2").val("${qrdata.fend2}");
		$("#qu1_a").val("${qrdata.qu1_a}");
		$("#qu1_b").val("${qrdata.qu1_b}");
		$("#qu1_c").val("${qrdata.qu1_c}");
		$("#qu2_a").val("${qrdata.qu2_a}");
		$("#qu2_b").val("${qrdata.qu2_b}");
		$("#qu2_c").val("${qrdata.qu2_c}");
		$("#qu3_a").val("${qrdata.qu3_a}");
		$("#qu3_b").val("${qrdata.qu3_b}");
		$("#qu3_c").val("${qrdata.qu3_c}");
		$("#creator").text("${qrdata.creator.name}");
		$("#creatTime").text("${qrdata.uptime}");
		$("#manager").text("${qrdata.checker.name}");
		$("#managerTime").text("${qrdata.managetime}");
		$("#desc").val("${qrdata.dsc}");
		
		var createright = JSON.parse("${manager.createqr}");
		var checkright = JSON.parse("${manager.checkqr}");
		
		if(${!empty(qrdata)})
		{
			var data8 = parseInt("${qrdata.fend1}");
			var data9 = parseInt("${qrdata.fend2}");
			var ischecked = JSON.parse("${qrdata.checked}");
			var checkstatus = "${qrdata.dsc}";
			
			if(data9 > 0)
			{
				$("#qunum3").attr("checked","checked");
				$("#qunum3").trigger("change");
			}
			else if(data8 > 0)
			{
				$("#qunum2").attr("checked","checked");
				$("#qunum2").trigger("change");
			}
			else
			{
				$("#qunum1").attr("checked","checked");	
				$("#qunum1").trigger("change");
			}
			
			if(checkright)
				$(".statusDiv input").removeAttr("disabled");
			else
				$(".statusDiv input").attr("disabled","disabled");
			
			if(ischecked)
			{
				$("#ischecked1").attr("checked","checked");
				$(":input").attr("disabled","disabled");
				
				if(checkstatus == "通过")
					$("#downbn").removeAttr("disabled");
			}
			else
				$("#ischecked2").attr("checked","checked");
		}
		else
		{
			$("#qunum1").attr("checked","checked");
			$("#qunum1").trigger("change");

			$("#ischecked2").attr("checked","checked");
			$("#desc").val("待审核");
			
			$(".statusDiv input").attr("disabled","disabled");
			$("#checkbn").attr("disabled","disabled");
			$("#downbn").attr("disabled","disabled");
			
			if(createright)
				$("#createbn").removeAttr("disabled");
			else
				$("#createbn").attr("disabled","disabled");
		}
	}
	
	$(function(){
		$(".qunum").change(function(){
			var quNum = $(this).val();
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
		});
	});
	
	$(function(){
		fresh();		
	});
	
</script>
</head>
<body>
	<%@include file="menu.jsp"%>
	
	<div class="qrInfoDiv">
		<p>批号：<input type="text" id="pihao"></p>
		<p>项目名称：<select id="item">
		        <option value ="NT-proBNP">NT-proBNP</option>
		        <option value ="cTnI">cTnI</option>
		        <option value="Myo">Myo</option>
		        <option value="CK-MB">CK-MB</option>
		    </select></p>
		<p>通道号：<input type="text" id="channel"></p>
		<p>T线位置：<input type="text" id="t_l"></p>
		<p>C线位置：<input type="text" id="c_l"></p>
		<p>层析时间：<input type="text" id="waitt"></p>
		<p>过期日期：<input type="text" id="outdate"></p>
		<p>曲线数目：一条曲线<input id="qunum1" class="qunum" type="radio" name="qunum" value="1" checked="checked"/>
				二条曲线<input id="qunum2" class="qunum" type="radio" name="qunum" value="2" />
				三条曲线<input id="qunum3" class="qunum" type="radio" name="qunum" value="3" />
		</p>
		<p>曲线1：<input type="text" id="qu1_a">x^2  <input type="text" id="qu1_b">x  <input type="text" id="qu1_c"></p>
		<p class="fend1P">临界值1：<input type="text" id="fend1"></p>
		<p class="qu2P">曲线2：<input type="text" id="qu2_a">x^2  <input type="text" id="qu2_b">x  <input type="text" id="qu2_c"></p>
		<p class="fend2P">临界值2：<input type="text" id="fend2"></p>
		<p class="qu3P">曲线3：<input type="text" id="qu3_a">x^2  <input type="text" id="qu3_b">x  <input type="text" id="qu3_c"></p>
		<div class="createrDiv">
			<p>创建人：<em id="creator" type="text"  disabled="disabled"/></p>
			<p>创建时间：<em id="creatTime" type="text" disabled="disabled"/></p>
		</div>
		<div class="managerDiv">
			<p>审核人：<em id="manager" type="text" disabled="disabled"/></p>
			<p>审核时间：<em id="managerTime" type="text" disabled="disabled"/></p>
		</div>
		<div class="statusDiv">
			<p>是否审核：          是<input id="ischecked1" type="radio" name="ischecked" value="1" />
						        否<input id="ischecked2" type="radio" name="ischecked" value="2" />
			</p>
			
			<p>说明：<input type="text" id="desc"></p>
		</div>

		<p>
			<input id="createbn" name="Submit1" type="button" value="提交二维码" onClick="submitQRData();">
			<input id="checkbn" name="Submit1" type="button" value="提交审核" onClick="checkQR();">
			<input id="downbn" type="button" value="下载" onClick="downQR();">
		</p>
	</div>
</body>
</html>