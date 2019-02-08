package com.zhi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.zhi.entity.DataDic;
import com.zhi.entity.PageBean;
import com.zhi.service.DataDicService;
import com.zhi.util.ResponseUtil;
import com.zhi.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/dataDic")
public class DataDicController {

	@Resource
	private DataDicService dataDicService;
	
	@RequestMapping("/dataDicName_comboList")
	public void rolesComboList(HttpServletResponse resp) throws Exception{
		List<String> dataDicNameComboList=dataDicService.findDataDicName();

		JSONArray jSONArray=new JSONArray();
		JSONObject first=new JSONObject();
		first.put("selected", true);
		first.put("dataDicName", "请选择...");
		jSONArray.add(first);
		for(int i=0;i<dataDicNameComboList.size();i++){
			JSONObject jSONObject=new JSONObject();
			jSONObject.put("dataDicName", dataDicNameComboList.get(i));
			jSONArray.add(jSONObject);
		}
		ResponseUtil.write(resp, jSONArray);
	}
	
	@RequestMapping("/list")
	public void list(@RequestParam(value="page",required=false)String page,
			@RequestParam(value="rows")String rows,
			DataDic s_dataDic,HttpServletResponse resp) throws Exception{
		//构建分页PageBean
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		
		//构建多条件查询Map
		Map<String,Object> map=new HashMap<String,Object>();
		
		//分页PageBean也放在Map里
		map.put("start", pageBean.getStart());
		map.put("rows", pageBean.getRows());
		
		if(s_dataDic.getDataDicName()!=null){
			//下拉的第一行key,value都是"请选择..."	
			if(s_dataDic.getDataDicName().equals("请选择...")){
				map.put("dataDicName", "");
			}else{
				map.put("dataDicName", s_dataDic.getDataDicName());
			}
		}
		map.put("dataDicValue", StringUtil.formatLike(s_dataDic.getDataDicValue())); //调用工具类，格式化拼接带%的字符串，以便进行模糊查询
			
		JSONArray jSONArray=JSONArray.fromObject(dataDicService.dataDicList(map));
		JSONObject result=new JSONObject();
		result.put("rows", jSONArray);
		result.put("total", dataDicService.dataDicCount(map));
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/save")
	public void save(DataDic dataDic,HttpServletResponse resp) throws Exception{
		JSONObject result=new JSONObject();
		if(dataDic.getId()==null){
			boolean flag=dataDicService.add(dataDic)>=1? true:false; //userService返回受影响的行数
			result.put("success", flag);
		}else{
			boolean flag=dataDicService.modify(dataDic)>=1? true:false;
			result.put("success", flag);
		}
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/del")
	public void del(@RequestParam(value="ids",required=false)String ids,HttpServletResponse resp) throws Exception{
		int count=0;
		String[] strs=ids.split(",");
		for(int i=0;i<strs.length;i++){
			if(dataDicService.del(Integer.parseInt(strs[i]))<1){ //删除某条数据失败时跳出
				break;
			}
			count++; //存储删除数据的条数
		}
		JSONObject result=new JSONObject();
		result.put("success", count>=1? true:false); //部分删除成功也算删除成功，返回成功删除的条数
		result.put("num", count);
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/findDataDicValue")
	public void findDataDicValue(String dataDicName,HttpServletResponse resp) throws Exception{
		dataDicName=new String(dataDicName.getBytes("ISO-8859-1"),"utf-8"); //get请求传递的中文转换为utf-8编码格式
		List<String> list=dataDicService.findDataDicValueByDataDicName(dataDicName);
		
		JSONArray jSONArray=new JSONArray();
		JSONObject first=new JSONObject();
		first.put("selected", true);
		first.put("dataDicValue", "请选择...");
		jSONArray.add(first);
		for(int i=0;i<list.size();i++){
			JSONObject jSONObject=new JSONObject();
			jSONObject.put("dataDicValue", list.get(i));
			jSONArray.add(jSONObject);
		}
		ResponseUtil.write(resp, jSONArray);
	}
}
