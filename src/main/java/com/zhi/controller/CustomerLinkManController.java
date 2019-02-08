package com.zhi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.zhi.entity.CustomerLinkMan;
import com.zhi.service.CustomerLinkManService;
import com.zhi.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@RequestMapping("/customerLinkMan")
public class CustomerLinkManController {

	@Resource
	private CustomerLinkManService customerLinkManService;
	
	@RequestMapping("/list")
	public void list(@RequestParam(value="customerId",required=false)String customerId,HttpServletResponse resp) throws Exception{

		//构建条件查询Map
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("customerId", customerId);
		List<CustomerLinkMan> list=customerLinkManService.customerLinkManList(map);
		
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"customer"}); //过滤掉级联的对象
		JSONArray jSONArray=JSONArray.fromObject(list,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", jSONArray);
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/save")
	public void save(CustomerLinkMan customerLinkMan,HttpServletResponse resp)throws Exception{
		JSONObject result=new JSONObject();
		if(customerLinkMan.getId()==null){
			boolean flag=customerLinkManService.add(customerLinkMan)>=1? true:false;
			result.put("success", flag);
		}else{
			boolean flag=customerLinkManService.modify(customerLinkMan)>=1? true:false;
			result.put("success", flag);
		}
		ResponseUtil.write(resp, result);
	}
	
	
	@RequestMapping("/del")
	public void del(@RequestParam(value="ids")String ids,HttpServletResponse resp)throws Exception{
		int count=0;
		String[] strs=ids.split(",");
		for(int i=0;i<strs.length;i++){
			if(customerLinkManService.del(Integer.parseInt(strs[i]))<1){ //删除某条数据失败时跳出
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
