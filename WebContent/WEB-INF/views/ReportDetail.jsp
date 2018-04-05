<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>纽康度</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/MainMenu.css">
<link rel="stylesheet" type="text/css" href="css/reportDetail.css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js" type="text/javascript"></script>
<script src="scripts/echarts.min.js"></script>

<script type="text/javascript">
	
	$(function(){
		// 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        var xdata=[];
        var ydata1=[];
        var ydata2=[];
        var ydata3=[];
        var ydata4=[];
        var ydata5=[];
        var dataLength = 1;
        var t_l = ${YGFXY.tline};
        var t_v = 0;
        var b_l = ${YGFXY.bline};
        var b_v = 0;
        var c_l = ${YGFXY.cline};
        var c_v = 0;
		
        var ygfxyIsOK = JSON.parse("${YGFXY.t_isok}");
		var serie_a = ${YGFXY.series};
		var t_v = serie_a[t_l];
        var b_v = serie_a[b_l];
        var c_v = serie_a[c_l];
        
		for(i=0; i<serie_a.length; i++)
		{
			xdata.push(dataLength);

			if(ygfxyIsOK)
			{
				if(i < t_l-15)
				{
					ydata1.push(serie_a[i]);
					ydata2.push('-');
					ydata3.push('-');
					ydata4.push('-');
					ydata5.push('-');
				}
				else if(i == t_l-15)
				{
					ydata1.push(serie_a[i]);
					ydata2.push(serie_a[i]);
					ydata3.push('-');
					ydata4.push('-');
					ydata5.push('-');
				}
				else if(i < t_l+15)
				{
					ydata1.push('-');
					ydata2.push(serie_a[i]);
					ydata3.push('-');
					ydata4.push('-');
					ydata5.push('-');
				}
				else if(i == t_l+15)
				{
					ydata1.push('-');
					ydata2.push(serie_a[i]);
					ydata3.push(serie_a[i]);
					ydata4.push('-');
					ydata5.push('-');
				}
				else if(i < c_l-15)
				{
					ydata1.push('-');
					ydata2.push('-');
					ydata3.push(serie_a[i]);
					ydata4.push('-');
					ydata5.push('-');
				}
				else if(i == c_l-15)
				{
					ydata1.push('-');
					ydata2.push('-');
					ydata3.push(serie_a[i]);
					ydata4.push(serie_a[i]);
					ydata5.push('-');
				}
				else if(i < c_l+15)
				{
					ydata1.push('-');
					ydata2.push('-');
					ydata3.push('-');
					ydata4.push(serie_a[i]);
					ydata5.push('-');
				}
				else if(i == c_l+15)
				{
					ydata1.push('-');
					ydata2.push('-');
					ydata3.push('-');
					ydata4.push(serie_a[i]);
					ydata5.push(serie_a[i]);
				}
				else
				{
					ydata1.push('-');
					ydata2.push('-');
					ydata3.push('-');
					ydata4.push('-');
					ydata5.push(serie_a[i]);
				}
			}
			else
			{
				ydata1.push(serie_a[i]);
				ydata2.push('-');
				ydata3.push('-');
				ydata4.push('-');
				ydata5.push('-');
			}
			dataLength++;
		}

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '测试曲线',
                x: "center"
            },
            xAxis: {
                data: xdata
            },
            yAxis: {},
            series: [
            	{
                	type: 'line',
                	data: ydata1,
                	lineStyle:{
                        normal:{
                            color: 'brown'   //连线颜色
                        }
                    }
            	},
	            {
	                type: 'line',
	                data: ydata2,
	                lineStyle:{
                        normal:{
                            color: '#3295D3'   //连线颜色
                        }
                    },
	                markPoint: {
	                    data: [{
	                            name: 'T:('+t_l+', '+t_v+')',
	                            coord: [t_l, t_v],
	                            itemStyle:{
	                                normal:{
	                                    color:'red'
	                                }
	                            }
						}]
					}
	            },
	            {
	                type: 'line',
	                data: ydata3,
	                markPoint: {
	                    data: [{
	                    	
							name: 'B:('+b_l+', '+b_v+')',
	                        coord: [b_l, b_v],
	                        itemStyle:{
	                            normal:{
	                                color:'green'
	                            }
	                        }
						}]
					},
		            lineStyle:{
	                    normal:{
	                        color: 'brown'   //连线颜色
	                    }
	                }
	            },
	            {
	                type: 'line',
	                data: ydata4,
	                lineStyle:{
                        normal:{
                            color: '#3295D3'   //连线颜色
                        }
                    },
	                markPoint: {
	                    data: [{
							name: 'C:('+c_l+', '+c_v+')',
	                        coord: [c_l, c_v],
	                        itemStyle:{
	                            normal:{
	                                color:'blue'
	                            }
	                        }
						}]
					}
	            },
	            {
	                type: 'line',
	                data: ydata5,
	                lineStyle:{
                        normal:{
                            color: 'brown'   //连线颜色
                        }
                    }
	            }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        
        var testIsOk = JSON.parse("${YGFXY.t_isok}");
        if(testIsOk)
        	$("#t_result").text("Ok");
        else
        	$("#t_result").text("Error");
        
        $("#t_c_vTh").text(${YGFXY.t_c_v});

       	$("#t_tc_vTh").text(${YGFXY.t_tc_v}.toFixed(4));
        $("#t_c_cvTh").text("("+${YGFXY.t_cv}.toFixed(4)+", "+${YGFXY.c_cv}.toFixed(4)+")");
        $("#tc_cvTh").text((${YGFXY.t_cv}+${YGFXY.c_cv}).toFixed(4)); 
        $("#c_parmTh").text(${YGFXY.cparm}/10);
	});

</script>

</head>

<body>
<%@include file="menu.jsp"%>

<div id="main" style="margin-top:0px; width: 100%;height:600px;"></div>
<br>
 
<div>
	<table class="testDataInfoTable"  border="1">
		<thead style="background-color: #3295D3;">
			<tr>
				<th >数据库索引</th>
				<th colspan="2">测试设备</th>
				<th >设备地址</th>
				<th >试剂卡编号</th>
				<th >样本编号</th>
				<th colspan="2">测试时间</th>
				<th >测试人</th>
				
			</tr>
		</thead>
		<tbody>
			<tr>
				<th >${YGFXY.id}</th>
				<th colspan="2">${YGFXY.device.did}</th>
				<th >${YGFXY.device.addr}</th>
				<th >${YGFXY.serialnum}</th>
				<th >${YGFXY.sampleid}</th>
				<th colspan="2">${YGFXY.testtime}</th>
				<th >${YGFXY.tester}</th>
			</tr>
		</tbody>
		
		<thead style="background-color: #3295D3;">
			<tr>
				<th >C线调节倍数</th>
				<th >T/C</th>
				<th >T/T+C</th>
				<th >(T,C)CV</th>
				<th >峰CV和</th>
				<th >超时时间</th>
				<th >测试结果</th>
				<th >设备结论</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th id="c_parmTh"></th>
				<th id="t_c_vTh"></th>
				<th id="t_tc_vTh"></th>
				<th id="t_c_cvTh"></th>
				<th id="tc_cvTh"></th>
				<th >${YGFXY.overtime}</th>
				<th >${YGFXY.testv}</th>
				<th id="t_result">${TestData.t_re}</th>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>