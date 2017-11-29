package com.xsx.ncd.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.xsx.ncd.entity.QRData;

public interface QRDataRepository extends JpaRepository<QRData, Integer>, JpaSpecificationExecutor<QRData>{
	
	public QRData findByCid(String cid);
}
