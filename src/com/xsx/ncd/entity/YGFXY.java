package com.xsx.ncd.entity;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Table(name="YGFXY")
@Entity
public class YGFXY {

	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private Integer id;
	
	@JoinColumn(name="Device")
	@ManyToOne
	private Device device;
	
	@JoinColumn(name="Card")
	@ManyToOne
	private Card card;

	@Column(length=10)
	private String cardnum;
	
	@Column(length=30)
	private String sampleid;
	
	private java.sql.Timestamp testtime;
	
	private Float ambienttemp;
	
	private Float cardtemp;
	
	private Integer overtime;
	
	private Integer cline;
	
	private Integer bline;
	
	private Integer tline;
	
	@Column(length=2000)
	private String series;
	
	private Float testv;
	
	@Column(columnDefinition="bit(1)")
	private Boolean t_isok;
	
	private java.sql.Timestamp uptime;
	
	@Column(nullable=false, length=32, unique=true)
	private String serialnum;										//唯一序列号，标志数据唯一性,针对荧光分析仪推荐使用批号加批内编号

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Device getDevice() {
		return device;
	}

	public void setDevice(Device device) {
		this.device = device;
	}

	public Card getCard() {
		return card;
	}

	public void setCard(Card card) {
		this.card = card;
	}

	public String getCardnum() {
		return cardnum;
	}

	public void setCardnum(String cardnum) {
		this.cardnum = cardnum;
	}

	public String getSampleid() {
		return sampleid;
	}

	public void setSampleid(String sampleid) {
		this.sampleid = sampleid;
	}

	public java.sql.Timestamp getTesttime() {
		return testtime;
	}

	public void setTesttime(java.sql.Timestamp testtime) {
		this.testtime = testtime;
	}

	public Float getAmbienttemp() {
		return ambienttemp;
	}

	public void setAmbienttemp(Float ambienttemp) {
		this.ambienttemp = ambienttemp;
	}

	public Float getCardtemp() {
		return cardtemp;
	}

	public void setCardtemp(Float cardtemp) {
		this.cardtemp = cardtemp;
	}

	public Integer getOvertime() {
		return overtime;
	}

	public void setOvertime(Integer overtime) {
		this.overtime = overtime;
	}

	public Integer getCline() {
		return cline;
	}

	public void setCline(Integer cline) {
		this.cline = cline;
	}

	public Integer getBline() {
		return bline;
	}

	public void setBline(Integer bline) {
		this.bline = bline;
	}

	public Integer getTline() {
		return tline;
	}

	public void setTline(Integer tline) {
		this.tline = tline;
	}

	public String getSeries() {
		return series;
	}

	public void setSeries(String series) {
		this.series = series;
	}

	public Float getTestv() {
		return testv;
	}

	public void setTestv(Float testv) {
		this.testv = testv;
	}

	public Boolean getT_isok() {
		return t_isok;
	}

	public void setT_isok(Boolean t_isok) {
		this.t_isok = t_isok;
	}

	public java.sql.Timestamp getUptime() {
		return uptime;
	}

	public void setUptime(java.sql.Timestamp uptime) {
		this.uptime = uptime;
	}

	public String getSerialnum() {
		return serialnum;
	}

	public void setSerialnum(String serialnum) {
		this.serialnum = serialnum;
	}	
}
