package com.xsx.ncd.entity;

import javax.persistence.Entity;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="QRConst")
@Entity
public class QRConst {
	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private Integer id;
	private String item;
	private String item_en;								//如果有非asc字符，转换后的名字
	private Integer pointnum;
	private String lowestresult;
	private String highestresult;
	private String normalresult;
	private String measure;
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public String getItem_en() {
		return item_en;
	}

	public void setItem_en(String item_en) {
		this.item_en = item_en;
	}

	public Integer getPointnum() {
		return pointnum;
	}

	public void setPointnum(Integer pointnum) {
		this.pointnum = pointnum;
	}

	public String getLowestresult() {
		return lowestresult;
	}

	public void setLowestresult(String lowestresult) {
		this.lowestresult = lowestresult;
	}

	public String getHighestresult() {
		return highestresult;
	}

	public void setHighestresult(String highestresult) {
		this.highestresult = highestresult;
	}

	public String getNormalresult() {
		return normalresult;
	}

	public void setNormalresult(String normalresult) {
		this.normalresult = normalresult;
	}

	public String getMeasure() {
		return measure;
	}

	public void setMeasure(String measure) {
		this.measure = measure;
	}

}
