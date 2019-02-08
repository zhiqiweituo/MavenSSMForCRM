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

<!-- panel面板 -->
<div class="easyui-panel" style="width:650px;;height:270px;padding:10px;">
	<table>
		<tr>
			<td>机会来源：</td>
			<td><input class="easyui-textbox" id="chanceSource" name="chanceSource" class="easyui-validatebox" required="true"/></td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td>客户名称：</td>
			<td><input class="easyui-textbox" id="customerName" name="customerName" class="easyui-validatebox" required="true"/></td>
		</tr>
		<tr>
			<td>成功几率(%)：</td>
			<td colspan="4">
				<input class="easyui-numberbox" id="cgjl" name="cgjl" data-options="min:1,max:100" class="easyui-validatebox" required="true" style="width:100px;"/>
				<span style="margin-left: 10px;">此处填写1~100之间的整数</span>
			</td>
		</tr>
		<tr>
			<td>概要：</td>
			<td colspan="4"><input class="easyui-textbox" id="overview" name="overview" class="easyui-validatebox" required="true" style="width:400px;"/></td>
		</tr>
		<tr>
			<td>联系人：</td>
			<td><input class="easyui-textbox" id="linkMan" name="linkMan" class="easyui-validatebox" required="true"/></td>
			<td></td>
			<td>联系电话：</td>
			<td><input class="easyui-textbox" id="linkPhone" name="linkPhone" class="easyui-validatebox" required="true"/></td>
		</tr>
		<tr>
			<td valign="top">机会描述：</td>
			<td colspan="4">
				<input class="easyui-textbox" data-options="multiline:true" id="description" name="description" style="width:400px; height:60px"/>
			</td>
		</tr>
		<tr>
			<td>创建人：</td>
			<td>
				<input class="easyui-textbox" id="createMan" name="createMan" readonly="readonly"/>
			</td>
			<td></td>
			<td>创建时间：</td>
			<td>
				<!-- 打开添加对话框时，JS填充创建时间 -->
				<input class="easyui-textbox" id="createTime" name="createTime"
       				data-options="required:true,showSeconds:false" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>指派人：</td>
			<td>
				<input class="easyui-textbox" id="assignMan" name="assignMan" readonly="readonly"/>
			</td>
			<td></td>
			<td>指派时间：</td>
			<td>
				<!-- 选择指派人时，JS填充指派时间 -->
				<input class="easyui-textbox" id="assignTime" name="assignTime" data-options="showSeconds:false" readonly="readonly">
			</td>
		</tr>
	</table>
</div>

<br>
<!-- 可编辑表格（easyUI官网代码copy） -->
<table id="dg" class="easyui-datagrid" title="开发计划项" style="width:650px;height:300px;"
		data-options="
			iconCls: 'icon-telephone-telephone-link',
			singleSelect: true,
			toolbar: '#tb',
			rownumbers:true,
			url: '${pageContext.request.contextPath }/cusDevPlan/list.do?saleChanceId=${param.saleChanceId}',
			method: 'get',
			onClickRow: onClickRow
		">
	<thead>
		<tr>
			<th data-options="field:'id',width:80" hidden="true">ID</th>
			<th data-options="field:'saleChanceId',width:80" hidden="true">销售机会</th>
			<th data-options="field:'planDate',width:80,align:'right',editor:'textbox'">计划日期</th>
			<th data-options="field:'planItem',width:200,editor:'textbox'">计划项</th>
			<th data-options="field:'executeAffect',width:200,editor:'textbox'">执行效果</th>
		</tr>
	</thead>
</table>

<div id="tb" style="height:auto">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-telephone-telephone-add',plain:true" onclick="append()">添加计划</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-telephone-telephone-delete',plain:true" onclick="removeit()">删除计划</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-driver-drive-disk',plain:true" onclick="accept()">保存计划</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">撤销</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-shape-square-go',plain:true" onclick="devSuccessed()">开发成功</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-stop',plain:true" onclick="devFailed()">终止开发</a>
</div>


<script type="text/javascript">

//格式化小时、分钟、秒有前缀0的情况
function formatZero(n){
 	if(n>=0&&n<=9){
		return "0"+n;
	}else{
		return n;
	}
}
 
