package com.xsx.ncd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xsx.ncd.entity.NcdSoft;
import com.xsx.ncd.repository.NcdSoftRepository;

@Service
public class UpLoadSoftService {

	@Autowired NcdSoftRepository ncdSoftRepository;
	
	public Boolean saveOrUpdateSoftVersion(String softName, String softVersion, 
			String md5, String desc){
		NcdSoft ncdSoft = ncdSoftRepository.findNcdSoftByName(softName);
		
		Integer version = null;
		
		if(ncdSoft == null){
			ncdSoft = new NcdSoft();
			ncdSoft.setName(softName);
		}
		
		try {
			version = Integer.valueOf(softVersion);
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
		
		ncdSoft.setVersion(version);
		ncdSoft.setMD5(md5);
		ncdSoft.setDsc(desc);
		
		ncdSoftRepository.save(ncdSoft);
		
		return true;
	}
}
