package com.zhi.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.CustomerContactDao;
import com.zhi.entity.CustomerContact;
import com.zhi.service.CustomerContactService;

@Service("customerContactService")
public class CustomerContactServiceImpl implements CustomerContactService {

	@Resource
	private CustomerContactDao customerContactDao;
	
	@Override
	public List<CustomerContact> customerContactList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return customerContactDao.customerContactList(map);
	}

	@Override
	public int customerContactCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return customerContactDao.customerContactCount(map);
	}

	@Override
	public int add(CustomerContact customerContact) {
		// TODO Auto-generated method stub
		return customerContactDao.add(customerContact);
	}

	@Override
	public int modify(CustomerContact customerContact) {
		// TODO Auto-generated method stub
		return customerContactDao.modify(customerContact);
	}

	@Override
	public int del(int id) {
		// TODO Auto-generated method stub
		return customerContactDao.del(id);
	}

}
