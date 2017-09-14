package com.xsx.ncd.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.xsx.ncd.entity.Card;
import com.xsx.ncd.entity.QRConst;

public interface QRConstRepository extends JpaRepository<QRConst, Integer>{

	public QRConst findByItem(String item);
}
