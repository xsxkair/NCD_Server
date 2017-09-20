package com.xsx.ncd.handler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xsx.ncd.define.StringDefine;
import com.xsx.ncd.entity.Manager;
import com.xsx.ncd.repository.ManagerRepository;
import com.xsx.ncd.service.ManagerService;

@Controller
public class UserHandler {
	@Autowired private ManagerRepository managerRepository;

	/*
	 * ï¿½ï¿½Â¼
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
	 * ×¢ï¿½ï¿½
	 */
	@RequestMapping("execute")
    public ModelAndView execute(HttpSession session){
        session.invalidate();
        return new ModelAndView(StringDefine.loginViewString);
    }
	
	@RequestMapping("queryUser")
    public ModelAndView queryUser(HttpSession session){
        String account = (String) session.getAttribute("ncd_account");
        if(account == null)
        	return new ModelAndView(StringDefine.loginViewString);
        
		Manager manager = managerRepository.findManagerByAccount(account);

        return new ModelAndView(StringDefine.userInfoViewString, "user", manager);
    }
	
	@ResponseBody
	@RequestMapping("queryOneUser")
    public Manager queryOneUser(String account){

		Manager manager = managerRepository.findManagerByAccount(account);

        return manager;
    }
	
	@ResponseBody
	@RequestMapping("queryAllUser")
    public List<Manager> queryAllUser(){

        List<Manager> managers = managerRepository.findAll();

        return managers;
    }
	
	@ResponseBody
	@RequestMapping("saveUser")
	public Map<String, Object> saveUser(Manager manager){
		Manager tempManager = managerRepository.findManagerByAccount(manager.getAccount());
		Map<String, Object> map = new HashMap<>();
		
		if(tempManager != null)
			manager.setId(tempManager.getId());
			
		try {
			managerRepository.save(manager);
			map.put("status", StringDefine.SuccessString);
			map.put("user", manager);
		} catch (Exception e) {
				// TODO: handle exception
			map.put("status", StringDefine.FailString);
			map.put("user", null);
		}

		return map;
	}
	
	@ResponseBody
	@RequestMapping("deleteUser")
	public Map<String, Object> deleteUserHandler(String account){
		Manager tempManager = managerRepository.findManagerByAccount(account);
		Map<String, Object> map = new HashMap<>();

		try {
			if(tempManager != null)
			{
				managerRepository.delete(tempManager.getId());
				map.put("status", StringDefine.SuccessString);
			}
			else
				map.put("status", StringDefine.NotExistString);
			
			List<Manager> managers = managerRepository.findAll();
			map.put("users", managers);
		} catch (Exception e) {
				// TODO: handle exception
			map.put("status", StringDefine.FailString);
			map.put("users", null);
		}

		return map;
	}

	@ResponseBody
	@RequestMapping("modifyUser")
	public Map<String, Object> modifyUser(Manager manager, String oldPassword, String newPassword){
		Manager tempManager = managerRepository.findManagerByAccount(manager.getAccount());
		Map<String, Object> map = new HashMap<>();
		tempManager.setName(manager.getName());

		if(oldPassword == null || newPassword == null || oldPassword.length() == 0 || newPassword.length() == 0)
				;
		else{
			if(oldPassword.equals(tempManager.getPassword()))
				tempManager.setPassword(newPassword);
			else
			{
				map.put("status", "ÃÜÂë´íÎó");
				map.put("user", null);
				return map;
			}
		}
			
		try {
			managerRepository.save(tempManager);
			map.put("status", StringDefine.SuccessString);
			map.put("user", tempManager);
		} catch (Exception e) {
				// TODO: handle exception
			map.put("status", StringDefine.FailString);
			map.put("user", null);
		}

		return map;
	}
}
