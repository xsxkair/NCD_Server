package com.xsx.ncd.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.xsx.ncd.entity.Device;
import com.xsx.ncd.repository.DeviceRepository;
import com.xsx.ncd.repository.NcdSoftRepository;

@Service
public class DeviceService {

	@Autowired DeviceRepository deviceRepository;
	@Autowired NcdSoftRepository ncdSoftRepository;
	
	public List<Device> queryAllDeviceService(String deviceType, Sort sort){
		List<Device> devices = deviceRepository.findByType(deviceType, sort);
		Map<String, Integer> softMap = new HashMap<>();
		
		List<Object[]> softs = ncdSoftRepository.queryAllSoftNameAndVersion();
		
		for (Object[] objects : softs) {
			softMap.put((String)objects[0], (Integer)objects[1]);
		}

		for (Device device : devices) {
			Integer version = softMap.get(device.getDid());
			if(version == null)
				version = softMap.get(device.getType());
			
			if(version != null && device.getDversion() != null)
				device.setNewest(device.getDversion() >= version);
			else 
				device.setNewest(false);
			
			if(device.getDversion() == null)
				device.setDversion(0);
		}
		
		return devices;
	}
}
