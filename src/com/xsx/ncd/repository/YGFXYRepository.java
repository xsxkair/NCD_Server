package com.xsx.ncd.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.xsx.ncd.entity.YGFXY;

public interface YGFXYRepository extends JpaRepository<YGFXY, Integer> {
	
	public YGFXY findBySerialnum(String serialnum);
}
