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

	function searchProduct(){
		$('#dg').datagrid('load',{
			productName:$("#s_productName").val(),
			model:$("#s_model").val(),
		});
	}

	function deleteProduct(){
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
				$.post("${pageContext.request.contextPath }/product/del.do",{ids:ids},function(result){
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
	
	
	function openProductAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加产品信息");
		$('#dlg').window('center'); //居中显示
	}
	
	function openProductModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑产品信息");
		$("#fm").form("load",row);
	}
	
	function closeProductDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function resetValue(){
		$("#id").val("");
		$("#productName").textbox("setValue","");
		$("#model").textbox("setValue","");
		$("#unit").textbox("setValue","");
		$("#price").textbox("setValue","");
		$("#store").textbox("setValue","");
		$("#remark").textbox("setValue","");
	}
	
	function saveProduct(){
		$("#fm").form("submit",{
			url:"${pageContext.request.contextPath }/product/save.do",
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
			<a href="javascript:openProductAddDialog()" class="easyui-linkbutton" iconCls="icon-book-book-add" plain="true">添加</a>
			<a href="javascript:openProductModifyDialog()" class="easyui-linkbutton" iconCls="icon-book-book-edit" plain="true">修改</a>
			<a href="javascript:deleteProduct()" class="easyui-linkbutton" iconCls="icon-book-book-delete" plain="true">删除</a>
		</div>
		<div>
			<label style="margin-left: 5px;">产品名称：</label>
			<input class="easyui-textbox" id="s_productName" name="s_productName"/>
			<label style="margin-left: 5px;">规格：</label>
			<input class="easyui-textbox" id="s_model" name="s_model"/>
			<a href="javascript:searchProduct()" class="easyui-linkbutton" iconCls="icon-zoom-zoom" plain="true">搜索</a>
		</div>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 550px;height: 280px; padding: 10px;"
	closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table>
			<tr>
				<td>产品名称：<input type="hidden" id="id" name="id"/></td>
				<td><input class="easyui-textbox" id="productName" name="productName" class="easyui-validatebox" required="true"/></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>规格：</td>
				<td><input class="easyui-textbox" id="model" name="model" class="easyui-validatebox" required="true"/></td>
			</tr>
			<tr>
				<td>单位：</td>
				<td><input class="easyui-textbox" id="unit" name="unit" class="easyui-validatebox" required="true"/></td>
				<td></td>
				<td>价格：</td>
				<td><input class="easyui-textbox" id="price" name="price" class="easyui-validatebox" required="true"/></td>
			</tr>
			<tr>
				<td>库存：</td>
				<td><input class="easyui-textbox" id="store" name="store" class="easyui-validatebox"/></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td valign="top">备注：</td>
				<td colspan="4">
					<input class="easyui-textbox" data-options="multiline:true" id="remark" name="remark" style="width:350px; height:60px"/>
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:saveProduct()" class="easyui-linkbutton" iconCls="icon-page-page-save">保存</a>
	<a href="javascript:closeProductDialog()" class="easyui-linkbutton" iconCls="icon-folder-folder-wrench">关闭</a>
</div>

<script type="text/javascript">
	$('#dg').datagrid({    
	    url:'${pageContext.request.contextPath }/product/list.do',    
	    columns:[[
			{field:'cb',checkbox:true},
			{field:'id',title:'ID',hidden:true}, 
	        {field:'productName',title:'产品名称',width:80,align:'left'},
	        {field:'model',title:'规格',width:80,align:'left'},
	        {field:'unit',title:'单位',width:100,align:'left'},
	        {field:'price',title:'价格',width:80,align:'left'},
	        {field:'store',title:'库存',width:80,align:'left'},
	        {field:'remark',title:'备注',width:100,align:'left'}
	    ]]    
	});
</script>
</body>
</html>