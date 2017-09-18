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

import com.xsx.ncd.entity.QRData;
import com.xsx.ncd.entity.TestData;
import com.xsx.ncd.repository.QRDataRepository;
import com.xsx.ncd.repository.TestDataRepository;

@Service
public class QRService {
	
	@Autowired QRDataRepository qrDataRepository;
	
	private DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	public DateFormat getSdf() {
		return sdf;
	}

	private <T> Specification<T> createSpecification(Class<T> classType, String lot){
		
		return new Specification<T>() {

			@Override
			public Predicate toPredicate(Root<T> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate predicateRoot = null;
						
				//项目
				if(lot != null){
					Path<String> pathItem = root.get("cid");
					predicateRoot = cb.like(pathItem, "%"+lot+"%");
				}

				return predicateRoot;
			}
		};
	}
	
	public Map<String, Object> queryQRService(String lot, Integer startIndex)
	{
		Map<String, Object> map = new HashMap<>();
		List<QRData> datas = null;
		int dataSize = 0;
		int i=0;
		QRData qrData = null;
		List<List<String>> datasJson = new ArrayList<>();
		Sort sort = new Sort(Direction.DESC, "uptime");

		//分页条件
		PageRequest pageable = new PageRequest(startIndex, 20, sort);
		
		//查询条件
		Specification<QRData> specification = createSpecification(QRData.class, lot);
		Page<QRData> page = qrDataRepository.findAll(specification, pageable);
		
		datas = page.getContent();
		dataSize = datas.size();

		for (i=0; i<dataSize; i++) {
			List<String> tempD = new ArrayList<>();
			qrData = datas.get(i);
			tempD.add(qrData.getId().toString());
			tempD.add(qrData.getCid());
			tempD.add(qrData.getItem());
			tempD.add(sdf.format(qrData.getUptime()));
			tempD.add(qrData.getCreator().getName());
			
			try {
				tempD.add(sdf.format(qrData.getManagetime()));
			} catch (Exception e) {
				// TODO: handle exception
				tempD.add("  ");
			}
			
			try {
				tempD.add(qrData.getChecker().getName());
			} catch (Exception e) {
				// TODO: handle exception
				tempD.add("  ");
			}
			
			tempD.add(qrData.getChecked().toString());
		
			datasJson.add(tempD);
		}
		
		map.put("totalPageNum", page.getTotalPages());
		map.put("currentPageIndex", startIndex);
		map.put("totalNum", page.getTotalElements());
		map.put("datas", datasJson);
		
		return map;
	}
}
