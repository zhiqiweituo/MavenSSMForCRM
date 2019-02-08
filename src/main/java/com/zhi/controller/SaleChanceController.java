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

import com.zhi.entity.PageBean;
import com.zhi.entity.SaleChance;
import com.zhi.service.SaleChanceService;
import com.zhi.util.ResponseUtil;
import com.zhi.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@RequestMapping("/saleChance")
public class SaleChanceController {

	@Resource
	private SaleChanceService saleChanceService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, true)); //true:允许输入空值，false:不能
	}
	
	/**
	 * 营销机会管理，客户开发计划JSP页面都使用此方法获取列表
	 * @param page
	 * @param rows
	 * @param s_saleChance
	 * @param resp
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public void list(@RequestParam(value="page",required=false)String page,
			@RequestParam(value="rows")String rows,
			SaleChance s_saleChance,HttpServletResponse resp) throws Exception{
		//构建分页PageBean
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		
		//构建多条件查询Map
		Map<String,Object> map=new HashMap<String,Object>();
		
		map.put("start", pageBean.getStart());
		map.put("rows", pageBean.getRows());
		
		map.put("customerName", StringUtil.formatLike(s_saleChance.getCustomerName())); //调用工具类，格式化拼接带%的字符串，以便进行模糊查询
		map.put("overview", StringUtil.formatLike(s_saleChance.getOverview()));
		map.put("createMan", StringUtil.formatLike(s_saleChance.getCreateMan()));
		map.put("currentState", s_saleChance.getCurrentState());
		map.put("devResult", s_saleChance.getDevResult());
		
		//JSON日期处理
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm:ss"));
		JSONArray jSONArray=JSONArray.fromObject(saleChanceService.saleChanceList(map),jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", jSONArray);
		result.put("total", saleChanceService.saleChanceCount(map));
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/save")
	public void save(SaleChance saleChance,HttpServletResponse resp) throws Exception{
		if(StringUtil.isNotEmpty(saleChance.getAssignMan())){
			saleChance.setCurrentState(1);
		}else{
			saleChance.setCurrentState(0); //默认未分配状态
		}
		if(saleChance.getId()==null){ //添加的时候，默认是未开发状态
			saleChance.setDevResult(0);
		}
		
		JSONObject result=new JSONObject();
		if(saleChance.getId()==null){
			boolean flag=saleChanceService.add(saleChance)>=1? true:false; //productService返回受影响的行数
			result.put("success", flag);
		}else{
			boolean flag=saleChanceService.modify(saleChance)>=1? true:false;
			result.put("success", flag);
		}
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/del")
	public void del(@RequestParam(value="ids",required=false)String ids,HttpServletResponse resp) throws Exception{
		int count=0;
		String[] strs=ids.split(",");
		for(int i=0;i<strs.length;i++){
			if(saleChanceService.del(Integer.parseInt(strs[i]))<1){ //删除某条数据失败时跳出
				break;
			}
			count++; //存储删除数据的条数
		}
		JSONObject result=new JSONObject();
		result.put("success", count>=1? true:false); //部分删除成功也算删除成功，返回成功删除的条数
		result.put("num", count);
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/findById")
	public void findById(@RequestParam(value="id")String id,HttpServletResponse resp) throws Exception{
		SaleChance saleChance=saleChanceService.findById(Integer.parseInt(id));
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm:ss"));
		JSONObject jsonObject=JSONObject.fromObject(saleChance, jsonConfig);
		jsonObject.put("success", true);
		ResponseUtil.write(resp, jsonObject);
	}
	
	/**
	 * 此方法处理开发成功和开发失败，即更改SaleChance的devResults
	 * @param saleChance
	 * @param resp
	 * @throws Exception 
	 */
	@RequestMapping("/dev")
	public void dev(SaleChance saleChance,HttpServletResponse resp) throws Exception{		
		JSONObject result=new JSONObject();
		boolean flag=saleChanceService.modify(saleChance)>=1? true:false;
		result.put("success", flag);
		ResponseUtil.write(resp, result);
	}
}
