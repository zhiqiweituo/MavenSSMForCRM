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

<!-- easyUI的panel -> 一个客户信息对应多个客户联系人信息 -->
<div class="easyui-panel" style="width:700px;height:80px;padding:10px;">
<table>
	<tr>
		<td>客户编号：</td>
		<td><input class="easyui-textbox" id="khno" name="khno" data-options="editable:false"/></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td>客户名称：</td>
		<td><input class="easyui-textbox" id="name" name="name" data-options="editable:false"/></td>
	</tr>
</table>
</div>
<br>

<!-- easyUI的panel -> dataGrid可编辑数据表格 -->
<div class="easyui-panel" style="width:700px;height:300px;padding:10px;">
	<table id="dg" class="easyui-datagrid" title="客户联系人"
			data-options="
				iconCls: 'icon-telephone-telephone-link',
				singleSelect: true,
				toolbar: '#tb',
				url: '${pageContext.request.contextPath }/customerLinkMan/list.do?customerId=${param.customerId }',
				method: 'get',
				onClickRow: onClickRow
			">
		<thead>
			<tr>
				<th data-options="field:'id',width:80" hidden="true">编号</th>
				<th data-options="field:'linkName',width:80,align:'right',editor:'textbox'">姓名</th>
				<th data-options="field:'sex',width:60,align:'right',
					editor:
						{
							type:'combobox',
							options:{
								panelHeight:'auto',
								valueField: 'label',
								textField: 'value',
								data: [{
									label: '男',
									value: '男'
								},{
									label: '女',
									value: '女'
								}],
								required:true
							}
						}
					">性别</th>
				<th data-options="field:'job',width:80,editor:'textbox'">职位</th>
				<th data-options="field:'officePhone',width:110,align:'center',editor:'textbox'">办公电话</th>
				<th data-options="field:'cellphone',width:110,align:'center',editor:'textbox'">手机</th>
			</tr>
		</thead>
	</table>
 
	<div id="tb" style="height:auto">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-telephone-telephone-add',plain:true" onclick="append()">Append</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-telephone-telephone-delete',plain:true" onclick="removeit()">Remove</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-driver-drive-disk',plain:true" onclick="accept()">Accept</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">Reject</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">GetChanges</a>
	</div>
</div>

<script type="text/javascript">
	//Ajax加载客户信息
	$.post("${pageContext.request.contextPath }/customer/getCustomer.do",{id:'${param.customerId }'},function(result){
		if(result.success){
			$("#khno").textbox("setValue",result.khno);
			$("#name").textbox("setValue",result.name);
		}else{
			$.messager.alert("系统提示","数据异常！");
		}
	},"json");
	
	//可编辑表格展示客户的多个联系人
	var editIndex = undefined;
	function endEditing(){
		if (editIndex == undefined){return true}
		if ($('#dg').datagrid('validateRow', editIndex)){
			$('#dg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow(index){
		if (editIndex != index){
			if (endEditing()){
				$('#dg').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				editIndex = index;
			} else {
				$('#dg').datagrid('selectRow', editIndex);
			}
		}
	}
	function append(){
		if (endEditing()){
			//设置相关字段的初始值
			$('#dg').datagrid('appendRow',{sex:'男'});
			
			editIndex = $('#dg').datagrid('getRows').length-1;
			$('#dg').datagrid('selectRow', editIndex)
					.datagrid('beginEdit', editIndex);
		}
	}
	function removeit(){
		if (editIndex == undefined){return}
		$('#dg').datagrid('cancelEdit', editIndex)
				.datagrid('deleteRow', editIndex);
		editIndex = undefined;
	}
	function accept(){
		if (endEditing()){
			//数据库保存
			//从上一次的提交获取改变的所有行（可以使用的值有：inserted,deleted,updated）
			
			//取得所有inserted行数据，执行CRUD
			var insertedRows=$('#dg').datagrid('getChanges', 'inserted');
			if(insertedRows.length!=0){
				var count=0;
				for(var i=0;i<insertedRows.length;i++){
					$.ajaxSettings.async=false;
					$.post("${pageContext.request.contextPath }/customerLinkMan/save.do",{
						'customer.id':'${param.customerId }',
						linkName:insertedRows[i]["linkName"],
						sex:insertedRows[i]["sex"],
						job:insertedRows[i]["job"],
						officePhone:insertedRows[i]["officePhone"],
						cellphone:insertedRows[i]["cellphone"]
						},function(result){
						if(result.success){
							count++;
						}
					},"json");
					$.ajaxSettings.async=true;
				}
				
				if(count==0){
					$.messager.alert("系统提示","数据添加失败！");
				}else{
					$.messager.alert("系统提示","已成功添加<font color=red> "+count+" </font>条数据！");					
				}
			}
			//取得所有deleted行数据，执行CRUD
			var deletedRows=$('#dg').datagrid('getChanges', 'deleted');
			if(deletedRows.length!=0){
				var strIds=[];
				for(var i=0;i<deletedRows.length;i++){
					strIds.push(deletedRows[i].id);
				}
				var ids=strIds.join(",");
				
				$.ajaxSettings.async=false;
				$.post("${pageContext.request.contextPath }/customerLinkMan/del.do",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","已成功删除<font color=red> "+result.num+" </font>条数据！");
					}else{
						$.messager.alert("系统提示","数据删除失败！");
					}
				},"json");
				$.ajaxSettings.async=true;
			}
			//取得所有updated行数据，执行CRUD
			var updatedRows=$('#dg').datagrid('getChanges', 'updated');
			if(updatedRows.length!=0){
				var count=0;
				for(var i=0;i<updatedRows.length;i++){				
					//Ajax请求，更新数据
					$.ajaxSettings.async=false;
					$.post("${pageContext.request.contextPath }/customerLinkMan/save.do",{
							id:updatedRows[i]["id"],
							linkName:updatedRows[i]["linkName"],
							sex:updatedRows[i]["sex"],
							job:updatedRows[i]["job"],
							officePhone:updatedRows[i]["officePhone"],
							cellphone:updatedRows[i]["cellphone"]
						},function(result){
						if(result.success){
							count++;
						}
					},"json");
					$.ajaxSettings.async=true;
				}
				
				if(count==0){
					$.messager.alert("系统提示","数据修改失败！");
				}else{
					$.messager.alert("系统提示","已成功修改<font color=red> "+count+" </font>条数据！");					
				}
			}
			
			//界面保存
			$('#dg').datagrid('acceptChanges');
		}
	}
	function reject(){
		$('#dg').datagrid('rejectChanges');
		editIndex = undefined;
	}
	function getChanges(){
		var rows = $('#dg').datagrid('getChanges');
		$.messager.alert("操作提示",rows.length+' 行发生了改变!');
	}
</script>
</body>
</html>