// 获取当前日期时间
function getCurrentDateTime(){
	var date=new Date();
	var year=date.getFullYear();
	var month=date.getMonth()+1;
	var day=date.getDate();
	return year+"-"+formatZero(month)+"-"+formatZero(day)
}
//获取外键
function getSaleChanceId() {
	return "${param.saleChanceId}";
}
	
	//以下是easyUI官网代码
	var editIndex = undefined;
	function endEditing(){ //判断是否是正在编辑的行
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
			//构造主键id（后台数据库是自增）
			var rows=$('#dg').datagrid('getRows');
			var currentId=0; //maxId
			if(rows.length==0){ //第一行新增数据主键是1
				currentId=1; //maxId+1
			}else{ //取当前所有行，选出最大的，然后加1
				for(var i=0;i<rows.length;i++){
					if(currentId<rows[i].id){
						currentId=rows[i].id;
					}
				}
				currentId++;
			}
			
			//设置主键和计划日期
			$('#dg').datagrid('appendRow',{id:currentId,planDate:getCurrentDateTime()});
			
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
					$.ajaxSettings.async = false;
					$.post("${pageContext.request.contextPath }/cusDevPlan/save.do",{
						saleChanceId:getSaleChanceId(),
						planDate:insertedRows[i]["planDate"],
						planItem:insertedRows[i]["planItem"],
						executeAffect:insertedRows[i]["executeAffect"]
						},function(result){
						if(result.success){
							count++;
						}
					},"json");
					$.ajaxSettings.async = true;
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
				
				$.ajaxSettings.async = false;
				$.post("${pageContext.request.contextPath }/cusDevPlan/del.do",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","已成功删除<font color=red> "+result.num+" </font>条数据！");
					}else{
						$.messager.alert("系统提示","数据删除失败！");
					}
				},"json");
				$.ajaxSettings.async = true;
			}
			//取得所有updated行数据，执行CRUD
			var updatedRows=$('#dg').datagrid('getChanges', 'updated');
			if(updatedRows.length!=0){
				var count=0;
				for(var i=0;i<updatedRows.length;i++){
					//Ajax请求，更新数据
					$.ajaxSettings.async = false;
					$.post("${pageContext.request.contextPath }/cusDevPlan/save.do",{
							id:updatedRows[i]["id"],
							saleChanceId:getSaleChanceId(),
							planDate:updatedRows[i]["planDate"],
							planItem:updatedRows[i]["planItem"],
							executeAffect:updatedRows[i]["executeAffect"]
						},function(result){
						if(result.success){
							count++;
						}
					},"json");
					$.ajaxSettings.async = true;
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
	function dev(devResult){
		$.post("${pageContext.request.contextPath }/saleChance/dev.do",{id:'${param.saleChanceId}',devResult:devResult},function(result){
			if(result.success){
				$.messager.alert("系统提示","操作成功！");
			}else{
				$.messager.alert("系统提示","操作失败！");
			}
		},"json");
	}
	function devSuccessed(){ //开发成功
		dev(2); //2表示成功
	}
	function devFailed(){ //开发失败
		dev(3); //3表示失败
	}


	//Ajax从后台取数据，JS写入面板控件中
	$.post("${pageContext.request.contextPath }/saleChance/findById.do",{id:'${param.saleChanceId}'},function(result){
		if(result.success){
			$("#chanceSource").textbox("setValue",result.chanceSource);
			$("#customerName").textbox("setValue",result.customerName);
			$("#cgjl").numberbox("setValue",result.cgjl);
			$("#overview").textbox("setValue",result.overview);
			$("#linkMan").textbox("setValue",result.linkMan);
			$("#linkPhone").textbox("setValue",result.linkPhone);
			$("#description").textbox("setValue",result.description);
			$("#createMan").textbox("setValue",result.createMan);
			$("#createTime").textbox("setValue",result.createTime);
			$("#assignMan").textbox("setValue",result.assignMan);
			$("#assignTime").textbox("setValue",result.assignTime);
		}else{
			$.messager.alert("系统提示","数据异常！");
		}
	},"json");
</script>
</body>
</html>