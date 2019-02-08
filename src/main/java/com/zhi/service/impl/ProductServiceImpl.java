package com.zhi.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhi.dao.ProductDao;
import com.zhi.entity.Product;
import com.zhi.service.ProductService;

@Service("productService")
public class ProductServiceImpl implements ProductService {

	@Resource
	private ProductDao productDao;
	
	@Override
	public List<Product> productList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return productDao.productList(map);
	}

	@Override
	public int productCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return productDao.productCount(map);
	}

	@Override
	public int add(Product product) {
		// TODO Auto-generated method stub
		return productDao.add(product);
	}

	@Override
	public int modify(Product product) {
		// TODO Auto-generated method stub
		return productDao.modify(product);
	}

	@Override
	public int del(int id) {
		// TODO Auto-generated method stub
		return productDao.del(id);
	}

}
