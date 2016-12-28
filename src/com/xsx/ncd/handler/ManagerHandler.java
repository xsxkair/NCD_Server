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

@Controller
public class ManagerHandler {
	
	@Autowired
	private ManagerService managerService;
	
	@ResponseBody
	@RequestMapping("login")
	public String ManagerLoginHandler(Manager manager, HttpSession httpSession){
		
		Manager manager1 = managerService.LoginService(manager.getAccount(), manager.getPassword());
		
		if(manager1 == null)
			return "error";
		else{
			httpSession.setAttribute("ncd_account", manager1.getAccount());
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
		
		if(uid != null)
			return "Home";
		else
			return "Login";
	}
	
	@RequestMapping("managerset")
	public String ManagerSetHandler(HttpSession httpSession){
		
		String uid =  (String) httpSession.getAttribute("ncd_account");
		
		if(uid != null)
			return "ManagerSet";
		else
			return "Login";
	}
}
