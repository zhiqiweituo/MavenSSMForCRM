package com.zhi.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.UserDao;
import com.zhi.entity.User;
import com.zhi.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Resource
	private UserDao userDao;
	
	@Override
	public User login(User user) {
		// TODO Auto-generated method stub
		return userDao.login(user);
	}

	@Override
	public List<String> findRoles() {
		// TODO Auto-generated method stub
		return userDao.findRoles();
	}

	@Override
	public List<User> userList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userDao.userList(map);
	}

	@Override
	public int userCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userDao.userCount(map);
	}

	@Override
	public int add(User user) {
		// TODO Auto-generated method stub
		return userDao.add(user);
	}

	@Override
	public int modify(User user) {
		// TODO Auto-generated method stub
		return userDao.modify(user);
	}

	@Override
	public int del(int id) {
		// TODO Auto-generated method stub
		return userDao.del(id);
	}

	@Override
	public List<User> findCustomerManager() {
		// TODO Auto-generated method stub
		return userDao.findCustomerManager();
	}

}
