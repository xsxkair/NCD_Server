package com.xsx.ncd.handler;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xsx.ncd.entity.QRConst;
import com.xsx.ncd.entity.QRData;
import com.xsx.ncd.entity.TestData;
import com.xsx.ncd.entity.User;
import com.xsx.ncd.repository.ManagerRepository;
import com.xsx.ncd.repository.QRConstRepository;
import com.xsx.ncd.repository.QRDataRepository;
import com.xsx.ncd.service.QRService;

@Controller
public class QRDataHandler {

	@Autowired QRConstRepository qRConstRepository;
	@Autowired QRDataRepository qRDataRepository;
	@Autowired ManagerRepository managerRepository;
	@Autowired QRService qrService;
	
	@RequestMapping("QRInfoAction")
	public ModelAndView QRInfoHandler(Integer qrId){
		QRData qrData = null;
		if(qrId != null)
			qrData = qRDataRepository.findOne(qrId);
		
		return new ModelAndView("QRInfo", "qrdata", qrData);
	}
	
	@ResponseBody
	@RequestMapping("CreateQRAction")
	public String createQR(QRData qrData, HttpSession httpSession){
		QRData tempQr = qRDataRepository.findByCid(qrData.getCid());
		String account = (String) httpSession.getAttribute("ncd_account");
		
		if(account == null)
			return "Refuse, Not Sign In !";
		
		if(tempQr != null)
			return "Refuse, Submit Duplicate !";
		
		User manager = managerRepository.findManagerByAccount(account);

		if(manager == null){
			return "Refuse, User Is Not Exist !";
		}
		
		QRConst qrConst = qRConstRepository.findByItem(qrData.getItem());
		qrData.setQrconst(qrConst);
		qrData.setUptime(new Timestamp(System.currentTimeMillis()));
		qrData.setUser(manager);
		qrData.setStatus("´ýÉóºË");
		
		qRDataRepository.save(qrData);
		
		return "Success";
	}
	
	@ResponseBody
	@RequestMapping("QueryQRAction")
	public Map<String, Object> QueryQR(String lot, String time, Integer startIndex){
		if(lot != null && lot.length() == 0)
			lot = null;
		if(time != null && time.length() == 0)
			time = null;
		
		Date testtime = null;
		java.sql.Date temp = null;
		try {
			testtime = qrService.getSdf().parse(time);
			temp = new java.sql.Date(testtime.getTime());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			temp = null;
		}
		
		if(startIndex == null)
			startIndex = 0;

		return qrService.queryQRService(lot, temp, startIndex);
	}
}
