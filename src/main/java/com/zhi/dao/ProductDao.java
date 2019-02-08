package com.zhi.dao;

import java.util.List;
import java.util.Map;

import com.zhi.entity.Product;

public interface ProductDao {
	
	//列表
	public List<Product> productList(Map<String,Object> map);
	
	//总记录数
	public int productCount(Map<String,Object> map);
	
	//添加
	public int add(Product product);
	
	//修改
	public int modify(Product product);
	
	//删除
	public int del(int id);
	
}
