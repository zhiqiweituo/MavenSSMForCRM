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
			method: 'get'
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
	<!-- 此处可以加条件搜索 -->
</div>

<script type="text/javascript">
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