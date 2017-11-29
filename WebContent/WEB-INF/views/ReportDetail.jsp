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
        var t_l = ${YGFXY.tline};
        var t_v = 0;
        var b_l = ${YGFXY.bline};
        var b_v = 0;
        var c_l = ${YGFXY.cline};
        var c_v = 0;
		
		var serie_a = ${YGFXY.series};
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
                axisPointer: {
		            type: 'cross',
		            snap: true,
		            label: {
		                backgroundColor: '#6a7985'
		            }
		        }
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
        
        var testIsOk = JSON.parse("${YGFXY.t_isok}");
        if(testIsOk)
        	$("#t_result").text("Ok");
        else
        	$("#t_result").text("Error");
	});

</script>

</head>

<body>
<%@include file="menu.jsp"%>

<div id="main" style="margin-top:0px; width: 100%;height:600px;"></div>
<br>
 
<div>
	<table class="testDataInfoTable">
		<thead style="background-color: #3295D3;">
			<tr>
				<th >数据库索引</th>
				<th >测试设备</th>
				<th >设备地址</th>
				<th >试剂卡编号</th>
				<th >样本编号</th>
				<th >测试时间</th>
				<th >测试人</th>
				<th >T/C</th>
				<th >超时时间</th>
				<th >测试结果</th>
				<th >设备结论</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th >${YGFXY.id}</th>
				<th >${YGFXY.device.did}</th>
				<th >${YGFXY.device.addr}</th>
				<th >${YGFXY.qrdata.cid}</th>
				<th >${YGFXY.sampleid}</th>
				<th >${YGFXY.testtime}</th>
				<th >${YGFXY.tester}</th>
				<th >${YGFXY.t_c_v}</th>
				<th >${YGFXY.overtime}</th>
				<th >${YGFXY.testv}</th>
				<th id="t_result">${TestData.t_re}</th>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>