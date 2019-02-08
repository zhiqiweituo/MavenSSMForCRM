package com.zhi.entity;

import java.util.Date;

/**
 * 客户交往记录实体类
 * @author 稚
 *
 */
public class CustomerContact {
	private Integer id; //编号
	private Customer customer; //所属客户
	private Date contactTime; //交往时间
	private String address; //交往地点
	private String overview; //概要
	public CustomerContact() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Date getContactTime() {
		return contactTime;
	}
	public void setContactTime(Date contactTime) {
		this.contactTime = contactTime;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getOverview() {
		return overview;
	}
	public void setOverview(String overview) {
		this.overview = overview;
	}
	
}
