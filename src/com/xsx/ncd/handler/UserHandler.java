package com.xsx.ncd.handler;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.xsx.ncd.define.StringDefine;
import com.xsx.ncd.entity.Manager;
import com.xsx.ncd.repository.ManagerRepository;
import com.xsx.ncd.service.ManagerService;

@Controller
public class UserHandler {
	@Autowired private ManagerRepository managerRepository;

	/*
	 * µÇÂ¼
	 */
	@RequestMapping("login")
	public ModelAndView ManagerLoginHandler(Manager manager, HttpSession httpSession){
		
		Manager manager1 = managerRepository.findManagerByAccountAndPassword(manager.getAccount(), manager.getPassword());
		
		if(manager1 == null)
			return new ModelAndView(StringDefine.loginViewString);
		else{
			httpSession.setAttribute("ncd_account", manager1.getAccount());
			httpSession.setAttribute("ncd_name", manager1.getName());
			return new ModelAndView(StringDefine.homeViewString);
		}
	}
	
	/*
	 * ×¢Ïú
	 */
	@RequestMapping("execute")
    public ModelAndView execute(HttpSession session){
        session.invalidate();
        return new ModelAndView(StringDefine.loginViewString);
    }
}
