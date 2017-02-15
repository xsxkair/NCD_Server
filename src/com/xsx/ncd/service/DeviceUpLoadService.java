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
				device.setAccount(device2.getAccount());
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
			
			//如果这一批的卡不存在，则不保存数据，且返回true，忽略这个数据
			Card card = cardRepository.findCardByCid(testData.getCid());
			if(card == null)
				return true;
			
			TestData testData2 = testDataRepository.findByCidAndCnum(testData.getCid(), testData.getCnum());
			
			Device device = deviceRepository.findDeviceByDid(testData.getDid());
			
			//存在，则替换
			if(testData2 != null){
				testData.setId(testData2.getId());	
			}

			testData.setUptime(new Timestamp(System.currentTimeMillis()));
			testData.setResult("未审核");
			
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
			
			TestData testData2 = testDataRepository.findByCidAndCnum(testData.getCid(), testData.getCnum());
			
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
