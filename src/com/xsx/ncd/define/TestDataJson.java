package com.xsx.ncd.define;

public class TestDataJson {
	
	private int index ;
	
	private String item ;
	
	private String time ;
	
	private String result ;
	
	private String did ;
	
	private String sample ;

	public TestDataJson() {

	}

	public TestDataJson(int index, String item, String time, String result, String did, String sample) {
		super();
		this.index = index;
		this.item = item;
		this.time = time;
		this.result = result;
		this.did = did;
		this.sample = sample;
	}

	public int getIndex() {
		return index;
	}

	public String getItem() {
		return item;
	}

	public String getTime() {
		return time;
	}

	public String getResult() {
		return result;
	}

	public String getDid() {
		return did;
	}

	public String getSample() {
		return sample;
	}
	
	
}
