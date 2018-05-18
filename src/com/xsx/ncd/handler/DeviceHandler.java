package com.xsx.ncd.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xsx.ncd.entity.Device;
import com.xsx.ncd.repository.DeviceRepository;
import com.xsx.ncd.service.DeviceService;
import com.xsx.ncd.service.ReportService;

@Controller
public class DeviceHandler {
	@Autowired DeviceRepository deviceRepository;
	@Autowired ReportService reportService;
	@Autowired DeviceService deviceService;
	
	@ResponseBody
	@RequestMapping("queryAllDevice")
    public List<Device> queryAllUser(String deviceType){
		List< Order> orders=new ArrayList< Order>();
		orders.add( new Order(Direction. DESC, "time"));
		orders.add( new Order(Direction. ASC, "did"));
 
		Sort sort = new Sort(orders);

		return deviceService.queryAllDeviceService(deviceType, sort);
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
