package com.xsx.ncd.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import com.xsx.ncd.entity.TestData;

public interface TestDataRepository extends JpaRepository<TestData, Integer>, JpaSpecificationExecutor<TestData>{
	
	public TestData findByCidAndCnum(String cid, String cnum);
	
	@Query("SELECT DATE_FORMAT(t.testtime,'%Y'), t.cid, COUNT(t.id) FROM TestData as t Group By DATE_FORMAT(t.testtime,'%Y'), t.cid")
	public List<Object[]> queryReportNumGroupByYear();
	
	@Query("SELECT DATE_FORMAT(t.testtime,'%Y-%m'), t.cid, COUNT(t.id) FROM TestData as t Group By DATE_FORMAT(t.testtime,'%Y-%m'), t.cid")
	public List<Object[]> queryReportNumGroupByMonth();
	
	@Query("SELECT DATE_FORMAT(t.testtime,'%Y-%m-%d'), t.cid, COUNT(t.id) FROM TestData as t Group By DATE_FORMAT(t.testtime,'%Y-%m-%d'), t.cid")
	public List<Object[]> queryReportNumGroupByDay();
}
