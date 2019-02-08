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
		var hours=date.getHours();
		var minutes=date.getMinutes();
		var seconds=date.getSeconds();
		return year+"-"+formatZero(month)+"-"+formatZero(day)+" "+formatZero(hours)+":"+formatZero(minutes)+":"+formatZero(seconds);
	}
		
	function searchSaleChance(){
		$('#dg').datagrid('load',{
			customerName:$("#s_customerName").val(),
			overview:$("#s_overview").val(),
			createMan:$("#s_createMan").val(),
			currentState:$("#s_currentState").combobox("getValue")
		});
	}

	function deleteSaleChance(){
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
				$.post("${pageContext.request.contextPath }/saleChance/del.do",{ids:ids},function(result){
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
	
	$(function(){
		$("#assignMan").combobox({
			onSelect:function(record){
				if(record.id!=''){
					$("#assignTime").textbox('setValue', getCurrentDateTime());
				}else{
					$("#assignTime").textbox('setValue', "");
				}
			}
		}); 
	});
	
	function openSaleChanceAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加销售机会信息");
		$('#dlg').window('center'); //居中显示
		$("#createMan").textbox('setValue', '${currentUser.trueName}'); //JS设置创建人为当前用户
		$('#createTime').textbox('setValue', getCurrentDateTime());	//JS设置创建时间为当前时间
	}
	
	function openSaleChanceModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑销售机会信息");
		$("#fm").form("load",row);
	}
	
	function closeSaleChanceDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function resetValue(){
		$("#id").val("");
		$("#chanceSource").textbox("setValue","");
		$("#customerName").textbox("setValue","");
		$("#cgjl").numberbox("setValue","");
		$("#overview").textbox("setValue","");
		$("#linkMan").textbox("setValue","");
		$("#linkPhone").textbox("setValue","");
		$("#description").textbox("setValue","");
		$("#createMan").textbox("setValue","");
		$("#createTime").textbox("setValue","");
		$("#assignMan").combobox("setValue","");
		$("#assignTime").textbox("setValue","");
	}
	
	function saveSaleChance(){
		$("#fm").form("submit",{
			url:"${pageContext.request.contextPath }/saleChance/save.do",
			onSubmit:function(){
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
			<a href="javascript:openSaleChanceAddDialog()" class="easyui-linkbutton" iconCls="icon-computer-computer-add" plain="true">添加</a>
			<a href="javascript:openSaleChanceModifyDialog()" class="easyui-linkbutton" iconCls="icon-computer-computer-edit" plain="true">修改</a>
			<a href="javascript:deleteSaleChance()" class="easyui-linkbutton" iconCls="icon-computer-computer-delete" plain="true">删除</a>
		</div>
		<div>
			<label style="margin-left: 5px;">客户名称：</label>
			<input class="easyui-textbox" id="s_customerName" name="s_customerName"/>
			<label style="margin-left: 5px;">概要：</label>
			<input class="easyui-textbox" id="s_overview" name="s_overview"/>
			<label style="margin-left: 5px;">创建人：</label>
			<input class="easyui-textbox" id="s_createMan" name="s_createMan"/>
			<label style="margin-left: 5px;">分配状态：</label>
			<input class="easyui-combobox" id="s_currentState" name="s_currentState" size="20"
				data-options="panelHeight:'auto',
					editable:false,
					valueField: 'label',
					textField: 'value',
					data: [{
						label: '',
						value: '请选择...'
					},{
						label: '0',
						value: '未分配'
					},{
						label: '1',
						value: ' 已分配'
					}]"
			/>
			<a href="javascript:searchSaleChance()" class="easyui-linkbutton" iconCls="icon-zoom-zoom" plain="true">搜索</a>
		</div>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 550px;height: 380px; padding: 10px;"
	closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table>
			<tr>
				<td>机会来源：<input type="hidden" id="id" name="id"/></td>
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
					<input class="easyui-combobox" id="assignMan" name="assignMan" size="20"
						data-options="panelHeight:'auto',
							editable:false,
							valueField:'id',
							textField:'trueName',
							formatter: formatItem,
							url:'${pageContext.request.contextPath }/user/assignMan_comboList.do'"
					/>
					<script type="text/javascript">
						function formatItem(row){
							var s = '<span style="font-weight:bold">' + row.trueName + '</span><br/>' +
									'<span style="color:#888">' + row.desc + '</span>';
							return s;
						}
					</script>
				</td>
				<td></td>
				<td>指派时间：</td>
				<td>
					<!-- 选择指派人时，JS填充指派时间 -->
					<input class="easyui-textbox" id="assignTime" name="assignTime" data-options="showSeconds:false" readonly="readonly">
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:saveSaleChance()" class="easyui-linkbutton" iconCls="icon-page-page-save">保存</a>
	<a href="javascript:closeSaleChanceDialog()" class="easyui-linkbutton" iconCls="icon-folder-folder-wrench">关闭</a>
</div>

<script type="text/javascript">
	$('#dg').datagrid({    
	    url:'${pageContext.request.contextPath }/saleChance/list.do',    
	    columns:[[
			{field:'cb',checkbox:true},
			{field:'id',title:'ID',hidden:true}, 
	        {field:'chanceSource',title:'机会来源',width:80,align:'left'},
	        {field:'customerName',title:'客户名称',width:80,align:'left'},
	        {field:'overview',title:'概要',width:100,align:'left'},
	        {field:'linkMan',title:'联系人',width:80,align:'left'},
	        {field:'linkPhone',title:'联系电话',width:80,align:'left'},
	        {field:'createMan',title:'创建人',width:80,align:'left'},
	        {field:'createTime',title:'创建时间',width:80,align:'left'},
	        {field:'currentState',title:'分配状态',width:80,align:'left',
	        	formatter: function(value,row,index){
					if(row.currentState==0){
						return "未分配";
					}else{
						return "已分配";
					}
	        	}
	        }
	    ]]
	});
</script>
</body>
</html>