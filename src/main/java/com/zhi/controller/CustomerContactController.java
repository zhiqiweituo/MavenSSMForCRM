package com.zhi.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.zhi.entity.CustomerContact;
import com.zhi.service.CustomerContactService;
import com.zhi.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@RequestMapping("/customerContact")
public class CustomerContactController {

	@Resource
	private CustomerContactService customerContactService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, true)); //true:允许输入空值，false:不能
	}
	
	@RequestMapping("/list")
	public void list(@RequestParam(value="customerId",required=false)String customerId,HttpServletResponse resp) throws Exception{

		//构建条件查询Map
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("customerId", customerId);
		List<CustomerContact> list=customerContactService.customerContactList(map);
		
		JsonConfig jsonConfig=new JsonConfig();
		
		//过滤掉级联的对象
		jsonConfig.setExcludes(new String[]{"customer"});
		
		//处理时间
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		
		JSONArray jSONArray=JSONArray.fromObject(list,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", jSONArray);
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/save")
	public void save(CustomerContact customerContact,HttpServletResponse resp)throws Exception{
		JSONObject result=new JSONObject();
		if(customerContact.getId()==null){
			boolean flag=customerContactService.add(customerContact)>=1? true:false;
			result.put("success", flag);
		}else{
			boolean flag=customerContactService.modify(customerContact)>=1? true:false;
			result.put("success", flag);
		}
		ResponseUtil.write(resp, result);
	}
	
	
	@RequestMapping("/del")
	public void del(@RequestParam(value="ids")String ids,HttpServletResponse resp)throws Exception{
		int count=0;
		String[] strs=ids.split(",");
		for(int i=0;i<strs.length;i++){
			if(customerContactService.del(Integer.parseInt(strs[i]))<1){ //删除某条数据失败时跳出
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
