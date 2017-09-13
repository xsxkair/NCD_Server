<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>纽康度</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/reportDetail.css">
<script src="scripts/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="scripts/echarts.min.js"></script>

<script type="text/javascript">
	
	$(function(){
		// 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        var xdata=[];
        var ydata=[];
        var dataLength = 1;
        var t_l = ${TestData.t_l};
        var t_v = 0;
        var b_l = ${TestData.b_l};
        var b_v = 0;
        var c_l = ${TestData.c_l};
        var c_v = 0;
		
		var serie_a = ${TestData.serie_a};
		for(i=0; i<serie_a.length; i++)
		{
			xdata.push(dataLength);
			ydata.push(serie_a[i]);
			dataLength++;
		}

		serie_a = ${TestData.serie_b};
		for(i=0; i<serie_a.length; i++)
		{
			xdata.push(dataLength);
			ydata.push(serie_a[i]);
			dataLength++;
		}
		
		serie_a = ${TestData.serie_c};
		for(i=0; i<serie_a.length; i++)
		{
			xdata.push(dataLength);
			ydata.push(serie_a[i]);
			dataLength++;
		}
		var t_v = ydata[t_l];
        var b_v = ydata[b_l];
        var c_v = ydata[c_l];
        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '测试曲线'
            },
            tooltip: {
            	formatter: '({b0}, {c0})',
                trigger: 'axis',
            },
            xAxis: {
                data: xdata
            },
            yAxis: {},
            series: [{
                name: '荧光强度(mv)',
                type: 'line',
                data: ydata,
                markPoint: {
                    data: [{
                            name: 'T:('+t_l+', '+t_v+')',
                            coord: [t_l, t_v],
                            itemStyle:{
                                normal:{
                                    color:'red'
                                }
                            }
					},{
						name: 'B:('+b_l+', '+b_v+')',
                        coord: [b_l, b_v],
                        itemStyle:{
                            normal:{
                                color:'green'
                            }
                        }
					},{
						name: 'C:('+c_l+', '+c_v+')',
                        coord: [c_l, c_v],
                        itemStyle:{
                            normal:{
                                color:'blue'
                            }
                        }
					}]
				}
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
	});

</script>

</head>

<body class="dowebok">
<div class="header">
	<div class="inner">
		<h1><a href="http://www.116.62.108.201:8080/NCD_Server/login.com/"><img src="image/logo.png" alt="logo"></a></h1>
		<ul class="nav">
			<li><a>报告查询</a></li>
			<li><a>二维码</a></li>
		</ul>
	</div>
</div>
<br><br><br><br><br>
<div id="main" style="width: 100%;height:400px;"></div>
<br>
 
<div>
	<table class="testDataInfoTable">
		<thead style="background-color: #3295D3;">
			<tr>
				<th >数据库索引</th>
				<th >测试设备</th>
				<th >试剂卡编号</th>
				<th >样本编号</th>
				<th >测试人</th>
				<th >T/C</th>
				<th >超时时间</th>
				<th >测试结果</th>
				<th >设备结论</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th >${TestData.id}</th>
				<th >${TestData.did}</th>
				<th >${TestData.cid}</th>
				<th >${TestData.sid}</th>
				<th >${TestData.t_name}</th>
				<th >${TestData.t_c_v}</th>
				<th >${TestData.outt}</th>
				<th >${TestData.a_v}</th>
				<th >${TestData.t_re}</th>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>