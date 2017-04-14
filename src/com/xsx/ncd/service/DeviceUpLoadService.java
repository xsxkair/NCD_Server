package com.xsx.ncd.service;

import java.sql.Timestamp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xsx.ncd.entity.Card;
import com.xsx.ncd.entity.Device;
import com.xsx.ncd.entity.TestData;
import com.xsx.ncd.handler.ManagerHandler;
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
	
	private static Logger logger = LoggerFactory.getLogger(ManagerHandler.class);
	
	public boolean SaveOrUpDateDeviceInfo(Device device){
		
		try {
			
			Device device2 = deviceRepository.findDeviceByDid(device.getDid());
			
			//�����ڣ��½�
			if(device2 != null){
				device.setId(device2.getId());
				device.setAccount(device2.getAccount());
			}
			
			device.setTime(System.currentTimeMillis());
			
			deviceRepository.save(device);
			
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("�ϴ��豸��Ϣ����", e.toString());
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean UpDateDeviceTime(Device device){
		
		try {
			
			Device device2 = deviceRepository.findDeviceByDid(device.getDid());
			
			//�����ڣ��Ͳ������豸ʱ��
			if(device2 == null){
				logger.error("�����豸ʱ�����--�豸������"+device.getDid());
				return false;
			}

			device2.setTime(System.currentTimeMillis());
			
			deviceRepository.save(device2);
			
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			logger.error(e.toString()+device.getDid());
			return false;
		}
	}
	
	public boolean SaveOrUpDateCardInfo(Card card){
		
		try {
			
			Card card2 = cardRepository.findCardByCid(card.getCid());
			
			//���ڣ����滻
			if(card2 != null){
				card.setId(card2.getId());
			}
			
			cardRepository.save(card);
			
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("�ϴ��Լ�����Ϣ����", e.toString());
			e.printStackTrace();
			return false;
		}
		
	}
	
	public String SaveOrUpDateTestData(TestData testData){
		
		try {
			TestData testData2 = testDataRepository.findByCidAndCnum(testData.getCid(), testData.getCnum());
			
			//���ڣ����滻
			if(testData2 != null){
				testData.setId(testData2.getId());	
			}

			testData.setUptime(new Timestamp(System.currentTimeMillis()));
			testData.setResult("δ���");
			
			testDataRepository.save(testData);
			
			return "success";
		} catch (Exception e) {
			logger.error("�ϴ��������ݴ���", e.toString());
			return e.getMessage();
		}		
	}
	
	public boolean SaveOrUpDateTestSeriesData(TestData testData){
		
		try {
			
			TestData testData2 = testDataRepository.findByCidAndCnum(testData.getCid(), testData.getCnum());
			
			//���ڣ����滻
			if(testData2 == null){
				logger.error("�ϴ��������ߴ���--�������ݲ�����");
				return false;	
			}
			
			if(testData.getSerie_a() != null)
				testData2.setSerie_a(testData.getSerie_a());
			else if(testData.getSerie_b() != null)
				testData2.setSerie_b(testData.getSerie_b());
			else if(testData.getSerie_c() != null)
				testData2.setSerie_c(testData.getSerie_c());
			else {
				logger.error("�ϴ��������ߴ���--�������������е�����");
				return false;
			}
			
			testData2.setUptime(new Timestamp(System.currentTimeMillis()));
			testDataRepository.save(testData2);
			
			return true;
		} catch (Exception e) {
			logger.error("�ϴ��������ߴ���", e.toString());
			return false;
		}
		
	}
}
