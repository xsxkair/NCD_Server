<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>审核二维码</title>

	<link rel="stylesheet" type="text/css" href="css/CreateQR.css">
	<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
	<script src="https://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>

	<script type="text/javascript">

	function checkQr(isPass){

		var json = {
				"cid": $("#cid").val(),
				"userid": JSON.parse("${ncd_user.id}"),
				"isCheckPass": isPass
		    };
		
		$.ajax({
			url : "CheckQR",
			type : "POST",
			data : json,
			success : function(data){
				if(data == "Success")
					location.href = "QRListPage";
				else
					alert(data);
			}
		});
	}
	
	$(function(){
		var fend1 = parseFloat("${qrdata.fend1}");
		var fend2 = parseFloat("${qrdata.fend2}");
		var qu1e = JSON.parse("${qrdata.qu1ise}");
		var qu2e = JSON.parse("${qrdata.qu2ise}");
		var qu3e = JSON.parse("${qrdata.qu3ise}");
		var checkRight = JSON.parse("${ncd_user.checkqr}");
		var calmode = parseInt("${qrdata.calmode}");
		
		if(calmode == 1)
			$("#calmode").val("T/C");
		else
			$("#calmode").val("T/T+C");
		
		if(qu1e)
			$("#quxian1").text("y = ${qrdata.qu1_a}*e(${qrdata.qu1_b}*x+${qrdata.qu1_c})+${qrdata.qu1_d}");
		else
			$("#quxian1").text("y = ${qrdata.qu1_a}*x^2 + ${qrdata.qu1_b}*x + ${qrdata.qu1_c}");
		
		if(fend1 > 0)
		{
			if(qu2e)
				$("#quxian2").text("y = ${qrdata.qu2_a}*e(${qrdata.qu2_b}*x+${qrdata.qu2_c})+${qrdata.qu2_d}");
			else
				$("#quxian2").text("y = ${qrdata.qu2_a}*x^2 + ${qrdata.qu2_b}*x + ${qrdata.qu2_c}");
		}
		
		if(fend2 > 0)
		{
			if(qu3e)
				$("#quxian3").text("y = ${qrdata.qu3_a}*e(${qrdata.qu3_b}*x+${qrdata.qu3_c})+${qrdata.qu3_d}");
			else
				$("#quxian3").text("y = ${qrdata.qu3_a}*x^2 + ${qrdata.qu3_b}*x + ${qrdata.qu3_c}");
		}
		
		if(checkRight == false)
			$(".checkbn").hide();

		$("#CheckCid").val("${qrdata.cid}");
		$("#cid").val("${qrdata.cid}");
		$("#item").val("${qrdata.item}");
		$("#channel").val("${qrdata.channel}");
		$("#t_l").val("${qrdata.t_l}");
		$("#waitt").val("${qrdata.waitt}");
		$("#c_l").val("${qrdata.c_l}");
		$("#outdate").val("${qrdata.outdate}");
		$("#fend1").val("${qrdata.fend1}");
		$("#fend2").val("${qrdata.fend2}");
		$("#creator").text("${qrdata.creator.name}");
		$("#creatTime").text("${qrdata.uptime}");
		
		$('#fend1').attr("disabled", "disabled");
		$("#qu2Div input").attr("disabled","disabled");
		$("#fend2").attr("disabled","disabled");
		$("#qu3Div input").attr("disabled","disabled");
		$(":text").attr("disabled","disabled");
		$("input[name='qunum']").attr("disabled","disabled");
	});
	
</script>
</head>
<body>
	<%@include file="menu.jsp"%>

	<form class="checkForm" action="CheckQR" method="post" style="display:none;">
		<input type="text" id="CheckCid" name="cid" value="1">
		<input type="text" id="checkerid" name="userid" value="2">
		<br> 合格
		<input id="checkPassInput" type="radio" name="isCheckPass" value="true" >
		<br> 不合格
		<input id="checkNotPassInput" type="radio" name="isCheckPass" value="false" >
		<br>
	</form>
            
    <div class="createForm">
                <div>
                    <div class="formItem"><strong>批号：</strong></div>
                    <div class="formInput">
                        <input type="text" id="cid" name="cid">
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>项目名称：</strong></div>
            		<div class="formInput">
            			<input type="text" id="item" name="item">
            		</div>
                </div>
                <div>
            		<div class="formItem"><strong>通道号：</strong></div>
                    <div class="formInput">
                        <input type="text" id="channel" name="channel">
                    </div>
                </div>
                <div>
            		<div class="formItem"><strong>结果计算方式：</strong></div>
                    <div class="formInput">
                        <input type="text" id="calmode" name="calmode">
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>T线位置：</strong></div>
                    <div class="formInput">
                        <input type="text" id="t_l" name="t_l">
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>C线位置：</strong></div>
                    <div class="formInput">
                        <input type="text" id="c_l" name="c_l">
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>层析时间：</strong></div>
                    <div class="formInput">
                        <input type="text" placeholder="分钟" id="waitt" name="waitt">
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>过期日期：</strong></div>
                    <div class="formInput">
                        <input type="text" placeholder="yyyy-mm-dd" id="outdate" name="outdate">
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>曲线1：</strong></div>
                    <div class="formInput quxian" id="quxian1">
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>临界值1：</strong></div>
                    <div class="formInput">
                        <input type="text" id="fend1" name="fend1">
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>曲线2：</strong></div>
                    <div class="formInput quxian" id="quxian2">
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>临界值2：</strong></div>
                    <div class="formInput">
                        <input type="text" id="fend2" name="fend2">
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>曲线3：</strong></div>
                    <div class="formInput quxian" id="quxian3">
                    </div>
                </div>
				
				<div class="createrDiv">
                    <div class="formItem"><strong>创建人：</strong></div>
                    <div class="formInput"><em id="creator"></em></div>
                </div>

                <div class="createrDiv">
                    <div class="formItem"><strong>创建时间：</strong></div>
                    <div class="formInput"><em id="creatTime"></em></div>
                </div>
                
                <input class="checkbn" type="button" value="合格" onclick="checkQr(true);">
                <input class="checkbn" type="button" value="不合格" onclick="checkQr(false);">
 
           </div>
</body>
</html>