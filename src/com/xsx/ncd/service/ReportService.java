package com.xsx.ncd.service;

import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.xsx.ncd.entity.TestData;
import com.xsx.ncd.repository.TestDataRepository;

@Service
public class ReportService {
	
	@Autowired TestDataRepository testDataRepository;
	
	DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	private <T> Specification<T> createSpecification(Class<T> classType, String deviceId, String lot, 
			Date testTime, String sampleId){
		
		return new Specification<T>() {

			@Override
			public Predicate toPredicate(Root<T> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate predicateRoot = null;
				
				//过滤时间
				if(testTime != null){
					predicateRoot = cb.equal(root.get("testtime").as(java.sql.Date.class), testTime);
				}
				
				//设备id
				if(deviceId != null){
					Path<String> pathDevice = root.get("did");
					Predicate predicateDevice = cb.like(pathDevice, "%"+deviceId+"%");
					
					if(predicateRoot == null)
						predicateRoot = predicateDevice;
					else
						predicateRoot = cb.and(predicateDevice, predicateRoot);
				}
				
				//项目
				if(lot != null){
					Path<String> pathItem = root.get("cid");
					Predicate predicateItem = cb.like(pathItem, "%"+lot+"%");
					
					if(predicateRoot == null)
						predicateRoot = predicateItem;
					else
						predicateRoot = cb.and(predicateItem, predicateRoot);
				}
				
				//样品id
				if(sampleId != null){
					Path<String> pathSample = root.get("sid");
					Predicate predicateSample = cb.like(pathSample, "%"+sampleId+"%");
					
					if(predicateRoot == null)
						predicateRoot = predicateSample;
					else
						predicateRoot = cb.and(predicateSample, predicateRoot);
				}

				return predicateRoot;
			}
		};
	}
	
	public Map<String, Object> queryReportService(String lot, java.sql.Date time, String device, String sample, int startIndex, int size)
	{
		Map<String, Object> map = new HashMap<>();
		List<TestData> datas = null;
		int dataSize = 0;
		int i=0;
		TestData testData = null;
		List<List<String>> datasJson = new ArrayList<>();
		Sort sort = new Sort(Direction.DESC, "testtime");

		//分页条件
		PageRequest pageable = new PageRequest(startIndex, size, sort);
		
		//查询条件
		Specification<TestData> specification = createSpecification(TestData.class, device, lot, time, sample);
		Page<TestData> page = testDataRepository.findAll(specification, pageable);
		
		datas = page.getContent();
		dataSize = datas.size();

		for (i=0; i<dataSize; i++) {
			List<String> tempD = new ArrayList<>();
			testData = datas.get(i);
			tempD.add(testData.getId().toString());
			tempD.add(String.format("%s-%s", testData.getCid(), testData.getCnum()));
			tempD.add(sdf.format(testData.getTesttime()));
			
			if("Error".equals(testData.getT_re()))
				tempD.add("Error");
			else
				tempD.add(String.format("%.3f", testData.getA_v()));
			
			tempD.add(testData.getDid());
			tempD.add(testData.getSid());
			
			datasJson.add(tempD);
		}
		
		map.put("totalPageNum", page.getTotalPages());
		map.put("currentPageIndex", startIndex);
		map.put("pageSize", size);
		map.put("totalNum", page.getTotalElements());
		map.put("datas", datasJson);
		
		return map;
	}
	
	public Map<String, List<Long>> queryReportNumService(String dateFormat)
	{
		Map<String, List<Long>> map = new HashMap<>();
		List<Object[]> datas = null;
		
		if("year".equals(dateFormat))
			datas = testDataRepository.queryReportNumGroupByYear();
		else if("month".equals(dateFormat))
			datas = testDataRepository.queryReportNumGroupByMonth();
		else if("day".equals(dateFormat))
			datas = testDataRepository.queryReportNumGroupByDay();
		
		for (Object[] objects : datas) {
			String dateTime = (String) objects[0];
			String item = (String) objects[1];
			Long num = (Long) objects[2];
			int index = 0;
			List<Long> itemDatas = map.get(dateTime);
			
			if(itemDatas == null)
			{
				itemDatas = new ArrayList<>();
				itemDatas.add(0L);
				itemDatas.add(0L);
				itemDatas.add(0L);
				itemDatas.add(0L);
				
				map.put((String) objects[0], itemDatas);
			}
			
			if(item.startsWith("IB"))
				index = 0;//item = "NT-proBNP";
			else if(item.startsWith("IT"))
				index = 1;//item = "cTnI";
			else if(item.startsWith("IM"))
				index = 2;//item = "Myo";
			else if(item.startsWith("IC"))
				index = 3;//item = "CK-MB";
			
			num += itemDatas.get(index);
			itemDatas.set(index, num);
		}
		
		return map;
	}
}
