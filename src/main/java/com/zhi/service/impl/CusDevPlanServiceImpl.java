package com.zhi.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.CusDevPlanDao;
import com.zhi.entity.CusDevPlan;
import com.zhi.service.CusDevPlanService;

@Service("cusDevPlanService")
public class CusDevPlanServiceImpl implements CusDevPlanService {

	@Resource
	private CusDevPlanDao cusDevPlanDao;
	
	@Override
	public List<CusDevPlan> cusDevPlanList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return cusDevPlanDao.cusDevPlanList(map);
	}

//	@Override
//	public int cusDevPlanCount(Map<String, Object> map) {
//		// TODO Auto-generated method stub
//		return cusDevPlanDao.cusDevPlanCount(map);
//	}

	@Override
	public int add(CusDevPlan cusDevPlan) {
		// TODO Auto-generated method stub
		return cusDevPlanDao.add(cusDevPlan);
	}

	@Override
	public int modify(CusDevPlan cusDevPlan) {
		// TODO Auto-generated method stub
		return cusDevPlanDao.modify(cusDevPlan);
	}

	@Override
	public int del(int id) {
		// TODO Auto-generated method stub
		return cusDevPlanDao.del(id);
	}

}
