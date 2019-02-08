package com.zhi.dao;

import java.util.List;
import java.util.Map;

import com.zhi.entity.User;

public interface UserDao {

	//用户登录
	public User login(User user);
	
	//用户登录时选择身份
	public List<String> findRoles();
	
	//用户列表
	public List<User> userList(Map<String,Object> map);
	
	//用户总记录数
	public int userCount(Map<String,Object> map);
	
	//添加
	public int add(User user);
	
	//修改
	public int modify(User user);
	
	//删除
	public int del(int id);
	
	//选出所有的客户经理，构造指派人下拉ComboBox
	public List<User> findCustomerManager();
	
}
