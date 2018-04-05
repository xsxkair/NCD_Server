<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>纽康度</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/DeviceInfo.css">


<script src="https://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>
<script src="scripts/echarts.min.js"></script>

<script type="text/javascript">
	
	function showChart(data){
		var x_data = [];
		var y1_data = [];
		var y2_data = [];
		var y3_data = [];
		var y4_data = [];
		var legendData = ['NT-proBNP','cTnI','Myo','CK-MB'];
		$.each(data, function (index, obj) {
            x_data.push(index);
            
            $.each(obj, function (index2, item){
            	if(index2 == 0)
            		y1_data.push(item);
            	else if(index2 == 1)
        			y2_data.push(item);
            	else if(index2 == 2)
        			y3_data.push(item);
            	else if(index2 == 3)
        			y4_data.push(item);
            });
        });
		
		var option = {
			    title: {

			    },
			    tooltip : {
			        trigger: 'axis',
			        axisPointer: {
			            type: 'cross',
			            snap: true,
			            label: {
			                backgroundColor: '#6a7985'
			            }
			        }
			    },
			    legend: {
			    	data: legendData
			    },
			    grid: {
			        left: '3%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },
			    xAxis : [
			        {
			            type : 'category',
			            boundaryGap : false,
			            data : x_data
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value'
			        }
			    ],
			    series : [
			        {
			            name: legendData[0],
			            type:'line',
			            stack: '总量',
			            areaStyle: {normal: {}},
			            data: y1_data
			        },
			        {
			            name: legendData[1],
			            type:'line',
			            stack: '总量',
			            areaStyle: {normal: {}},
			            data: y2_data
			        },
			        {
			            name: legendData[2],
			            type:'line',
			            stack: '总量',
			            areaStyle: {normal: {}},
			            data: y3_data
			        },
			        {
			            name: legendData[3],
			            type:'line',
			            stack: '总量',
			            areaStyle: {normal: {}},
			            data: y4_data
			        }
			    ]
			};
		
		var myChart = echarts.init(document.getElementById('main'));
		myChart.setOption(option);
	}
	
	$(function(){
		var json = {
				"did": "${device.did}",
		    };
		
		$.ajax({
			url : "queryDeviceDetail",
			type : "POST",
			data : json,
			success : function(data){
				showChart(data);
			},
			error : function(data){
						
			}
		});
	});
</script>
</head>

<body>

<%@include file="menu.jsp"%>

<div class="mainBodyDiv">
	<div class="deviceInfoDiv">
		<h3>设备信息</h3>
		<div>
			<strong>设备编号：</strong>
			<label id="deviceId">"${device.did}"</label>
		</div>
    	
    	<div>
			<strong>责任人：</strong>
			<label id="deviceUser">"${device.name}"</label>
		</div>
		
		<div>
			<strong>版本号：</strong>
			<label id="deviceVersion">"${device.dversion}"</label>
		</div>
		
		<div>
			<strong>地址：</strong>
			<label id="deviceAddr">"${device.addr}"</label>
		</div>
	</div>
	<div class="deviceTestNumDiv">
		<h3>设备活跃度</h3>
		<div id="main" style="width: 100%;height:600px;"></div>
	</div>
</div>


</body>
</html>