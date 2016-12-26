package com.xsx.ncd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xsx.ncd.entity.Manager;
import com.xsx.ncd.repository.ManagerRepository;

@Service
public class ManagerService {
	
	@Autowired
	private ManagerRepository managerRepository;
	
	public Manager LoginService(String account, String password){
		if(password == null)
			return managerRepository.findManagerByAccount(account);
		else
			return managerRepository.findManagerByAccountAndPassword(account, password);
	}
}
