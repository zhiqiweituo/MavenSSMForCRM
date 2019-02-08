package com.zhi.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.SaleChanceDao;
import com.zhi.entity.SaleChance;
import com.zhi.service.SaleChanceService;

@Service("saleChanceService")
public class SaleChanceServiceImpl implements SaleChanceService {

	@Resource
	private SaleChanceDao saleChanceDao;
	
	@Override
	public List<SaleChance> saleChanceList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return saleChanceDao.saleChanceList(map);
	}

	@Override
	public int saleChanceCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return saleChanceDao.saleChanceCount(map);
	}

	@Override
	public int add(SaleChance saleChance) {
		// TODO Auto-generated method stub
		return saleChanceDao.add(saleChance);
	}

	@Override
	public int modify(SaleChance saleChance) {
		// TODO Auto-generated method stub
		return saleChanceDao.modify(saleChance);
	}

	@Override
	public int del(int id) {
		// TODO Auto-generated method stub
		return saleChanceDao.del(id);
	}

	@Override
	public SaleChance findById(int id) {
		// TODO Auto-generated method stub
		return saleChanceDao.findById(id);
	}

}
