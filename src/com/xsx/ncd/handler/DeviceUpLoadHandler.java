package com.xsx.ncd.handler;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xsx.ncd.entity.Device;
import com.xsx.ncd.entity.YGFXY;
import com.xsx.ncd.repository.DeviceRepository;
import com.xsx.ncd.repository.NcdSoftRepository;
import com.xsx.ncd.service.DeviceUpLoadService;
import com.xsx.ncd.service.UpLoadSoftService;

@Controller
public class DeviceUpLoadHandler {
	
	@Autowired private DeviceUpLoadService deviceUpLoadService;
	@Autowired UpLoadSoftService upLoadSoftService;
	@Autowired NcdSoftRepository ncdSoftRepository;
	@Autowired DeviceRepository deviceRepository;
	
	SimpleDateFormat matter1 = new SimpleDateFormat( "yyyyMMddHHmmss");
	
	/*
	 * 上传设备信息
	 */
	@ResponseBody
	@RequestMapping("up_device")
	public String upLoadDeviceInfoHandler(Device device){
		StringBuffer result = new StringBuffer();
		
		deviceUpLoadService.SaveOrUpDateDeviceInfo(device);
		
		result.append("success#time:");
		result.append(matter1.format(new Date()));
		result.append('#');
		result.append(upLoadSoftService.querySoftInfo(device.getType(), device.getDid(), device.getLang()));
		
		return result.toString();
	}
	
	/*
	 * 获取时间，同时更新设备的在线时间
	 */
	@ResponseBody
	@RequestMapping("up_dtime")
	public String upLoadDeviceTimeHandler(Device device){

		deviceUpLoadService.UpDateDeviceTime(device);
		
		return "success"+matter1.format(new Date());

	}
	
	@ResponseBody
	@RequestMapping("UpLoadYGFXY")
	public String upLoadYGFXYHandler(YGFXY ygfxy){
		
		return deviceUpLoadService.upLoadYGFXYService(ygfxy);
	}
}