package com.xsx.ncd.handler;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xsx.ncd.entity.TestData;
import com.xsx.ncd.entity.YGFXY;
import com.xsx.ncd.repository.TestDataRepository;
import com.xsx.ncd.repository.YGFXYRepository;
import com.xsx.ncd.service.ReportService;

@Controller
public class ReportHandler {
	
	@Autowired ReportService reportService;
	
	@Autowired YGFXYRepository ygfxyRepository;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	@ResponseBody
	@RequestMapping("QueryReport")
	public Map<String, Object> QueryReportHandler(String lot, String time, String device, String sample, Integer startIndex, Integer pageSize){

		if(lot != null && lot.length() == 0)
			lot = null;
		if(time != null && time.length() == 0)
			time = null;
		if(sample != null && sample.length() == 0)
			sample = null;
		if(device != null && device.length() == 0)
			device = null;
		
		Date testtime = null;
		java.sql.Date temp = null;
		try {
			testtime = sdf.parse(time);
			temp = new java.sql.Date(testtime.getTime());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			temp = null;
		}
		
		if(startIndex == null)
			startIndex = 0;
		
		if(pageSize == null)
			pageSize = 20;

		return reportService.queryReportService(lot, temp, device, sample, startIndex, pageSize);
	}

	@RequestMapping("ReportDetail")
	public ModelAndView QueryReportDetailHandler(Integer reportId){

		YGFXY testData = ygfxyRepository.findOne(reportId);

		ModelAndView modelAndView = new ModelAndView("ReportDetail", "YGFXY", testData);
		
		return modelAndView;
	}
	
	@ResponseBody
	@RequestMapping("QueryReportNum")
	public Map<String, List<Long>> QueryReportNumHandler(String dateFormat){
		if(dateFormat == null)
			dateFormat = "month";
		else if("month".equals(dateFormat) || "year".equals(dateFormat) || "day".equals(dateFormat))
			;
		else {
			dateFormat = "month";
		}
		
		
		return reportService.queryReportNumService(dateFormat, null);
	}
}
