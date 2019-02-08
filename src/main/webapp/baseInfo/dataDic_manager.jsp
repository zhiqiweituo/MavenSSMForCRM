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

	function searchDataDic(){
		$('#dg').datagrid('load',{
			dataDicName:$("#s_dataDicName").combobox("getValue"),
			dataDicValue:$("#s_dataDicValue").val()
		});
	}

	function deleteDataDic(){
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
				$.post("${pageContext.request.contextPath }/dataDic/del.do",{ids:ids},function(result){
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
	
	
	function openDataDicAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加数据字典信息");
		$('#dlg').window('center'); //居中显示
	}
	
	function openDataDicModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑数据字典信息");
		$("#fm").form("load",row);
	}
	
	function closeDataDicDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function resetValue(){
		$("#id").val("");
		$("#dataDicName").combobox('select', '请选择...');
		$("#dataDicValue").textbox("setValue","");
	}
	
	function saveDataDic(){
		$("#fm").form("submit",{
			url:"${pageContext.request.contextPath }/dataDic/save.do",
			onSubmit:function(){
				if($('#dataDicName').combobox("getValue")=="请选择..."){
					$.messager.alert("系统提示","请选择数据字典名称");
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
			<a href="javascript:openDataDicAddDialog()" class="easyui-linkbutton" iconCls="icon-book-book-add" plain="true">添加</a>
			<a href="javascript:openDataDicModifyDialog()" class="easyui-linkbutton" iconCls="icon-book-book-edit" plain="true">修改</a>
			<a href="javascript:deleteDataDic()" class="easyui-linkbutton" iconCls="icon-book-book-delete" plain="true">删除</a>
		</div>
		<div>
			<label style="margin-left: 5px;">数据字典名称：</label>
			<input class="easyui-combobox" id="s_dataDicName" name="s_dataDicName" size="20" 
				data-options="panelHeight:'auto',
					editable:false,
					valueField:'dataDicName',<!-- key,value这里都使用dataDicName -->
					textField:'dataDicName',
					url:'${pageContext.request.contextPath }/dataDic/dataDicName_comboList.do'"
			/>
			<label style="margin-left: 5px;">数据字典值：</label>
			<input class="easyui-textbox" id="s_dataDicValue" name="s_dataDicValue"/>
			<a href="javascript:searchDataDic()" class="easyui-linkbutton" iconCls="icon-zoom-zoom" plain="true">搜索</a>
		</div>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 350px;height: 200px; padding: 10px;"
	closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table>
			<tr>
				<td>数据字典名称：<input type="hidden" id="id" name="id"/></td>
				<td>
					<input class="easyui-combobox" id="dataDicName" name="dataDicName" size="20" 
						data-options="panelHeight:'auto',
							editable:false,
							valueField:'dataDicName',<!-- key,value这里都使用dataDicName -->
							textField:'dataDicName',
							url:'${pageContext.request.contextPath }/dataDic/dataDicName_comboList.do'"
					/>
				</td>
			</tr>
			<tr>
				<td>数据字典值：</td>
				<td><input class="easyui-textbox" id="dataDicValue" name="dataDicValue" class="easyui-validatebox" required="true"/></td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:saveDataDic()" class="easyui-linkbutton" iconCls="icon-page-page-save">保存</a>
	<a href="javascript:closeDataDicDialog()" class="easyui-linkbutton" iconCls="icon-folder-folder-wrench">关闭</a>
</div>

<script type="text/javascript">
	$('#dg').datagrid({    
	    url:'${pageContext.request.contextPath }/dataDic/list.do',    
	    columns:[[
			{field:'cb',checkbox:true},
			{field:'id',title:'ID',hidden:true}, 
	        {field:'dataDicName',title:'数据字典名称',width:80,align:'left'},
	        {field:'dataDicValue',title:'数据字典值',width:80,align:'left'}
	    ]]    
	});
</script>
</body>
</html>