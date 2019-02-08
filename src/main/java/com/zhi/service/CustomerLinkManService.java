package com.zhi.service;

import java.util.List;
import java.util.Map;

import com.zhi.entity.CustomerLinkMan;

public interface CustomerLinkManService {

	//列表
	public List<CustomerLinkMan> customerLinkManList(Map<String,Object> map);
	
	//总记录数
	public int customerLinkManCount(Map<String,Object> map);
	
	//添加
	public int add(CustomerLinkMan customerLinkMan);
	
	//修改
	public int modify(CustomerLinkMan customerLinkMan);
	
	//删除
	public int del(int id);
	
}
