package com.zhi.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.CustomerLinkManDao;
import com.zhi.entity.CustomerLinkMan;
import com.zhi.service.CustomerLinkManService;

@Service("customerLinkManService")
public class CustomerLinkManServiceImpl implements CustomerLinkManService {

	@Resource
	private CustomerLinkManDao customerLinkManDao;
	
	@Override
	public List<CustomerLinkMan> customerLinkManList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return customerLinkManDao.customerLinkManList(map);
	}

	@Override
	public int customerLinkManCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return customerLinkManDao.customerLinkManCount(map);
	}

	@Override
	public int add(CustomerLinkMan customerLinkMan) {
		// TODO Auto-generated method stub
		return customerLinkManDao.add(customerLinkMan);
	}

	@Override
	public int modify(CustomerLinkMan customerLinkMan) {
		// TODO Auto-generated method stub
		return customerLinkManDao.modify(customerLinkMan);
	}

	@Override
	public int del(int id) {
		// TODO Auto-generated method stub
		return customerLinkManDao.del(id);
	}

}
