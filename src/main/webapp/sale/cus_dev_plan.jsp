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
			devResult:$("#s_devResult").combobox("getValue")
		});
	}
	
	function openCusDevPlanItemTab(id){
		window.parent.addTab('客户开发计划项','sale/cus_dev_plan_item.jsp?saleChanceId='+id, 'icon-driver-drive-user');
	}
	function openCusDevPlanDetailTab(id){
		window.parent.addTab('查看开发计划项','sale/cus_dev_plan_detail.jsp?saleChanceId='+id, 'icon-driver-drive-magnify');
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
			<label style="margin-left: 5px;">客户名称：</label>
			<input class="easyui-textbox" id="s_customerName" name="s_customerName"/>
			<label style="margin-left: 5px;">概要：</label>
			<input class="easyui-textbox" id="s_overview" name="s_overview"/>
			<label style="margin-left: 5px;">指派人：</label>
			<input class="easyui-textbox" id="s_createMan" name="s_createMan"/>
			<label style="margin-left: 5px;">开发状态：</label>
			<input class="easyui-combobox" id="s_devResult" name="s_devResult" size="20"
				data-options="panelHeight:'auto',
					editable:false,
					valueField: 'label',
					textField: 'value',
					data: [{
						label: '',
						value: '请选择...'
					},{
						label: '0',
						value: '未开发'
					},{
						label: '1',
						value: ' 开发中'
					},{
						label: '2',
						value: '开发成功'
					},{
						label: '3',
						value: '开发失败'
					}]"
			/>
			<a href="javascript:searchSaleChance()" class="easyui-linkbutton" iconCls="icon-zoom-zoom" plain="true">搜索</a>
		</div>
	</div>
</div>

<script type="text/javascript">
	$('#dg').datagrid({    
	    url:'${pageContext.request.contextPath }/saleChance/list.do?currentState=1',    
	    columns:[[
			{field:'cb',checkbox:true},
			{field:'id',title:'ID',hidden:true}, 
	        {field:'customerName',title:'客户名称',width:50,align:'left'},
	        {field:'overview',title:'概要',width:80,align:'left'},
	        {field:'linkMan',title:'联系人',width:20,align:'left'},
	        {field:'linkPhone',title:'联系电话',width:30,align:'left'},
	        {field:'createMan',title:'指派人',width:20,align:'left'},
	        {field:'createTime',title:'指派时间',width:70,align:'left'},
	        {field:'devResult',title:'开发状态',width:20,align:'left',
	        	formatter: function(value,row,index){
					if(row.devResult==0){
						return "未开发";
					}else if(row.devResult==1){
						return "开发中";
					}else if(row.devResult==2){
						return "开发成功";
					}else if(row.devResult==3){
						return "开发失败";
					}
	        	}
	        },
	        {field:'tmep',title:'操作',width:40,align:'left',
	        	formatter: function(value,row,index){
					if(row.devResult==0){
						return "<a href='javascript:openCusDevPlanItemTab("+row.id+")'>开发</a>";
					}else if(row.devResult==1){
						return "<a href='javascript:openCusDevPlanItemTab("+row.id+")'>开发</a>";
					}else if(row.devResult==2){
						return "<a href='javascript:openCusDevPlanDetailTab("+row.id+")'>查看信息</a>";
					}else if(row.devResult==3){
						return "<a href='javascript:openCusDevPlanDetailTab("+row.id+")'>查看信息</a>";
					}
	        	}
	        }
	    ]]
	});
</script>
</body>
</html>