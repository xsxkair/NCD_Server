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

		function checkQR(isCheckPass){
			if(isCheckPass)
				$("#checkPassInput").attr("checked","checked");
			else
				$("#checkNotPassInput").attr("checked","checked");
			
			$(".checkForm").submit();
		}
		
		function downQR(){
			var url = "DownloadQR?cid=";
			url += $("#pihao").val();
			location.href = url;
		}
		
		function fresh(){
			var qrdataIsEmpty = ${empty(qrdata)};
			var createRight = JSON.parse("${manager.createqr}");
			
		//如果没有数据，表明要新建二维码
		if(qrdataIsEmpty)
		{
			$(":text").val("");
			$("#qunum1").attr("checked","checked");
			$("#qunum1").trigger("change");

			$(".createrDiv").hide();
			$(".managerDiv").hide();
			$(".DescP").hide();

			$("#checkPassbn").hide();
			$("#checkNotPassbn").hide();
			$("#downbn").hide();
			
			if(createRight)
				$("#createbn").show();
			else
				$("#createbn").hide();
		}
		else
		{
			var fend1 = parseInt("${qrdata.fend1}");
			var fend2 = parseInt("${qrdata.fend2}");
			var checkRight = JSON.parse("${manager.checkqr}");
			var checkPass;
			
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
			
			if(${empty(qrdata.checkok)})
			{
				$("#desc").text("未审核");
				checkPass = false;
			}
			else
			{
				checkPass = JSON.parse("${qrdata.checkok}");
				if(checkPass)
					$("#desc").text("合格");
				else
					$("#desc").text("不合格");
			}
			
			if(checkPass)
			{
				checkRight = false;
				createRight = false;
				$("#downbn").show();
			}
			else 
			{
				$("#downbn").hide();
				
				if("${manager.account}" != "${qrdata.creator.account}")
					createRight = false;
			}
			
			
			if(createRight)
			{
				$("#createbn").show();
				$(":text").remove("disabled");
				$("input[name='qunum']").remove("disabled");
				$("#item").remove("disabled");
			}
			else
			{
				$("#createbn").hide();
				$(":text").attr("disabled","disabled");
				$("input[name='qunum']").attr("disabled","disabled");
				$("#item").attr("disabled","disabled");
			}
			
			if(checkRight)
			{
				$("#checkPassbn").show();
				$("#checkNotPassbn").show();
				
			}
			else
			{
				$("#checkPassbn").hide();
				$("#checkNotPassbn").hide();
				
			}
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
	
	<form class="checkForm" action="CheckQR" method="post" style="display:none;">
                <input type="text" id="CheckCid" name="cid">
                <br> 合格
                <input id="checkPassInput" type="radio" name="isCheckPass" value="true" />
                <br> 不合格
                <input id="checkNotPassInput" type="radio" name="isCheckPass" value="false" />
                <br>
                <button type="submit">Login</button>
            </form>
            <form class="createForm" action="CreateQR" method="post">
                <div>
                    <div class="formItem"><strong>批号：</strong></div>
                    <div class="formInput">
                        <input type="text" id="cid" name="cid">
                    </div>
                </div>
                <div>
                    <div class="formItem"><strong>项目名称：</strong></div>
            		<div class="formInput"><select id="item" name="item">
                        <option value="NT-proBNP">NT-proBNP</option>
                        <option value="cTnI">cTnI</option>
                        <option value="Myo">Myo</option>
                        <option value="CK-MB">CK-MB</option>
                    </select></div>
                </div>
                <div>
            		<div class="formItem"><strong>通道号：</strong></div>
                    <div class="formInput">
                        <input type="text" id="channel" name="channel">
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
                    <div class="formInput quxian">
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
                    <div class="formInput quxian">
                        <input type="text" id="qu3_a" name="qu3_a"><em>x^2</em>
                        <input type="text" id="qu3_b" name="qu3_b"><em>x</em>
                        <input type="text" id="qu3_c" name="qu3_c">
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

                <div class="managerDiv">
                    <div class="formItem"><strong>审核人：</strong></div>
                    <div class="formInput"><em id="manager"></em></div>
                </div>
                <div class="managerDiv">
                    <div class="formItem"><strong>审核时间：</strong></div>
                    <div class="formInput"><em id="managerTime"></em></div>
                </div>
                <div class="DescP">
                    <div class="formItem"><strong>说明：</strong></div>
                    <div class="formInput"><em id="desc"></em></div>
                </div>
                <p class="buttons">
                    <input id="createbn" type="submit" value="提交二维码">
                    <input id="checkPassbn" type="button" value="合格" onClick="checkQR(true);">
                    <input id="checkNotPassbn" type="button" value="不合格" onClick="checkQR(false);">
                    <input id="downbn" type="button" value="下载" onClick="downQR();">
                </p>
            </form>
</body>
</html>