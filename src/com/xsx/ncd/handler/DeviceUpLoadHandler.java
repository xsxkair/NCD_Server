package com.xsx.ncd.handler;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xsx.ncd.entity.Card;
import com.xsx.ncd.entity.Device;
import com.xsx.ncd.entity.TestData;
import com.xsx.ncd.entity.YGFXY;
import com.xsx.ncd.service.DeviceUpLoadService;

@Controller
public class DeviceUpLoadHandler {
	
	@Autowired
	private DeviceUpLoadService deviceUpLoadService;
	
	/*
	 * 上传设备信息
	 */
	@ResponseBody
	@RequestMapping("up_device")
	public String upLoadDeviceInfoHandler(Device device){
		
		boolean result = deviceUpLoadService.SaveOrUpDateDeviceInfo(device);
		
		if(result)
			return "success";
		else
			return "error";
	}
	
	/*
	 * 获取时间，同时更新设备的在线时间
	 */
	@ResponseBody
	@RequestMapping("up_dtime")
	public String upLoadDeviceTimeHandler(Device device){
		
		SimpleDateFormat matter1 = new SimpleDateFormat( "yyyyMMddHHmmss");
		
		deviceUpLoadService.UpDateDeviceTime(device);
		
		return "success"+matter1.format(new Date());

	}
	
	/*
	 * 上传试剂卡信息
	 */
	@ResponseBody
	@RequestMapping("up_card")
	public String upLoadCardHandler(Card card){
		
		boolean result = deviceUpLoadService.SaveOrUpDateCardInfo(card);
		
		if(result)
			return "success";
		else
			return "error";
	}
	
	/*
	 * 上传测试数据
	 */
	@ResponseBody
	@RequestMapping("up_testdata")
	public String upLoadTestDataHandler(TestData testData){
		
		return deviceUpLoadService.SaveOrUpDateTestData(testData);
		
/*		if(result)
			return "success";
		else
			return "error";*/
	}
	
	/*
	 * 上传测试数据
	 */
	@ResponseBody
	@RequestMapping("up_series")
	public String upLoadTestSeriesDataHandler(TestData testData){
		
		boolean result = deviceUpLoadService.SaveOrUpDateTestSeriesData(testData);
		
		if(result)
			return "success";
		else
			return "error";
	}
	
	@ResponseBody
	@RequestMapping("UpLoadYGFXY")
	public String upLoadYGFXYHandler(YGFXY ygfxy){
		
		return deviceUpLoadService.upLoadYGFXYService(ygfxy);
	}
}