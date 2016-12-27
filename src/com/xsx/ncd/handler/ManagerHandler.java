package com.xsx.ncd.handler;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xsx.ncd.entity.Manager;
import com.xsx.ncd.entity.TestData;
import com.xsx.ncd.service.ManagerService;
import com.xsx.ncd.service.ReportService;

@Controller
public class ManagerHandler {
	
	@Autowired
	private ManagerService managerService;
	
	@Autowired
	private ReportService reportService;
	
	@ResponseBody
	@RequestMapping("login")
	public String ManagerLoginHandler(String account, String password, HttpSession httpSession){
		
		Manager manager = managerService.LoginService(account, password);
		
		if(manager == null)
			return "error";
		else{
			httpSession.setAttribute("ncd_account", manager.getAccount());
			return "success";
		}
	}
	
	@ResponseBody
	@RequestMapping("loginsession")
	public Map<String, Object> ManagerLoginBySessionHandler(HttpSession httpSession){
		
		String account = (String) httpSession.getAttribute("ncd_account");
		
		Map<String, Object> map = new HashMap<>();
		
		Manager manager = managerService.LoginService(account, null);
		
		if(manager == null){
			map.put("status", "error");
			map.put("manager", manager);
		}
		else{
			map.put("status", "success");
			map.put("manager", manager);
		}
		return map;
	}
	
	@RequestMapping("Home")
	public String HomeHandler(HttpSession httpSession){
		
		String uid =  (String) httpSession.getAttribute("ncd_account");
		
		TestData testData = new TestData();
		testData.setCid("cid1-1");
		
		reportService.SaveOrUpdateTestData(testData, "cid1", "did1");
		System.out.println(testData.getCard().getCid());
		
		if(uid != null)
			return "Home";
		else
			return "Login";
	}
}
