package com.xsx.ncd.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.xsx.ncd.entity.Device;

public interface DeviceRepository extends JpaRepository<Device, Integer>{

	public Device findDeviceByDid(String did);
	
	@Query("select c from Device c where c.type=:type")
	List<Device> findByType(@Param("type") String deviceType, Sort sort);
}
