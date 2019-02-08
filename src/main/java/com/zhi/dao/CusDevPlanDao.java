package com.zhi.dao;

import java.util.List;
import java.util.Map;

import com.zhi.entity.CusDevPlan;

public interface CusDevPlanDao {

	//列表
	public List<CusDevPlan> cusDevPlanList(Map<String,Object> map);
	
	//总记录数
	//public int cusDevPlanCount(Map<String,Object> map);
	
	//添加
	public int add(CusDevPlan cusDevPlan);
	
	//修改
	public int modify(CusDevPlan cusDevPlan);
	
	//删除
	public int del(int id);
	
}
