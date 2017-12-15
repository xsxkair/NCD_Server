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
		
		function showData(){
			var qrdataIsEmpty = ${empty(qrdata)};
			var createRight = JSON.parse("${ncd_user.createqr}");
			
			if(qrdataIsEmpty)
			{
				$(":text").val("");
				$("#qunum1").attr("checked","checked");
				$("#qunum1").trigger("change");	
			}
			else
			{
				var fend1 = parseFloat("${qrdata.fend1}");
				var fend2 = parseFloat("${qrdata.fend2}");
				var calmode = parseInt("${qrdata.calmode}");
				
				if(fend2 > 0)
				{
					$("#qunum3").attr("checked","checked");
					$("#qunum3").trigger("change");
				}
				else if(fend1 > 0)
				{
					$("#qunum2").attr("checked","checked");
					$("#qunum2").trigger("change");
				}
				else
				{
					$("#qunum1").attr("checked","checked");	
					$("#qunum1").trigger("change");
				}
				
				$("#calmode").val("${qrdata.calmode}");
				
				$("#cid").val("${qrdata.cid}");
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
			}
			
			if(createRight)
				$("#createbn").show();
			else
				$("#createbn").hide();
		}
	
		$(function(){
			$(".qunum").change(function(){
			var quNum = $(this).val();
			if(quNum == 1)
			{
				$('#fend1').attr("disabled", "disabled");
				$("#qu2Div input").attr("disabled","disabled");
				$("#fend2").attr("disabled","disabled");
				$("#qu3Div input").attr("disabled","disabled");
				
				$("#fend1").val(0);
				$("#fend2").val(0);
				$("#qu2_a").val(0);
				$("#qu2_b").val(0);
				$("#qu2_c").val(0);
				$("#qu3_a").val(0);
				$("#qu3_b").val(0);
				$("#qu3_c").val(0);
			}
			else if(quNum == 2)
			{
				$("#fend1").removeAttr("disabled");
				$("#qu2Div input").removeAttr("disabled");
				$("#fend2").attr("disabled","disabled");
				$("#qu3Div input").attr("disabled","disabled");
				
				$("#fend2").val(0);
				$("#qu3_a").val(0);
				$("#qu3_b").val(0);
				$("#qu3_c").val(0);
			}
			else if(quNum == 3)
			{
				$("#fend1").removeAttr("disabled");
				$("#qu2Div input").removeAttr("disabled");
				$("#fend2").removeAttr("disabled");
				$("#qu3Div input").removeAttr("disabled");
			}
		});
	});
		
	function createQr(){
		
		var json = {
				"cid": $("#cid").val(),
				"item": $("#item").val(),
				"channel": $("#channel").val(),
				"calmode": $("#calmode").val(),
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
		
		$.ajax({
			url : "CreateQR",
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
		showData();
		
		$.ajax({
			url : "queryItemList",
			type : "POST",
			success : function(data){
				
				var htmlText = "";
				$('#item').empty();
				$.each(data, function (index, obj) {
					htmlText = "<option value='" + obj + "'>" + obj + "</option>";
					$("#item").append(htmlText);
	            });
			}
		});
	});
	
</script>
</head>
<body>
	<%@include file="menu.jsp"%>

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
            			<select id="item" name="item"></select>
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
                        <select id="calmode" name="calmode">
                        	<option value ="1">T/C</option>
  							<option value ="2">T/T+C</option>
                        </select>
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
                    <div class="formItem"><strong>曲线数目：</strong></div>
                    <div class="formInput"><em>一条曲线</em>
                        <input id="qunum1" class="qunum" type="radio" name="qunum" value="1" />
                        <em>二条曲线</em>
                        <input id="qunum2" class="qunum" type="radio" name="qunum" value="2" />
                        <em>三条曲线</em>
                        <input id="qunum3" class="qunum" type="radio" name="qunum" value="3" />
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>曲线1：</strong></div>
                    <div class="formInput quxian">
                        <input type="text" id="qu1_a" name="qu1_a"><em>x^2</em>
                        <input type="text" id="qu1_b" name="qu1_b"><em>x</em>
                        <input type="text" id="qu1_c" name="qu1_c">
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
                    <div class="formInput quxian" id="qu2Div">
                        <input type="text" id="qu2_a" name="qu2_a"><em>x^2</em>
                        <input type="text" id="qu2_b" name="qu2_b"><em>x</em>
                        <input type="text" id="qu2_c" name="qu2_c">
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
                    <div class="formInput quxian" id="qu3Div">
                        <input type="text" id="qu3_a" name="qu3_a"><em>x^2</em>
                        <input type="text" id="qu3_b" name="qu3_b"><em>x</em>
                        <input type="text" id="qu3_c" name="qu3_c">
                    </div>
                </div>

                <input id="createbn"  type="button" value="提交二维码" onclick="createQr();">
 
           </div>
</body>
</html>