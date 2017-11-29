<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>纽康度</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/MainMenu.css">

<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>
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
			        text: '试剂卡用量图'
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
				"dateFormat": "month",
		    };
		
		$.ajax({
			url : "QueryReportNum",
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

<div id="main" style="width: 100%;height:600px;"></div>


</body>
</html>