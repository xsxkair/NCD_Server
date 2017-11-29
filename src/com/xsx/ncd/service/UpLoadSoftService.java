package com.xsx.ncd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xsx.ncd.define.StringDefine;
import com.xsx.ncd.entity.Device;
import com.xsx.ncd.entity.NcdSoft;
import com.xsx.ncd.repository.DeviceRepository;
import com.xsx.ncd.repository.NcdSoftRepository;

@Service
public class UpLoadSoftService {

	@Autowired NcdSoftRepository ncdSoftRepository;
	@Autowired DeviceRepository deviceRepository;
	
	public Boolean saveOrUpdateSoftVersion(NcdSoft newNcdSoft){
		NcdSoft ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(newNcdSoft.getName(), newNcdSoft.getLang());
		
		if(ncdSoft != null){
			newNcdSoft.setId(ncdSoft.getId());
		}
		
		ncdSoftRepository.save(newNcdSoft);
		
		return true;
	}
	
	
	public String querySoftInfo(String deviceType, String did, String lang)
	{
		StringBuffer result = new StringBuffer();
		NcdSoft ncdSoft = null;

		if(lang == null)
			lang = "CH";
		
		//先通过设备id查询，如果没有则根据设备类型查询
		ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(did, lang);
		
		if(ncdSoft == null)
		{
			if(deviceType == null)
				return StringDefine.NullSoftInfoStr;
			
			ncdSoft = ncdSoftRepository.findNcdSoftByNameAndLang(deviceType, lang);

			if(ncdSoft == null)
				return StringDefine.NullSoftInfoStr;
		}
		
		result.setLength(0);
		result.append("version:");
		result.append(ncdSoft.getVersion());
		result.append("#md5:");
		result.append(ncdSoft.getMD5());
		return result.toString();
	}
}
