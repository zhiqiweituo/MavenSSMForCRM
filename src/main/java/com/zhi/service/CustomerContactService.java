package com.zhi.service;

import java.util.List;
import java.util.Map;

import com.zhi.entity.CustomerContact;

public interface CustomerContactService {

	//列表
	public List<CustomerContact> customerContactList(Map<String,Object> map);
	
	//总记录数
	public int customerContactCount(Map<String,Object> map);
	
	//添加
	public int add(CustomerContact customerContact);
	
	//修改
	public int modify(CustomerContact customerContact);
	
	//删除
	public int del(int id);
	
}
