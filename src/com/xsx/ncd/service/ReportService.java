package com.xsx.ncd.service;

import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
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

import com.xsx.ncd.define.StringDefine;
import com.xsx.ncd.entity.YGFXY;
import com.xsx.ncd.repository.YGFXYRepository;

@Service
public class ReportService {
	
	@Autowired YGFXYRepository ygfxyRepository;
	
	DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	private <T> Specification<T> createSpecification(Class<T> classType, String deviceId, String lot, 
			Date testTime, String sampleId){
		
		return new Specification<T>() {

			@Override
			public Predicate toPredicate(Root<T> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate predicateRoot = null;
				
				//����ʱ��
				if(testTime != null){
					predicateRoot = cb.equal(root.get("testtime").as(java.sql.Date.class), testTime);
				}
				
				//�豸id
				if(deviceId != null){
					Path<String> pathDevice = root.get("device").get("did");
					Predicate predicateDevice = cb.like(pathDevice, "%"+deviceId+"%");
					
					if(predicateRoot == null)
						predicateRoot = predicateDevice;
					else
						predicateRoot = cb.and(predicateDevice, predicateRoot);
				}
				
				//��Ŀ
				if(lot != null){
					Path<String> pathItem = root.get("qrdata").get("cid");
					Predicate predicateItem = cb.like(pathItem, "%"+lot+"%");
					
					if(predicateRoot == null)
						predicateRoot = predicateItem;
					else
						predicateRoot = cb.and(predicateItem, predicateRoot);
				}
				
				//��Ʒid
				if(sampleId != null){
					Path<String> pathSample = root.get("sampleid");
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
		List<YGFXY> datas = null;
		int dataSize = 0;
		int i=0;
		YGFXY testData = null;
		List<List<String>> datasJson = new ArrayList<>();
		Sort sort = new Sort(Direction.DESC, "testtime");

		//��ҳ����
		PageRequest pageable = new PageRequest(startIndex, size, sort);
		
		//��ѯ����
		Specification<YGFXY> specification = createSpecification(YGFXY.class, device, lot, time, sample);
		Page<YGFXY> page = ygfxyRepository.findAll(specification, pageable);
		
		datas = page.getContent();
		dataSize = datas.size();

		for (i=0; i<dataSize; i++) {
			List<String> tempD = new ArrayList<>();
			testData = datas.get(i);
			tempD.add(testData.getId().toString());
			tempD.add(testData.getSerialnum());
			tempD.add(sdf.format(testData.getTesttime()));
			
			if(!testData.getT_isok())
				tempD.add("Error");
			else
				tempD.add(String.format("%.3f", testData.getTestv()));

			tempD.add(testData.getDevice().getDid());
			tempD.add(testData.getSampleid());
			tempD.add(testData.getTestaddr());
			
			datasJson.add(tempD);
		}
		
		map.put("totalPageNum", page.getTotalPages());
		map.put("currentPageIndex", startIndex);
		map.put("pageSize", size);
		map.put("totalNum", page.getTotalElements());
		map.put("datas", datasJson);
		
		return map;
	}
	
	public Map<String, List<Long>> queryReportNumService(String dateFormat, String deviceId)
	{
		Map<String, List<Long>> map = new LinkedHashMap<>();
		List<Object[]> datas = null;
		
		switch (dateFormat) {
		case "year":
				if(deviceId == null)
					datas = ygfxyRepository.queryReportNumGroupByYear();
				else
					datas = ygfxyRepository.queryReportNumByDidGroupByYear(deviceId);
			break;
		
		case "month":
				if(deviceId == null)
					datas = ygfxyRepository.queryReportNumGroupByMonth();
				else
					datas = ygfxyRepository.queryReportNumByDidGroupByMonth(deviceId);
			break;
			
		case "day":
				if(deviceId == null)
					datas = ygfxyRepository.queryReportNumGroupByDay();
				else
					datas = ygfxyRepository.queryReportNumByDidGroupByDay(deviceId);
			break;
		}
		
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
			
			//����ͼ����������
			for(index=0; index<StringDefine.ItemDefine.length; index++)
			{
				if(item.equals(StringDefine.ItemDefine[index]))
					break;
			}
			
			num += itemDatas.get(index);
			itemDatas.set(index, num);
		}
		
		return map;
	}
	
	public Map<String, long[]>  queryReportNumGroupByDeviceService() {
		Map<String, long[]> map = new LinkedHashMap<>();
		
		List<Object[]> datas = ygfxyRepository.queryReportNumGroupByDevice();
		
		for (Object[] objects : datas) {
			String deviceid = (String) objects[0];
			String item = (String) objects[1];
			Long num = (Long) objects[2];

			int index = 0;
			long[] itemDatas = map.get(deviceid);

			if(itemDatas == null)
			{
				itemDatas = new long[StringDefine.ItemDefine.length];

				map.put(deviceid, itemDatas);
			}
			
			//����ͼ����������
			for(index=0; index<StringDefine.ItemDefine.length; index++)
			{
				if(item.equals(StringDefine.ItemDefine[index]))
				{
					itemDatas[index] = num;
					break;
				}
			}
		}
		
		return map;
	}
}
