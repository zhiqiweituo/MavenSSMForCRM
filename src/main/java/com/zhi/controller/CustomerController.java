package com.zhi.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.zhi.entity.Customer;
import com.zhi.entity.PageBean;
import com.zhi.service.CustomerService;
import com.zhi.util.DateUtil;
import com.zhi.util.ResponseUtil;
import com.zhi.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/customer")
public class CustomerController {

	@Resource
	private CustomerService customerService;
	
	@RequestMapping("/list")
	public void list(@RequestParam(value="page",required=false)String page,
			@RequestParam(value="rows")String rows,
			Customer s_customer,HttpServletResponse resp) throws Exception{
		//构建分页PageBean
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		
		//构建多条件查询Map
		Map<String,Object> map=new HashMap<String,Object>();
		
		map.put("start", pageBean.getStart());
		map.put("rows", pageBean.getRows());
		
		map.put("khno", StringUtil.formatLike(s_customer.getKhno())); //调用工具类，格式化拼接带%的字符串，以便进行模糊查询
		map.put("name", StringUtil.formatLike(s_customer.getName()));
			
		JSONArray jSONArray=JSONArray.fromObject(customerService.customerList(map));
		JSONObject result=new JSONObject();
		result.put("rows", jSONArray);
		result.put("total", customerService.customerCount(map));
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/save")
	public void save(Customer customer,HttpServletResponse resp)throws Exception{
		JSONObject result=new JSONObject();
		if(customer.getId()==null){
			//根据日期生成客户编号（实际业务应该加从0001起始的四位数，需另外建表）
			//此处布建表，从数据库查询最大客户编号加1，如果是新的一天，从0001开始
			String maxNumber="";
			long temp=customerService.findCurrentMaxNo();
			String ret=(temp+"").substring(0, 8);
			
			if(DateUtil.formatDate(new Date(), "yyyyMMdd").equals(ret)){
				maxNumber="CUS"+(temp+1); //最大编号+1
			}else{
				maxNumber="CUS"+Long.parseLong(DateUtil.formatDate(new Date(), "yyyyMMdd")+"0001");
			}
			String khno=maxNumber;
			customer.setKhno(khno);
			
			boolean flag=customerService.add(customer)>=1? true:false; //customerService返回受影响的行数
			result.put("success", flag);
		}else{
			boolean flag=customerService.modify(customer)>=1? true:false;
			result.put("success", flag);
		}
		ResponseUtil.write(resp, result);
	}
	
	
	@RequestMapping("/del")
	public void del(@RequestParam(value="ids")String ids,HttpServletResponse resp)throws Exception{
		int count=0;
		String[] strs=ids.split(",");
		for(int i=0;i<strs.length;i++){
			if(customerService.del(Integer.parseInt(strs[i]))<1){ //删除某条数据失败时跳出
				break;
			}
			count++; //存储删除数据的条数
		}
		JSONObject result=new JSONObject();
		result.put("success", count>=1? true:false); //部分删除成功也算删除成功，返回成功删除的条数
		result.put("num", count);
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/getCustomer")
	public void getCustomer(@RequestParam(value="id",required=false)String id,HttpServletResponse resp) throws Exception{
		JSONObject result=JSONObject.fromObject(customerService.findById(Integer.parseInt(id)));
		result.put("success", true);
		ResponseUtil.write(resp, result);
	}
}
