package com.xsx.ncd.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.xsx.ncd.entity.TestData;

public interface TestDataRepository extends JpaRepository<TestData, Integer>{
	
	public TestData findByCidAndCnum(String cid, String cnum);
}
