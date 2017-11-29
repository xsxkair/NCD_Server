package com.xsx.ncd.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.xsx.ncd.entity.QRConst;

public interface QRConstRepository extends JpaRepository<QRConst, Integer>{

	public QRConst findByItem(String item);
	
	@Query("SELECT item FROM QRConst")
	public List<String> queryAllItemName();
}
