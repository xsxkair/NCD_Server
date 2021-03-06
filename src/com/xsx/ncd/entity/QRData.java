package com.xsx.ncd.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Table(name="QRData")
@Entity
public class QRData {
	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private Integer id;
	private String cid;
	private String item;
	
	@JoinColumn(name="qrconst")
	@ManyToOne
	private QRConst qrconst;
	
	private Integer channel;
	private Integer calmode;				//1:T/C    2��T/T+C
	private Integer t_l;
	private Integer waitt;
	private Integer c_l;
	private java.sql.Date outdate;			//����ʱ��
	private String fend1;
	private String fend2;
	private Boolean qu1ise;
	private Boolean qu2ise;
	private Boolean qu3ise;
	private String qu1_a;
	private String qu1_b;
	private String qu1_c;
	private String qu1_d;
	private String qu2_a;
	private String qu2_b;
	private String qu2_c;
	private String qu2_d;
	private String qu3_a;
	private String qu3_b;
	private String qu3_c;
	private String qu3_d;
	private java.sql.Timestamp uptime;
	
	@JoinColumn(name="creator")
	@ManyToOne
	private Manager creator;
	
	@JoinColumn(name="checker")
	@ManyToOne
	private Manager checker;
	private java.sql.Timestamp managetime;
	
	private Boolean checkok;
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public QRConst getQrconst() {
		return qrconst;
	}

	public void setQrconst(QRConst qrconst) {
		this.qrconst = qrconst;
	}

	public Integer getChannel() {
		return channel;
	}

	public void setChannel(Integer channel) {
		this.channel = channel;
	}

	public Integer getCalmode() {
		return calmode;
	}

	public void setCalmode(Integer calmode) {
		this.calmode = calmode;
	}

	public Integer getT_l() {
		return t_l;
	}

	public void setT_l(Integer t_l) {
		this.t_l = t_l;
	}

	public Integer getWaitt() {
		return waitt;
	}

	public void setWaitt(Integer waitt) {
		this.waitt = waitt;
	}

	public Integer getC_l() {
		return c_l;
	}

	public void setC_l(Integer c_l) {
		this.c_l = c_l;
	}

	public java.sql.Date getOutdate() {
		return outdate;
	}

	public void setOutdate(java.sql.Date outdate) {
		this.outdate = outdate;
	}

	public String getFend1() {
		return fend1;
	}

	public void setFend1(String fend1) {
		this.fend1 = fend1;
	}

	public String getFend2() {
		return fend2;
	}

	public void setFend2(String fend2) {
		this.fend2 = fend2;
	}

	public Boolean getQu1ise() {
		return qu1ise;
	}

	public void setQu1ise(Boolean qu1ise) {
		this.qu1ise = qu1ise;
	}

	public Boolean getQu2ise() {
		return qu2ise;
	}

	public void setQu2ise(Boolean qu2ise) {
		this.qu2ise = qu2ise;
	}

	public Boolean getQu3ise() {
		return qu3ise;
	}

	public void setQu3ise(Boolean qu3ise) {
		this.qu3ise = qu3ise;
	}

	public String getQu1_d() {
		return qu1_d;
	}

	public void setQu1_d(String qu1_d) {
		this.qu1_d = qu1_d;
	}

	public String getQu2_d() {
		return qu2_d;
	}

	public void setQu2_d(String qu2_d) {
		this.qu2_d = qu2_d;
	}

	public String getQu3_d() {
		return qu3_d;
	}

	public void setQu3_d(String qu3_d) {
		this.qu3_d = qu3_d;
	}

	public String getQu1_a() {
		return qu1_a;
	}

	public void setQu1_a(String qu1_a) {
		this.qu1_a = qu1_a;
	}

	public String getQu1_b() {
		return qu1_b;
	}

	public void setQu1_b(String qu1_b) {
		this.qu1_b = qu1_b;
	}

	public String getQu1_c() {
		return qu1_c;
	}

	public void setQu1_c(String qu1_c) {
		this.qu1_c = qu1_c;
	}

	public String getQu2_a() {
		return qu2_a;
	}

	public void setQu2_a(String qu2_a) {
		this.qu2_a = qu2_a;
	}

	public String getQu2_b() {
		return qu2_b;
	}

	public void setQu2_b(String qu2_b) {
		this.qu2_b = qu2_b;
	}

	public String getQu2_c() {
		return qu2_c;
	}

	public void setQu2_c(String qu2_c) {
		this.qu2_c = qu2_c;
	}

	public String getQu3_a() {
		return qu3_a;
	}

	public void setQu3_a(String qu3_a) {
		this.qu3_a = qu3_a;
	}

	public String getQu3_b() {
		return qu3_b;
	}

	public void setQu3_b(String qu3_b) {
		this.qu3_b = qu3_b;
	}

	public String getQu3_c() {
		return qu3_c;
	}

	public void setQu3_c(String qu3_c) {
		this.qu3_c = qu3_c;
	}

	public java.sql.Timestamp getUptime() {
		return uptime;
	}

	public void setUptime(java.sql.Timestamp uptime) {
		this.uptime = uptime;
	}

	public Manager getCreator() {
		return creator;
	}

	public void setCreator(Manager creator) {
		this.creator = creator;
	}

	public Manager getChecker() {
		return checker;
	}

	public void setChecker(Manager checker) {
		this.checker = checker;
	}

	public java.sql.Timestamp getManagetime() {
		return managetime;
	}

	public void setManagetime(java.sql.Timestamp managetime) {
		this.managetime = managetime;
	}

	public Boolean getCheckok() {
		return checkok;
	}

	public void setCheckok(Boolean checkok) {
		this.checkok = checkok;
	}


}
