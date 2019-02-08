package com.zhi.service;

import java.util.List;
import java.util.Map;

import com.zhi.entity.SaleChance;

public interface SaleChanceService {
	
	//查询销售机会集合
	public List<SaleChance> saleChanceList(Map<String,Object> map);

	//获取总记录数
	public int saleChanceCount(Map<String,Object> map);
	
	//添加
	public int add(SaleChance saleChance);
	
	//修改
	public int modify(SaleChance saleChance);
	
	//删除
	public int del(int id);
	
	//根据主键返回SaleChance对象
	public SaleChance findById(int id);
	
}
