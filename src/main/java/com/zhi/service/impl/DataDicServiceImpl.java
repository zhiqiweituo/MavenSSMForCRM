package com.zhi.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.DataDicDao;
import com.zhi.entity.DataDic;
import com.zhi.service.DataDicService;

@Service("dataDicService")
public class DataDicServiceImpl implements DataDicService {

	@Resource
	private DataDicDao dataDicDao;
	
	@Override
	public List<String> findDataDicName() {
		// TODO Auto-generated method stub
		return dataDicDao.findDataDicName();
	}
	
	@Override
	public List<DataDic> dataDicList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dataDicDao.dataDicList(map);
	}

	@Override
	public int dataDicCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dataDicDao.dataDicCount(map);
	}

	@Override
	public int add(DataDic dataDic) {
		// TODO Auto-generated method stub
		return dataDicDao.add(dataDic);
	}

	@Override
	public int modify(DataDic dataDic) {
		// TODO Auto-generated method stub
		return dataDicDao.modify(dataDic);
	}

	@Override
	public int del(int id) {
		// TODO Auto-generated method stub
		return dataDicDao.del(id);
	}

	@Override
	public List<String> findDataDicValueByDataDicName(String dataDicName) {
		// TODO Auto-generated method stub
		return dataDicDao.findDataDicValueByDataDicName(dataDicName);
	}

}
