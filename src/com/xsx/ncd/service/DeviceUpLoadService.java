package com.xsx.ncd.service;

import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xsx.ncd.entity.Card;
import com.xsx.ncd.entity.Device;
import com.xsx.ncd.entity.TestData;
import com.xsx.ncd.repository.CardRepository;
import com.xsx.ncd.repository.DeviceRepository;
import com.xsx.ncd.repository.TestDataRepository;

@Service
public class DeviceUpLoadService {
	
	@Autowired
	private TestDataRepository testDataRepository;
	
	@Autowired
	private DeviceRepository deviceRepository;
	
	@Autowired
	private CardRepository cardRepository;
	
	public boolean SaveOrUpDateDeviceInfo(Device device){
		
		try {
			
			Device device2 = deviceRepository.findDeviceByDid(device.getDid());
			
			//不存在，新建
			if(device2 != null){
				device.setId(device2.getId());
				device.setManager(device2.getManager());
			}
			
			device.setTime(System.currentTimeMillis());
			
			deviceRepository.save(device);
			
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean UpDateDeviceTime(Device device){
		
		try {
			
			Device device2 = deviceRepository.findDeviceByDid(device.getDid());
			
			//不存在，就不更新设备时间
			if(device2 == null){
				return false;
			}

			device2.setTime(System.currentTimeMillis());
			
			deviceRepository.save(device2);
			
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean SaveOrUpDateCardInfo(Card card){
		
		try {
			
			Card card2 = cardRepository.findCardByCid(card.getCid());
			
			//存在，则替换
			if(card2 != null){
				card.setId(card2.getId());
			}
			
			cardRepository.save(card);
			
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
		
	}
	
	public boolean SaveOrUpDateTestData(TestData testData){
		
		try {
			
			TestData testData2 = testDataRepository.queryByCardCidAndCnum(testData.getCard().getCid(), testData.getCnum());
			
			Card card = cardRepository.findCardByCid(testData.getCard().getCid());
			
			Device device = deviceRepository.findDeviceByDid(testData.getDevice().getDid());
			
			//存在，则替换
			if(testData2 != null){
				testData.setId(testData2.getId());	
			}
			
			
			testData.setCard(card);
			testData.setDevice(device);
			testData.setUptime(new Timestamp(System.currentTimeMillis()));
			
			testDataRepository.save(testData);
			
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
		
	}
	
	public boolean SaveOrUpDateTestSeriesData(TestData testData){
		
		try {
			
			TestData testData2 = testDataRepository.queryByCardCidAndCnum(testData.getCard().getCid(), testData.getCnum());
			
			//存在，则替换
			if(testData2 == null){
				return false;	
			}
			
			if(testData.getSerie_a() != null)
				testData2.setSerie_a(testData.getSerie_a());
			else if(testData.getSerie_b() != null)
				testData2.setSerie_b(testData.getSerie_b());
			else if(testData.getSerie_c() != null)
				testData2.setSerie_c(testData.getSerie_c());
			else {
				return false;
			}
			
			testData2.setUptime(new Timestamp(System.currentTimeMillis()));
			testDataRepository.save(testData2);
			
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
		
	}
}
