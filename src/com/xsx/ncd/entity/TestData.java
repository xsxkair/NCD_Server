package com.xsx.ncd.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Table(name="TESTDATA")
@Entity
public class TestData {
	
	private Integer id;
	private String cnum;						//���
	private Card card;
	private Device device;
	private Manager manager;
	private String t_name;					//����������
	private String sid;						//��Ʒid -- ����ʱ����
	private java.sql.Timestamp testtime;	//����ʱ��
	private Float e_t;						//�����¶�
	private Float o_t;						//��⿨�¶�
	private Integer outt;					//��ʱʱ��
	private Integer c_l;					//c��λ��
	private Integer t_l;					//T��λ��
	private Integer b_l;					//����λ��
	private String serie_a;					//��������1
	private String serie_b;					//��������2
	private String serie_c;					//��������3
	private Float t_c_v;					//��߱�
	private Float a_p;						//У׼����
	private Float b_v;						//ԭʼ���
	private Float a_v;						//У׼����
	private String t_re;					//�豸����Ĳ��Խ��˵��
	private String result;					//������
	private String r_desc;					//����˵��
	private java.sql.Timestamp	uptime;		//�����ϴ�ʱ��
	private java.sql.Timestamp	handletime;	//���洦��ʱ��
	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCnum() {
		return cnum;
	}
	public void setCnum(String cnum) {
		this.cnum = cnum;
	}
	
	@JoinColumn(name="Card_id")
	@ManyToOne
	public Card getCard() {
		return card;
	}
	public void setCard(Card card) {
		this.card = card;
	}
	
	@JoinColumn(name="DEVICE_id")
	@ManyToOne
	public Device getDevice() {
		return device;
	}
	public void setDevice(Device device) {
		this.device = device;
	}
	
	@JoinColumn(name="MANAGER_id")
	@ManyToOne
	public Manager getManager() {
		return manager;
	}
	public void setManager(Manager manager) {
		this.manager = manager;
	}
	
	public String getT_name() {
		return t_name;
	}
	public void setT_name(String t_name) {
		this.t_name = t_name;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public java.sql.Timestamp getTesttime() {
		return testtime;
	}
	public void setTesttime(java.sql.Timestamp testtime) {
		this.testtime = testtime;
	}
	public Float getE_t() {
		return e_t;
	}
	public void setE_t(Float e_t) {
		this.e_t = e_t;
	}
	public Float getO_t() {
		return o_t;
	}
	public void setO_t(Float o_t) {
		this.o_t = o_t;
	}
	public Integer getOutt() {
		return outt;
	}
	public void setOutt(Integer outt) {
		this.outt = outt;
	}
	public Integer getC_l() {
		return c_l;
	}
	public void setC_l(Integer c_l) {
		this.c_l = c_l;
	}
	public Integer getT_l() {
		return t_l;
	}
	public void setT_l(Integer t_l) {
		this.t_l = t_l;
	}
	public Integer getB_l() {
		return b_l;
	}
	public void setB_l(Integer b_l) {
		this.b_l = b_l;
	}
	
	@Column(length=600)
	public String getSerie_a() {
		return serie_a;
	}
	public void setSerie_a(String serie_a) {
		this.serie_a = serie_a;
	}
	
	@Column(length=600)
	public String getSerie_b() {
		return serie_b;
	}
	public void setSerie_b(String serie_b) {
		this.serie_b = serie_b;
	}
	
	@Column(length=600)
	public String getSerie_c() {
		return serie_c;
	}
	public void setSerie_c(String serie_c) {
		this.serie_c = serie_c;
	}
	public Float getT_c_v() {
		return t_c_v;
	}
	public void setT_c_v(Float t_c_v) {
		this.t_c_v = t_c_v;
	}
	public Float getA_p() {
		return a_p;
	}
	public void setA_p(Float a_p) {
		this.a_p = a_p;
	}
	public Float getB_v() {
		return b_v;
	}
	public void setB_v(Float b_v) {
		this.b_v = b_v;
	}
	public Float getA_v() {
		return a_v;
	}
	public void setA_v(Float a_v) {
		this.a_v = a_v;
	}
	public String getT_re() {
		return t_re;
	}
	public void setT_re(String t_re) {
		this.t_re = t_re;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getR_desc() {
		return r_desc;
	}
	public void setR_desc(String r_desc) {
		this.r_desc = r_desc;
	}
	public java.sql.Timestamp getUptime() {
		return uptime;
	}
	public void setUptime(java.sql.Timestamp uptime) {
		this.uptime = uptime;
	}
	public java.sql.Timestamp getHandletime() {
		return handletime;
	}
	public void setHandletime(java.sql.Timestamp handletime) {
		this.handletime = handletime;
	}
	@Override
	public String toString() {
		return "TestData [id=" + id + ", cnum=" + cnum + ", card=" + card + ", device=" + device + ", manager="
				+ manager + "]";
	}
	
	
}
