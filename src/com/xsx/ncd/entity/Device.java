package com.xsx.ncd.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Table(name="DEVICE")
@Entity
public class Device {

	private String did;	
	private Long time;				//�豸�ϴ�����ʱ�䣨ms����
	private String status;				//�豸״̬
	private String name;				//����
	private String age;					//����
	private String sex;					//�Ա�
	private String phone;				//��ϵ��ʽ
	private String job;					//ְ��
	private String dsc;					//��ע
	private Manager manager;

	@GeneratedValue(strategy=GenerationType.AUTO)
	@Id
	public String getDid() {
		return did;
	}

	public void setDid(String did) {
		this.did = did;
	}

	public Long getTime() {
		return time;
	}

	public void setTime(Long time) {
		this.time = time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getDsc() {
		return dsc;
	}

	public void setDsc(String dsc) {
		this.dsc = dsc;
	}
	
	@JoinColumn(name="MANAGER_ID")
	@ManyToOne
	public Manager getManager() {
		return manager;
	}

	public void setManager(Manager manager) {
		this.manager = manager;
	}
}
