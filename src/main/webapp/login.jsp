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
</head>
<body>

<div class="easyui-panel" title="客户关系管理系统登录" style="width:400px;padding:20px;">
	<div style="padding:10px 0 10px 60px">
    <form id="ff" method="post">
    	<table>
    		<tr>
    			<td>用户名:</td>
    			<td><input class="easyui-textbox easyui-validatebox" id="userName" name="userName" data-options="iconCls:'icon-user-user-comment',required:true"></input></td>
    		</tr>
    		<tr>
    			<td>密码:</td>
    			<td><input class="easyui-passwordbox easyui-validatebox" id="password" name="password" data-options="iconCls:'icon-lock-lock-open',required:true"></input></td>
    		</tr>
    		<tr>
    			<td>用户身份：</td>
    			<td>
	    			<input class="easyui-combobox" id="roleName"  name="roleName" size="20" 
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
    <div style="text-align:center;padding:5px">
    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" data-options="iconCls:'icon-house-house-go'">提交</a>
    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" data-options="iconCls:'icon-folder-folder-wrench'">重置</a>
    </div>
</div>
<script>
	function submitForm(){
		$.messager.progress();
		$('#ff').form('submit',{
			url:'${pageContext.request.contextPath}/user/login.do',
			onSubmit: function(){
				var isValid = $(this).form('validate');
				if($('#roleName').combobox("getValue")=="请选择..."){
					$.messager.alert("系统提示","请选择用户身份");
					$.messager.progress('close'); //如果表单是无效的则隐藏进度条
					return false;
				}
				if (!isValid){
					$.messager.progress('close'); //如果表单是无效的则隐藏进度条
				}
				return isValid; //返回false终止表单提交
			},
			success: function(r){
				$.messager.progress('close'); //如果提交成功则隐藏进度条					
				var data=eval("("+r+")");
				if(data.flag==false){
					$.messager.alert('错误信息',data.info);    
				}else{
					window.location.href="${pageContext.request.contextPath}/main.jsp";
				}
			}
		});
	}
	function clearForm(){
		$('#ff').form('clear');
	}
</script>
</body>
</html>