package com.xsx.ncd.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.xsx.ncd.entity.TestData;

public interface TestDataRepository extends JpaRepository<TestData, Integer>, JpaSpecificationExecutor<TestData>{
	
	public TestData findByCidAndCnum(String cid, String cnum);
}
