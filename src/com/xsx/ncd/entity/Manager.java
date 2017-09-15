package com.xsx.ncd.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="Manager")
@Entity
public class Manager {
	
	private Integer id;
	
	private String account;
	
	private String password;
	
	private String name;
	
	@Column(columnDefinition="bit(1) DEFAULT FALSE")
	private Boolean createqr;
	
	@Column(columnDefinition="bit(1) DEFAULT FALSE")
	private Boolean checkqr;

	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	@Column(nullable = false)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getCreateqr() {
		return createqr;
	}

	public void setCreateqr(Boolean createqr) {
		this.createqr = createqr;
	}

	public Boolean getCheckqr() {
		return checkqr;
	}

	public void setCheckqr(Boolean checkqr) {
		this.checkqr = checkqr;
	}

}