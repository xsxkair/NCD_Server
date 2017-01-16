package com.xsx.ncd.handler;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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
	
	@ResponseBody
	@RequestMapping("MUserInfoHandler")
	public Map<String, Object> ModifyUserInfoHandler(HttpSession httpSession, Manager user){
		
		String account = (String) httpSession.getAttribute("ncd_account");
		
		Map<String, Object> map = new HashMap<>();
		
		Manager manager = managerService.LoginService(account, null);
		
		//session不存在说明需要重新登录
		if(account == null){
			map.put("status", "relogin");
		}
		//session对应得用户不存在
		else if(manager == null){
			map.put("status", "relogin");
		}
		else{
			manager.setName(user.getName());
			manager.setAge(user.getAge());
			manager.setSex(user.getSex());
			manager.setPhone(user.getPhone());
			manager.setJob(user.getJob());
			manager.setDsc(user.getDsc());
			
			if(managerService.SaveOrUpdateUserInfo(manager))
				map.put("status", "success");
			else
				map.put("status", "error");
		}
		return map;
	}
	
	@ResponseBody
	@RequestMapping("MUserPassHandler")
	public Map<String, Object> ModifyUserPassWordHandler(HttpSession httpSession, String newpass1,
			String newpass2, String oldpass){
		
		String account = (String) httpSession.getAttribute("ncd_account");
		
		Map<String, Object> map = new HashMap<>();
		
		Manager manager = managerService.LoginService(account, null);
		
		System.out.println(newpass1 +"-"+newpass2+"-"+oldpass);
		
		//session不存在说明需要重新登录
		if(account == null){
			map.put("status", "relogin");
		}
		//session对应得用户不存在
		else if(manager == null){
			map.put("status", "relogin");
		}
		else{
			
			if(newpass1.equals(newpass2)){
				if(manager.getPassword().equals(oldpass)){
					manager.setPassword(newpass1);
					
					if(managerService.SaveOrUpdateUserInfo(manager))
						map.put("status", "success");
					else
						map.put("status", "error");
				}
				else
					map.put("status", "passerror");
			}
			else 
				map.put("status", "fail");
		}
		return map;
	}
}
