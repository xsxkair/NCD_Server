package com.xsx.ncd.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.xsx.ncd.entity.YGFXY;

public interface YGFXYRepository extends JpaRepository<YGFXY, Integer>, JpaSpecificationExecutor<YGFXY> {
	
	public YGFXY findBySerialnum(String serialnum);
	
	@Query("SELECT DATE_FORMAT(t.testtime,'%Y'), t.qrdata.item, COUNT(t.id) FROM YGFXY as t Where t.device.sold=true Group By DATE_FORMAT(t.testtime,'%Y'), t.qrdata.item")
	public List<Object[]> queryReportNumGroupByYear();
	
	@Query("SELECT DATE_FORMAT(t.testtime,'%Y'), t.qrdata.item, COUNT(t.id) FROM YGFXY as t where t.device.did=:deviceid Group By DATE_FORMAT(t.testtime,'%Y'), t.qrdata.item")
	public List<Object[]> queryReportNumByDidGroupByYear(@Param("deviceid")String did);
	
	@Query("SELECT DATE_FORMAT(t.testtime,'%Y-%m'), t.qrdata.item, COUNT(t.id) FROM YGFXY as t Where t.device.sold=true Group By DATE_FORMAT(t.testtime,'%Y-%m'), t.qrdata.item")
	public List<Object[]> queryReportNumGroupByMonth();
	
	@Query("SELECT DATE_FORMAT(t.testtime,'%Y-%m'), t.qrdata.item, COUNT(t.id) FROM YGFXY as t where t.device.did=:deviceid Group By DATE_FORMAT(t.testtime,'%Y-%m'), t.qrdata.item")
	public List<Object[]> queryReportNumByDidGroupByMonth(@Param("deviceid")String did);
	
	@Query("SELECT DATE_FORMAT(t.testtime,'%Y-%m-%d'), t.qrdata.item, COUNT(t.id) FROM YGFXY as t  Where t.device.sold=true Group By DATE_FORMAT(t.testtime,'%Y-%m-%d'), t.qrdata.item")
	public List<Object[]> queryReportNumGroupByDay();
	
	@Query("SELECT DATE_FORMAT(t.testtime,'%Y-%m-%d'), t.qrdata.item, COUNT(t.id) FROM YGFXY as t where t.device.did=:deviceid Group By DATE_FORMAT(t.testtime,'%Y-%m-%d'), t.qrdata.item")
	public List<Object[]> queryReportNumByDidGroupByDay(@Param("deviceid")String did);
}
