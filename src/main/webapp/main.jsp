<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.1/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
<title>客户关系管理系统</title>
<script type="text/javascript">
	function toAction(text,url,iconCls){
		window.location.href=url;
	}
	function logout() {
		window.location.href="${pageContext.request.contextPath }/user/logout.do";
	}
	function openPasswordModifyDialog() {
		alert("修改密码，暂时不做此功能！");
	}
</script>
</head>
<body>
<%
Object currentAdmin=session.getAttribute("currentUser");
if(currentAdmin==null){
	response.sendRedirect("login.jsp");
}
%>
<div class="easyui-panel" title="客户关系管理系统面板" style="width:100%;height:550px;padding:10px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'west',split:true" style="width:15%;padding:10px">
			<div class="easyui-accordion" data-options="fit:true,border:true">
				<div title="营销管理"  data-options="iconCls:'icon-computer-computer'" style="padding:5px">
					<a href="javascript:addTab('营销机会管理','${pageContext.request.contextPath }/sale/sale_chance_manager.jsp','icon-computer-computer-go')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-computer-computer-go'" style="width: 150px;">营销机会管理</a>
					<a href="javascript:addTab('客户开发计划','${pageContext.request.contextPath }/sale/cus_dev_plan.jsp','icon-user-user')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-user-user'" style="width: 150px;">客户开发计划</a>
				</div>
				<div title="客户管理"  data-options="iconCls:'icon-vcard-vcard'" style="padding:5px">
					<a href="javascript:addTab('客户信息管理','${pageContext.request.contextPath }/customer/customer_manager.jsp','icon-folder-folder-user')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-folder-folder-user'" style="width: 150px;">客户信息管理</a>
					<a href="javascript:addTab('客户流失管理','${pageContext.request.contextPath }/user/user_list.jsp','icon-folder-folder-database')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-folder-folder-database'" style="width: 150px;">客户流失管理</a>
				</div>
				<div title="服务管理"  data-options="iconCls:'icon-group-group'" style="padding:5px">
					<a href="javascript:addTab('服务创建','${pageContext.request.contextPath }/user/user_list.jsp','')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-vcard-vcard-edit'" style="width: 150px;">服务创建</a>
					<a href="javascript:addTab('服务分配','${pageContext.request.contextPath }/user/user_list.jsp','')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-image-image-link'" style="width: 150px;">服务分配</a>
				</div>
				<div title="统计报表"  data-options="iconCls:'icon-table-table-save'" style="padding:5px">
					<a href="javascript:addTab('客户贡献分析','${pageContext.request.contextPath }/user/user_list.jsp','')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-vcard-vcard-edit'" style="width: 150px;">客户贡献分析</a>
					<a href="javascript:addTab('客户构成分析','${pageContext.request.contextPath }/user/user_list.jsp','')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-image-image-link'" style="width: 150px;">客户构成分析</a>
				</div>
				<div title="基础数据管理"  data-options="iconCls:'icon-folder-folder-wrench'" style="padding:5px">
					<a href="javascript:addTab('用户信息','${pageContext.request.contextPath }/baseInfo/user_manager.jsp','')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-user-user-comment'" style="width: 150px;">用户信息</a>
					<a href="javascript:addTab('产品信息','${pageContext.request.contextPath }/baseInfo/product_manager.jsp','')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-book-book-go'" style="width: 150px;">产品信息</a>
					<a href="javascript:addTab('数据字典','${pageContext.request.contextPath }/baseInfo/dataDic_manager.jsp','')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-folder-folder-database'" style="width: 150px;">数据字典</a>
				</div>
				<div title="系统管理"  data-options="iconCls:'icon-cog-cog'" style="padding:5px">
					<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-lock-lock-go'" style="width: 150px;">修改密码</a>
					<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-cog-cog-go'" style="width: 150px;">安全退出</a>
				</div>
			</div>
		</div>
		<div data-options="region:'center'" style="padding:10px">
			<div id="tab" class="easyui-tabs" style="width:100%;height:470px;">
				<div title="主页" style="padding: 20px;" data-options="iconCls:'icon-house-house-go'">
					<p>欢迎&nbsp;<span style="color:red;">[${currentUser.roleName }]</span>：<span style="color:blue;">${currentUser.trueName }</span></p>
					<p style="font-size:14px">
						此项目主要练习Spring4+SpringMVC+MyBatis3，布局一个通用性强的easyUI模板，实现稍复杂的业务。
					</p>
					<ul>
						<li>SpringMVC常用注解</li>
						<li>MyBatis3的映射及动态SQL</li>
						<li>Spring4的配置及事务</li>
						<li>easyUI界面布局</li>
						<li>数据库表对应业务理解</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function addTab(title, url, iconCls){
		if ($('#tab').tabs('exists', title)){
			$('#tab').tabs('select', title);
		} else {
			var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
			$('#tab').tabs('add',{
				title:title,
				content:content,
				closable:true,
				iconCls:iconCls
			});
		}
	}
</script>
</body>
</html>