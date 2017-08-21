package com.xsx.ncd.handler;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xsx.ncd.entity.User;
import com.xsx.ncd.service.ManagerService;
import com.xsx.ncd.service.ReportService;

@Controller
public class ReportHandler {
	
	@Autowired
	private ReportService reportService;

	@ResponseBody
	@RequestMapping("queryReportAction")
	public Map<String, Object> QueryReportHandler(String lot, java.sql.Date time, String device, String sample){
		System.out.println(lot);
		System.out.println(time);
		System.out.println(device);
		System.out.println(sample);
		return reportService.queryReportService(lot, time, device, sample, 0, 50);
	}

}
