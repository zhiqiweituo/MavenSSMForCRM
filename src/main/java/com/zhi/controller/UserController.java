package com.zhi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.zhi.entity.PageBean;
import com.zhi.entity.User;
import com.zhi.service.UserService;
import com.zhi.util.ResponseUtil;
import com.zhi.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private UserService userService;
	
	@RequestMapping("/roles_comboList")
	public void rolesComboList(HttpServletResponse resp) throws Exception{
		//System.out.println("UserController的rolesComboList方法");
		List<String> roles=userService.findRoles();

		JSONArray jSONArray=new JSONArray();
		JSONObject first=new JSONObject();
		first.put("selected", true);
		first.put("roleName", "请选择...");
		jSONArray.add(first);
		for(int i=0;i<roles.size();i++){
			JSONObject jSONObject=new JSONObject();
			jSONObject.put("roleName", roles.get(i));
			jSONArray.add(jSONObject);
		}
		ResponseUtil.write(resp, jSONArray);
	}
	
	@RequestMapping("/login")
	public void login(User user,HttpServletRequest request,HttpServletResponse resp) throws Exception{
		User currentUser=userService.login(user);
		
		JSONObject result=new JSONObject();
		if(currentUser==null){ //查不出来User对象
			result.put("flag", false);
			result.put("info", "用户或密码错误");
		}else if(!currentUser.getRoleName().equals(user.getRoleName())){ //查处的角色名与前台传入的不一致
			result.put("flag", false);
			result.put("info", "用户身份不符");
		}else{
			HttpSession session=request.getSession();
			session.setAttribute("currentUser", currentUser);
			result.put("flag", true);
		}
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		//移除session，网页重定向
		HttpSession session=request.getSession();
		session.removeAttribute("currentUser");
		return "redirect:/login.jsp";
	}
	
	@RequestMapping("/list")
	public void list(@RequestParam(value="page",required=false)String page,
			@RequestParam(value="rows")String rows,
			User s_user,HttpServletResponse resp) throws Exception{		
		//构建分页PageBean
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		
		//构建多条件查询Map
		Map<String,Object> map=new HashMap<String,Object>();
		
		map.put("start", pageBean.getStart());
		map.put("rows", pageBean.getRows());
		
		map.put("userName", StringUtil.formatLike(s_user.getUserName())); //调用工具类，格式化拼接带%的字符串，以便进行模糊查询
		map.put("trueName", StringUtil.formatLike(s_user.getTrueName()));
		if(s_user.getRoleName()!=null){
			//下拉的第一行key,value都是"请选择..."	
			if(s_user.getRoleName().equals("请选择...")){
				map.put("roleName", "");
			}else{
				map.put("roleName", s_user.getRoleName());						
			}
		}
			
		JSONArray jSONArray=JSONArray.fromObject(userService.userList(map));
		JSONObject result=new JSONObject();
		result.put("rows", jSONArray);
		result.put("total", userService.userCount(map));
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/save")
	public void save(User user,HttpServletResponse resp) throws Exception{
		JSONObject result=new JSONObject();
		if(user.getId()==null){
			boolean flag=userService.add(user)>=1? true:false; //userService返回受影响的行数
			result.put("success", flag);
		}else{
			boolean flag=userService.modify(user)>=1? true:false;
			result.put("success", flag);
		}
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/del")
	public void del(@RequestParam(value="ids",required=false)String ids,HttpServletResponse resp) throws Exception{
		int count=0;
		String[] strs=ids.split(",");
		for(int i=0;i<strs.length;i++){
			if(userService.del(Integer.parseInt(strs[i]))<1){ //删除某条数据失败时跳出
				break;
			}
			count++; //存储删除数据的条数
		}
		JSONObject result=new JSONObject();
		result.put("success", count>=1? true:false); //部分删除成功也算删除成功，返回成功删除的条数
		result.put("num", count);
		ResponseUtil.write(resp, result);
	}
	
	@RequestMapping("/assignMan_comboList")
	public void assignMan(HttpServletResponse resp) throws Exception{ //指派人是客户经理（带出编号、电话等信息）
		List<User> customerManagers=userService.findCustomerManager();

		JSONArray jSONArray=new JSONArray();
		JSONObject first=new JSONObject();
		first.put("selected", true);
		first.put("id", "");
		first.put("trueName", "请选择...");
		first.put("desc", "...");
		jSONArray.add(first);
		for(User user:customerManagers){
			JSONObject jSONObject=new JSONObject();
			jSONObject.put("id", user.getId());
			jSONObject.put("trueName", user.getTrueName());
			jSONObject.put("desc", "编号："+user.getId()+",电话："+user.getPhone());
			jSONArray.add(jSONObject);
		}
		ResponseUtil.write(resp, jSONArray);
	}
}
