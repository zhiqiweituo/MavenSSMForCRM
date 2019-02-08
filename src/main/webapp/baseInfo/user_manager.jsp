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
	var url;

	function searchUser(){
		$('#dg').datagrid('load',{
			userName:$("#s_userName").val(),
			trueName:$("#s_trueName").val(),
			roleName:$("#s_roleName").combobox("getValue")
		});
	}

	function deleteUser(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red> "+selectedRows.length+" </font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath }/user/del.do",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","已成功删除<font color=red> "+result.num+" </font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","数据删除失败！");
					}
				},"json");
			}
		});
	}
	
	
	function openUserAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加用户信息");
		$('#dlg').window('center'); //居中显示
	}
	
	function openUserModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑用户信息");
		$("#fm").form("load",row);
	}
	
	function closeUserDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function resetValue(){
		$("#id").val("");
		$("#userName").textbox("setValue","");
		$("#password").textbox("setValue","");
		$("#trueName").textbox("setValue","");
		$("#email").textbox("setValue","");
		$("#phone").textbox("setValue","");
		$("#roleName").combobox('select', '请选择...');
	}
	
	function saveUser(){
		$("#fm").form("submit",{
			url:"${pageContext.request.contextPath }/user/save.do",
			onSubmit:function(){
				if($('#roleName').combobox("getValue")=="请选择..."){
					$.messager.alert("系统提示","请选择用户身份");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
	}
</script>
</head>
<body>

<!-- easyUI的panel -> dataGrid数据表格 -->
<div class="easyui-panel" style="width:100%;height:420px;padding:10px;">
	<!-- 使用Javascript去创建dataGrid控件 -->
	<table id="dg" fitColumns="true" pagination="true" rownumbers="true" fit="true" toolbar="#tb"></table>

	<div id="tb">
		<div>
			<a href="javascript:openUserAddDialog()" class="easyui-linkbutton" iconCls="icon-group-group-add" plain="true">添加</a>
			<a href="javascript:openUserModifyDialog()" class="easyui-linkbutton" iconCls="icon-group-group-edit" plain="true">修改</a>
			<a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-group-group-delete" plain="true">删除</a>
		</div>
		<div>
			<label style="margin-left: 5px;">用户名：</label>
			<input class="easyui-textbox" id="s_userName" name="s_userName"/>
			<label style="margin-left: 5px;">真实姓名：</label>
			<input class="easyui-textbox" id="s_trueName" name="s_trueName"/>
			<label style="margin-left: 5px;">用户身份：</label>
			<input class="easyui-combobox" id="s_roleName" name="s_roleName" size="20" 
				data-options="panelHeight:'auto',
					editable:false,
					valueField:'roleName',<!-- key,value这里都使用roleName -->
					textField:'roleName',
					url:'${pageContext.request.contextPath }/user/roles_comboList.do'"
			/>
			<a href="javascript:searchUser()" class="easyui-linkbutton" iconCls="icon-zoom-zoom" plain="true">搜索</a>
		</div>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 300px;height: 280px; padding: 10px;"
	closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table>
			<tr>
				<td>用户名：<input type="hidden" id="id" name="id"/></td>
				<td><input class="easyui-textbox" id="userName" name="userName" class="easyui-validatebox" required="true"/></td>
			</tr>
			<tr>
				<td>密码：</td>
				<td><input class="easyui-passwordbox" id="password" name="password" class="easyui-validatebox" required="true"/></td>
			</tr>
			<tr>
				<td>真实姓名：</td>
				<td><input class="easyui-textbox" id="trueName" name="trueName" class="easyui-validatebox" required="true"/></td>
			</tr>
			<tr>
				<td>邮箱：</td>
				<td><input class="easyui-textbox" id="email" name="email" class="easyui-validatebox"/></td>
			</tr>
			<tr>
				<td>手机：</td>
				<td><input class="easyui-textbox" id="phone" name="phone" class="easyui-validatebox"/></td>
			</tr>
			<tr>
				<td valign="top">用户身份：</td>
				<td>
					<input class="easyui-combobox" id="roleName" name="roleName" size="20" 
						data-options="panelHeight:'auto',
							editable:false,
							valueField:'roleName',<!-- key,value这里都使用roleName -->
							textField:'roleName',
							url:'${pageContext.request.contextPath }/user/roles_comboList.do'"
					/>
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:saveUser()" class="easyui-linkbutton" iconCls="icon-page-page-save">保存</a>
	<a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-folder-folder-wrench">关闭</a>
</div>

<script type="text/javascript">
	$('#dg').datagrid({    
	    url:'${pageContext.request.contextPath }/user/list.do',    
	    columns:[[
			{field:'cb',checkbox:true},
			{field:'id',title:'ID',hidden:true}, 
	        {field:'userName',title:'用户名',width:80,align:'left'},
	        {field:'password',title:'密码',width:80,align:'left',hidden:true},
	        {field:'trueName',title:'真实姓名',width:100,align:'left'},
	        {field:'email',title:'邮箱',width:80,align:'left'},
	        {field:'phone',title:'手机',width:80,align:'left'},
	        {field:'roleName',title:'用户身份',width:100,align:'left'}
	    ]]    
	});
</script>
</body>
</html>