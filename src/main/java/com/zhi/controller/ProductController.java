package com.zhi.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.zhi.entity.PageBean;
import com.zhi.entity.Product;
import com.zhi.service.ProductService;
import com.zhi.util.ResponseUtil;
import com.zhi.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Resource
	private ProductService productService;
	
	@RequestMapping("/list")
	public void list(@RequestParam(value="page",required=false)String page,
			@RequestParam(value="rows")String rows,
			Product s_product,HttpServletResponse resp) throws Exception{
		//构建分页PageBean
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		
		//构建多条件查询Map
		Map<String,Object> map=new HashMap<String,Object>();
		
		map.put("start", pageBean.getStart());
		map.put("rows", pageBean.getRows());
		
		map.put("productName", StringUtil.formatLike(s_product.getProductName())); //调用工具类，格式化拼接带%的字符串，以便进行模糊查询
		map.put("model", StringUtil.formatLike(s_product.getModel()));
			
		JSONArray jSONArray=JSONArray.fromObject(productService.productList(map));
		JSONObject result=new JSONObject();
		result.put("rows", jSONArray);
		result.put("total", productService.productCount(map));
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/save")
	public void save(Product product,HttpServletResponse resp) throws Exception{
		JSONObject result=new JSONObject();
		if(product.getId()==null){
			boolean flag=productService.add(product)>=1? true:false; //productService返回受影响的行数
			result.put("success", flag);
		}else{
			boolean flag=productService.modify(product)>=1? true:false;
			result.put("success", flag);
		}
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/del")
	public void del(@RequestParam(value="ids",required=false)String ids,HttpServletResponse resp) throws Exception{
		int count=0;
		String[] strs=ids.split(",");
		for(int i=0;i<strs.length;i++){
			if(productService.del(Integer.parseInt(strs[i]))<1){ //删除某条数据失败时跳出
				break;
			}
			count++; //存储删除数据的条数
		}
		JSONObject result=new JSONObject();
		result.put("success", count>=1? true:false); //部分删除成功也算删除成功，返回成功删除的条数
		result.put("num", count);
		ResponseUtil.write(resp, result);
	}
	
}
