package com.xsx.ncd.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.xsx.ncd.entity.User;

public interface ManagerRepository extends JpaRepository<User, Integer>{
	
	public User findManagerByAccount(String account);
	
	public User findManagerByAccountAndPassword(String account, String password);
}
