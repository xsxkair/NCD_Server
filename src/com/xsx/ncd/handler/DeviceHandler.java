package com.xsx.ncd.handler;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xsx.ncd.entity.Device;
import com.xsx.ncd.repository.DeviceRepository;
import com.xsx.ncd.service.ReportService;

@Controller
public class DeviceHandler {
	@Autowired private DeviceRepository deviceRepository;
	@Autowired ReportService reportService;
	
	@ResponseBody
	@RequestMapping("queryAllDevice")
    public List<Device> queryAllUser(){

        List<Device> managers = deviceRepository.findAll();

        return managers;
    }

	@RequestMapping("queryOneDevice")
    public ModelAndView queryOneUser(String did){

        Device device = deviceRepository.findDeviceByDid(did);

        return new ModelAndView("DeviceDetail", "device", device);
    }
	
	@ResponseBody
	@RequestMapping("queryDeviceDetail")
    public Map<String, List<Long>> queryDeviceDetailHandler(String did){

        return reportService.queryReportNumService("month", did);
    }
}