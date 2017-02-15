package com.xsx.ncd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xsx.ncd.entity.User;
import com.xsx.ncd.repository.ManagerRepository;

@Service
public class ManagerService {
	
	@Autowired
	private ManagerRepository managerRepository;
	
	public User LoginService(String account, String password){
		if(password == null)
			return managerRepository.findManagerByAccount(account);
		else
			return managerRepository.findManagerByAccountAndPassword(account, password);
	}
	
	public Boolean SaveOrUpdateUserInfo(User manager) {
		if(manager == null)
			return false;
		
		User user = managerRepository.save(manager);
		if(user == null)
			return false;
		else
			return true;
	}
}
