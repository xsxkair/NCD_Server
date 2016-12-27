package com.xsx.ncd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xsx.ncd.entity.Card;
import com.xsx.ncd.entity.Device;
import com.xsx.ncd.entity.TestData;
import com.xsx.ncd.repository.CardRepository;
import com.xsx.ncd.repository.DeviceRepository;
import com.xsx.ncd.repository.TestDataRepository;

@Service
public class ReportService {
	
	@Autowired
	private TestDataRepository testDataRepository;
	
	@Autowired
	private DeviceRepository deviceRepository;
	
	@Autowired
	private CardRepository cardRepository;
	
	public boolean SaveOrUpdateTestData(TestData testData, String cid, String did){
		try {
			
			Card card = cardRepository.findOne(cid);
			if(card == null)
				return false;
			
			Device device = deviceRepository.findOne(did);
			if(device == null)
				return false;
			
			testData.setCard(card);
			testData.setDevice(device);
			testDataRepository.saveAndFlush(testData);
			
			return true;
			
		} catch (Exception e) {
			// TODO: handle exception
			
			return false;
		}
	}
}
