package com.zhi.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.CustomerDao;
import com.zhi.entity.Customer;
import com.zhi.service.CustomerService;

@Service("customerService")
public class CustomerServiceImpl implements CustomerService {

	@Resource
	private CustomerDao customerDao;
	
	@Override
	public List<Customer> customerList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return customerDao.customerList(map);
	}

	@Override
	public int customerCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return customerDao.customerCount(map);
	}

	@Override
	public int add(Customer customer) {
		// TODO Auto-generated method stub
		return customerDao.add(customer);
	}

	@Override
	public int modify(Customer customer) {
		// TODO Auto-generated method stub
		return customerDao.modify(customer);
	}

	@Override
	public int del(int id) {
		// TODO Auto-generated method stub
		return customerDao.del(id);
	}

	@Override
	public long findCurrentMaxNo() {
		// TODO Auto-generated method stub
		return customerDao.findCurrentMaxNo();
	}

	@Override
	public Customer findById(int id) {
		// TODO Auto-generated method stub
		return customerDao.findById(id);
	}

}
