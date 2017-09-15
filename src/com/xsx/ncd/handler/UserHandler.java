package com.xsx.ncd.handler;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xsx.ncd.entity.Manager;
import com.xsx.ncd.service.ManagerService;

@Controller
public class UserHandler {
	
	@Autowired
	private ManagerService managerService;

	@RequestMapping("loginAction")
	public String ManagerLoginHandler(Manager manager, HttpSession httpSession){
		
		Manager manager1 = managerService.LoginService(manager.getAccount(), manager.getPassword());
		
		if(manager1 == null)
			return "redirect:Login";
		else{
			httpSession.setAttribute("ncd_account", manager1.getAccount());
			return "redirect:Home";
		}
	}

	@RequestMapping("checkSession")
	public String ManagerLoginBySessionHandler(HttpSession httpSession){
		
		String account = (String) httpSession.getAttribute("ncd_account");

		if(account == null)
			return "redirect:Login";
		
		Manager manager = managerService.LoginService(account, null);

		if(manager == null){
			return "redirect:Login";
		}
		else{
			return "redirect:Home";
		}
	}
}
