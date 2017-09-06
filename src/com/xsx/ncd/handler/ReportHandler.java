package com.xsx.ncd.handler;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xsx.ncd.entity.TestData;
import com.xsx.ncd.repository.TestDataRepository;
import com.xsx.ncd.service.ReportService;

@Controller
public class ReportHandler {
	
	@Autowired ReportService reportService;
	
	@Autowired TestDataRepository testDataRepository;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	@ResponseBody
	@RequestMapping("queryReportAction")
	public Map<String, Object> QueryReportHandler(String lot, String time, String device, String sample, Integer startIndex, Integer pageSize){

		if(lot.length() == 0)
			lot = null;
		if(time.length() == 0)
			time = null;
		if(sample.length() == 0)
			sample = null;
		if(device.length() == 0)
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

		return reportService.queryReportService(lot, temp, device, sample, startIndex, pageSize);
	}

	@RequestMapping("queryReportDetailAction")
	public ModelAndView QueryReportDetailHandler(Integer reportId){

		TestData testData = testDataRepository.findOne(reportId);
		if((testData.getSerie_a() == null) || (testData.getSerie_a().length() == 0))
			testData.setSerie_a("[]");
		if((testData.getSerie_b() == null) || (testData.getSerie_a().length() == 0))
			testData.setSerie_b("[]");
		if((testData.getSerie_c() == null) || (testData.getSerie_a().length() == 0))
			testData.setSerie_c("[]");
		ModelAndView modelAndView = new ModelAndView("ReportDetail", "TestData", testData);
		
		return modelAndView;
	}
}
