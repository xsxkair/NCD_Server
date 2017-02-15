package com.xsx.ncd.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="CARDRECORD")
@Entity
public class CardRecord {
	private Integer id;
	private String cid;
	private Integer num;					//��Ŀ�����Ϊ��������Ϊ��
	private java.sql.Timestamp dotime;		//�����ʱ��
	private String account;				//������
	private String name;					//����������
	private String did;					//�����豸
	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public java.sql.Timestamp getDotime() {
		return dotime;
	}
	public void setDotime(java.sql.Timestamp dotime) {
		this.dotime = dotime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getDid() {
		return did;
	}
	public void setDid(String did) {
		this.did = did;
	}

}
