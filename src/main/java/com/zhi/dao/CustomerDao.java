package com.zhi.dao;

import java.util.List;
import java.util.Map;

import com.zhi.entity.Customer;

public interface CustomerDao {
	
	//列表
	public List<Customer> customerList(Map<String,Object> map);
	
	//总记录数
	public int customerCount(Map<String,Object> map);
	
	//添加
	public int add(Customer customer);
	
	//修改
	public int modify(Customer customer);
	
	//删除
	public int del(int id);
	
	//查最大客户编号
	public long findCurrentMaxNo();
	
	//根据主键返回对象
	public Customer findById(int id);
	
}
