<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>纽康度</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/MainMenu.css">

<script src="https://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>
<script src="scripts/echarts.min.js"></script>

<script type="text/javascript">
	
	function showChart(data){
		var x_data = [];
		var y1_data = [];
		var y2_data = [];
		var y3_data = [];
		var y4_data = [];
		var legendData = ['NT-proBNP','CK-MB','cTnI','Myo'];
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
			        text: '试剂卡用量图',
	                x: "center"
			    },
			    tooltip : {
			        trigger: 'axis',
			        axisPointer: {
			            type: 'shadow'
			        }
			    },
			    legend: {
			    	data: legendData,
			    	x: '60%',
			    },
			    grid: {
			        left: '3%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },
			    yAxis : [
			        {
			            type : 'category',
			            boundaryGap : false,
			            data : x_data
			        }
			    ],
			    xAxis : [
			        {
			            type : 'value'
			        }
			    ],
			    series : [
			        {
			            name: legendData[0],
			            type:'bar',
			            stack: '总量',
			            itemStyle : { normal: {label : {show: false, position: 'insideRight'}}},
			            data: y1_data
			        },
			        {
			            name: legendData[1],
			            type:'bar',
			            stack: '总量',
			            itemStyle : { normal: {label : {show: false, position: 'insideRight'}}},
			            data: y2_data
			        },
			        {
			            name: legendData[2],
			            type:'bar',
			            stack: '总量',
			            itemStyle : { normal: {label : {show: false, position: 'insideRight'}}},
			            data: y3_data
			        },
			        {
			            name: legendData[3],
			            type:'bar',
			            stack: '总量',
			            itemStyle : { normal: {label : {show: false, position: 'insideRight'}}},
			            data: y4_data
			        }
			    ]
			};
		
		var myChart = echarts.init(document.getElementById('main'));
		myChart.setOption(option);
		myChart.on('click', function (params) {
		    // 控制台打印数据的名称
		    console.log(params.name);
		});
	}
	
	$(function(){

		$.ajax({
			url : "QueryReportNumGroupByDevice",
			type : "POST",
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

<div id="main" style="width: 100%;height:1000px;"></div>


</body>
</html>