package com.zhi.service;

import java.util.List;
import java.util.Map;

import com.zhi.entity.DataDic;

public interface DataDicService {

	//数据字典名称下拉
	public List<String> findDataDicName();
	
	//列表
	public List<DataDic> dataDicList(Map<String,Object> map);
	
	//总记录数
	public int dataDicCount(Map<String,Object> map);
	
	//添加
	public int add(DataDic dataDic);
	
	//修改
	public int modify(DataDic dataDic);
	
	//删除
	public int del(int id);
	
	//根据数据字典名称返回其数据字典值
	public List<String> findDataDicValueByDataDicName(String dataDicName);
	
}
