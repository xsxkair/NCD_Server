package com.xsx.ncd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xsx.ncd.entity.NcdSoft;
import com.xsx.ncd.repository.NcdSoftRepository;

@Service
public class UpLoadSoftService {

	@Autowired NcdSoftRepository ncdSoftRepository;
	
	public Boolean saveOrUpdateSoftVersion(NcdSoft newNcdSoft){
		NcdSoft ncdSoft = ncdSoftRepository.findNcdSoftByName(newNcdSoft.getName());
		
		if(ncdSoft != null){
			newNcdSoft.setId(ncdSoft.getId());
		}
		
		ncdSoftRepository.save(newNcdSoft);
		
		return true;
	}
	
	public NcdSoft readSoftInfo(String softName){
		
		return ncdSoftRepository.findNcdSoftByName(softName);
	}
}
