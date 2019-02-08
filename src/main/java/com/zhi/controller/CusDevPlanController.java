package com.zhi.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.zhi.entity.CusDevPlan;
import com.zhi.entity.SaleChance;
import com.zhi.service.CusDevPlanService;
import com.zhi.service.SaleChanceService;
import com.zhi.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@RequestMapping("/cusDevPlan")
public class CusDevPlanController {
	
	@Resource
	private CusDevPlanService cusDevPlanService;
	
	@Resource
	private SaleChanceService saleChanceService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, true)); //true:允许输入空值，false:不能为空值
	}
	 
	@RequestMapping("/list")
	public void list(@RequestParam(value="saleChanceId",required=false)String saleChanceId,
			HttpServletResponse resp)throws Exception{
		
		//构建多条件查询Map
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("saleChanceId", saleChanceId);
		
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"saleChance"});
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONArray jSONArray=JSONArray.fromObject(cusDevPlanService.cusDevPlanList(map),jsonConfig);
		
		JSONObject result=new JSONObject();
		result.put("rows", jSONArray);
		
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/save")
	public void save(CusDevPlan cusDevPlan,HttpServletResponse resp)throws Exception{
		JSONObject result=new JSONObject();
		if(cusDevPlan.getId()==null){
			//开发计划项添加的时候,修改销售机会状态
			SaleChance saleChance=new SaleChance();
			saleChance.setId(cusDevPlan.getSaleChanceId()); //主键是销售计划项的外键
			saleChance.setDevResult(1); //状态修改成"开发中"
			saleChanceService.modify(saleChance);
			
			//添加操作
			boolean flag=cusDevPlanService.add(cusDevPlan)>=1? true:false; //service返回受影响的行数
			result.put("success", flag);
		}else{
			boolean flag=cusDevPlanService.modify(cusDevPlan)>=1? true:false;
			result.put("success", flag);
		}
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/del")
	public void del(@RequestParam(value="ids",required=false)String ids,HttpServletResponse resp)throws Exception{		
		int count=0;
		String[] strs=ids.split(",");
		for(int i=0;i<strs.length;i++){
			if(cusDevPlanService.del(Integer.parseInt(strs[i]))<1){ //删除某条数据失败时跳出
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
