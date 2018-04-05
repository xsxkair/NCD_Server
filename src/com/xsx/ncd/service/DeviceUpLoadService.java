package com.xsx.ncd.service;

import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xsx.ncd.entity.Device;
import com.xsx.ncd.entity.QRData;
import com.xsx.ncd.entity.TestData;
import com.xsx.ncd.entity.YGFXY;
import com.xsx.ncd.repository.DeviceRepository;
import com.xsx.ncd.repository.QRDataRepository;
import com.xsx.ncd.repository.TestDataRepository;
import com.xsx.ncd.repository.YGFXYRepository;

@Service
public class DeviceUpLoadService {
	
	@Autowired	private TestDataRepository testDataRepository;
	
	@Autowired	private DeviceRepository deviceRepository;

	@Autowired QRDataRepository qrDataRepository;
	
	@Autowired YGFXYRepository ygfxyRepository;
	
	public boolean SaveOrUpDateDeviceInfo(Device device){
		
		try {
			
			Device device2 = deviceRepository.findDeviceByDid(device.getDid());
			
			if(device2 != null){
				device.setId(device2.getId());
				device.setAccount(device2.getAccount());
				device.setSold(device2.getSold());
				device.setType(device2.getType());
			}
			else
				device.setSold(false);
			
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

			return false;
		}
	}
	
	public String SaveOrUpDateTestData(TestData testData){
		
		try {
			TestData testData2 = testDataRepository.findByCidAndCnum(testData.getCid(), testData.getCnum());
			
			//存在，则替换
			if(testData2 != null){
				testData.setId(testData2.getId());	
			}

			testData.setUptime(new Timestamp(System.currentTimeMillis()));
			testData.setResult("未审核");
			
			testDataRepository.save(testData);

			return "success";
		} catch (Exception e) {
			return e.getMessage();
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
			return false;
		}
	}
	
	public String upLoadYGFXYService(YGFXY ygfxy){
		
		try {
			YGFXY ygfxy2 = ygfxyRepository.findBySerialnum(ygfxy.getSerialnum());
			
			QRData card = qrDataRepository.findByCid(ygfxy.getQrdata().getCid());
			ygfxy.setQrdata(card);
			
			Device device = deviceRepository.findDeviceByDid(ygfxy.getDevice().getDid());
			ygfxy.setDevice(device);
			
			//存在，则替换
			if(ygfxy2 != null){
				ygfxy.setId(ygfxy2.getId());	
			}

			if(ygfxy.getCparm() == null)
				ygfxy.setCparm(0);
			ygfxy.setUptime(new Timestamp(System.currentTimeMillis()));
			
			if(ygfxy.getTestaddr() == null)
				ygfxy.setTestaddr(device.getAddr());
			
			ygfxyRepository.save(ygfxy);
			
			device.setTime(System.currentTimeMillis());
			deviceRepository.save(device);
			
			return "success";
		} catch (Exception e) {

			return "Fail";
		}		
	}
}
