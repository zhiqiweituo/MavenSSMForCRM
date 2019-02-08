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

	function searchCustomer(){
		$('#dg').datagrid('load',{
			khno:$("#s_khno").val(),
			name:$("#s_name").val(),
		});
	}

	function deleteCustomer(){
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
				$.post("${pageContext.request.contextPath }/customer/del.do",{ids:ids},function(result){
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
	
	
	function openCustomerAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加产品信息");
		$('#dlg').window('center'); //居中显示
	}
	
	function openCustomerModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑产品信息");
		$("#fm").form("load",row);
	}
	
	function closeCustomerDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function resetValue(){
		$("#id").val("");
		$("#name").textbox("setValue","");
		$("#area").combobox('select', '请选择...');
		$("#cusManager").combobox('setValue', '请选择...');
		$("#level").combobox('select', '请选择...');
		$("#myd").combobox('setValue', '请选择...');
		$("#xyd").combobox('setValue', '请选择...');
		$("#address").textbox("setValue","");
		$("#postCode").textbox("setValue","");
		$("#phone").textbox("setValue","");
		$("#fax").textbox("setValue","");
		$("#webSite").textbox("setValue","");
		$("#yyzzzch").textbox("setValue","");
		$("#fr").textbox("setValue","");
		$("#zczj").textbox("setValue","");
		$("#nyye").textbox('setValue', "");
		$("#khyh").textbox("setValue","");
		$("#khzh").textbox("setValue","");
		$("#dsdjh").textbox("setValue","");
		$("#gsdjh").textbox("setValue","");
	}
	
	function saveCustomer(){
		$("#fm").form("submit",{
			url:"${pageContext.request.contextPath }/customer/save.do",
			onSubmit:function(){
				if($('#area').combobox("getValue")=="请选择..."){
					$.messager.alert("系统提示","请选择客户地区");
					return false;
				}
				if($('#cusManager').combobox("getValue")==""){
					$.messager.alert("系统提示","请选择客户经理");
					return false;
				}
				if($('#level').combobox("getValue")=="请选择..."){
					$.messager.alert("系统提示","请选择客户等级");
					return false;
				}
				if($('#myd').combobox("getValue")==""){
					$.messager.alert("系统提示","请选择客户满意度");
					return false;
				}
				if($('#xyd').combobox("getValue")==""){
					$.messager.alert("系统提示","请选择客户信用度");
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
	
	function showCustomerLinkMan() {
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		window.parent.addTab('客户联系人管理','customer/customer_link_man.jsp?customerId='+row.id, 'icon-group-group-edit');
	}
	
	function showCustomerContact() {
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		window.parent.addTab('客户交往记录','customer/customer_contact.jsp?customerId='+row.id, 'icon-table-table-save');
	}
	
	function showCustomerOrder() {
		$.messager.alert("系统提示","此模块暂时不做！");
	}
</script>
</head>
<body>

<!-- easyUI的panel -> dataGrid数据表格 -->
<div class="easyui-panel" style="width:100%;height:420px;padding:10px;">
	<!-- 使用Javascript去创建dataGrid控件 -->
	<table id="dg" pagination="true" rownumbers="true" fit="true" toolbar="#tb"></table>

	<div id="tb">
		<div>
			<a href="javascript:openCustomerAddDialog()" class="easyui-linkbutton" iconCls="icon-vcard-vcard-add" plain="true">添加</a>
			<a href="javascript:openCustomerModifyDialog()" class="easyui-linkbutton" iconCls="icon-vcard-vcard-edit" plain="true">修改</a>
			<a href="javascript:deleteCustomer()" class="easyui-linkbutton" iconCls="icon-vcard-vcard-delete" plain="true">删除</a>
			<a href="javascript:showCustomerLinkMan()" class="easyui-linkbutton" iconCls="icon-group-group-edit" plain="true">客户联系人管理</a>
			<a href="javascript:showCustomerContact()" class="easyui-linkbutton" iconCls="icon-table-table-save" plain="true">客户交往记录</a>
			<a href="javascript:showCustomerOrder()" class="easyui-linkbutton" iconCls="icon-page-page-copy" plain="true">客户订单管理</a>
		</div>
		<div>
			<label style="margin-left: 5px;">客户编号：</label>
			<input class="easyui-textbox" id="s_khno" name="s_khno" onkeydown="if(event.keyCode==13) searchCustomer()"/>
			<label style="margin-left: 5px;">客户名称：</label>
			<input class="easyui-textbox" id="s_name" name="s_name" onkeydown="if(event.keyCode==13) searchCustomer()"/>
			<a href="javascript:searchCustomer()" class="easyui-linkbutton" iconCls="icon-zoom-zoom" plain="true">搜索</a>
		</div>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 860px;height: 340px; padding: 10px;"
	closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table>
			<tr>
				<td>客户编号：<input type="hidden" id="id" name="id"/></td>
				<td><input class="easyui-textbox" id="khno" name="khno" data-options="editable:false" value="由系统自动生成"/></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>客户名称：</td>
				<td colspan="4"><input class="easyui-textbox" id="name" name="name" class="easyui-validatebox" required="true" style="width: 414px;"/></td>
			</tr>
			<tr>
				<td>客户地区：</td>
				<td>
					<input class="easyui-combobox" id="area" name="area" size="20"
						data-options="panelHeight:'auto',
							editable:false,
							valueField:'dataDicValue',
							textField:'dataDicValue',
							url:'${pageContext.request.contextPath }/dataDic/findDataDicValue.do?dataDicName=客户地区'"
					/>
				</td>
				<td></td>
				<td>客户经理：</td>
				<td>
					<input class="easyui-combobox" id="cusManager" name="cusManager" size="20"
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
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>客户等级：</td>
				<td>
					<input class="easyui-combobox" id="level" name="level" size="20"
						data-options="panelHeight:'auto',
							editable:false,
							valueField:'dataDicValue',
							textField:'dataDicValue',
							url:'${pageContext.request.contextPath }/dataDic/findDataDicValue.do?dataDicName=客户等级'"
					/>
				</td>
			</tr>
			<tr>
				<td>客户满意度：</td>
				<td>
					<input class="easyui-combobox" id="myd" name="myd" size="20"
						data-options="panelHeight:'auto',
							editable:false,
							valueField: 'label',
							textField: 'value',
							data: [{
								label: '',
								value: '请选择...'
							},{
								label: '1',
								value: '★'
							},{
								label: '2',
								value: '★★'
							},{
								label: '3',
								value: '★★★'
							},{
								label: '4',
								value: '★★★★'
							},{
								label: '5',
								value: '★★★★★'
							}]"
					/>
				</td>
				<td></td>
				<td>客户信用度：</td>
				<td>
					<input class="easyui-combobox" id="xyd" name="xyd" size="20"
						data-options="panelHeight:'auto',
							editable:false,
							valueField: 'label',
							textField: 'value',
							data: [{
								label: '',
								value: '请选择...'
							},{
								label: '1',
								value: '★'
							},{
								label: '2',
								value: '★★'
							},{
								label: '3',
								value: '★★★'
							},{
								label: '4',
								value: '★★★★'
							},{
								label: '5',
								value: '★★★★★'
							}]"
					/>
				</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>客户地址：</td>
				<td colspan="7"><input class="easyui-textbox" id="address" name="address" style="width: 699px;"/></td>
			</tr>
			<tr>
				<td>邮政编码：</td>
				<td><input class="easyui-textbox" id="postCode" name="postCode"/></td>
				<td></td>
				<td>联系电话：</td>
				<td><input class="easyui-textbox" id="phone" name="phone"/></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>传真：</td>
				<td><input class="easyui-textbox" id="fax" name="fax"/></td>
			</tr>
			<tr>
				<td>网址：</td>
				<td><input class="easyui-textbox" id="webSite" name="webSite"/></td>
				<td></td>
				<td>营业执照注册号：</td>
				<td><input class="easyui-textbox" id="yyzzzch" name="yyzzzch"/></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>法人：</td>
				<td><input class="easyui-textbox" id="fr" name="fr"/></td>
			</tr>
			<tr>
				<td>注册资金(万元)：</td>
				<td><input class="easyui-textbox" id="zczj" name="zczj"/></td>
				<td></td>
				<td>年营业额：</td>
				<td><input class="easyui-textbox" id="nyye" name="nyye"/></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>开户银行：</td>
				<td><input class="easyui-textbox" id="khyh" name="khyh"/></td>
			</tr>
			<tr>
				<td>开户帐号：</td>
				<td><input class="easyui-textbox" id="khzh" name="khzh"/></td>
				<td></td>
				<td>地税登记号：</td>
				<td><input class="easyui-textbox" id="dsdjh" name="dsdjh"/></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>国税登记号：</td>
				<td><input class="easyui-textbox" id="gsdjh" name="gsdjh"/></td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:saveCustomer()" class="easyui-linkbutton" iconCls="icon-page-page-save">保存</a>
	<a href="javascript:closeCustomerDialog()" class="easyui-linkbutton" iconCls="icon-folder-folder-wrench">关闭</a>
</div>

<script type="text/javascript">
	$('#dg').datagrid({
	    url:'${pageContext.request.contextPath }/customer/list.do',
	    frozenColumns:[[
			{field:'cb',checkbox:true},
			{field:'id',title:'ID',hidden:true},
			{field:'khno',title:'客户编号',width:120},
			{field:'name',title:'客户名称',width:140},
			{field:'cusManager',title:'客户经理',width:50},
			{field:'level',title:'客户等级',width:90},
			{field:'phone',title:'联系电话',width:100}
	    ]],
	    columns:[[
	        {field:'area',title:'客户地区',width:50,align:'left'},
	        {field:'myd',title:'客户满意度',width:70,align:'left'},
	        {field:'xyd',title:'客户信用度',width:70,align:'left'},
	        {field:'address',title:'客户地址',width:240,align:'left'},
	        {field:'postCode',title:'邮政编码',width:60,align:'left'},
	        {field:'fax',title:'传真',width:100,align:'left'},
	        {field:'webSite',title:'网址',width:120,align:'left'},
	        {field:'yyzzzch',title:'营业执照注册号',width:100,align:'left'},
	        {field:'fr',title:'法人',width:50,align:'left'},
	        {field:'zczj',title:'注册资金(万元)',width:80,align:'left'},
	        {field:'nyye',title:'年营业额(万元)',width:80,align:'left'},
	        {field:'khyh',title:'开户银行',width:100,align:'left'},
	        {field:'khzh',title:'开户帐号',width:100,align:'left'},
	        {field:'dsdjh',title:'地税登记号',width:100,align:'left'},
	        {field:'gsdjh',title:'国税登记号',width:100,align:'left'}
	    ]]    
	});
</script>
</body>
</html>