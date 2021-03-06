<%@ page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	String billType = request.getParameter("bill_type");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<meta http-equiv="Expires" content="0">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-control" content="no-cache">
<meta http-equiv="Cache" content="no-cache">
<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/jquery-easyui-1.5/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/jquery-easyui-1.5/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/css/base.css">
<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/jquery-easyui-1.5/demo/demo.css">
<script type="text/javascript"
	src="<%=contextPath%>/jquery-easyui-1.5/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/base.js"></script>
<script type="text/javascript">
	//关闭选择部门窗口
	function closeAddToolsUIForBatch() {
		closeUI('addToolsUIForBatch')
	}

	//打开选择部门窗口
	function openAddToolsUIForBatch(billId) {
		var panelHeight = 0;
		var billType = getTextBoxValue('billTypeTextInput');
		if (billType == 0) {
			panelWidth = 500;
			panelHeight = 400;
		} else if (billType == 8 || billType == 9) {
			panelWidth = 500;
			panelHeight = 200;
		} else if (billType == 1 || billType == 5 || billType == 6) {
			panelWidth = 500;
			panelHeight = 280;
		} else {
			panelWidth = 500;
			panelHeight = 250;
		}
		var billType = getTextBoxValue('billTypeTextInput');
		var title = "";
		if (billType == 0) {
			title = "扫描入库工器具";
		} else if (billType == 1) {
			title = "扫描出库工器具";
		} else if (billType == 2) {
			title = "扫描转仓工器具";
		} else if (billType == 3) {
			title = "扫描退仓工器具";
		} else if (billType == 4) {
			title = "扫描报废工器具";
		} else if (billType == 5) {
			title = "扫描外站借用工器具";
		} else if (billType == 6) {
			title = "扫描外站归还工器具";
		} else if (billType == 8) {
			title = "扫描使用本站工器具";
		} else if (billType == 9) {
			title = "扫描归还本站工器具";
		}
		createModalDialog("addToolsUIForBatch",
				"addToolsUIForCheckIn.jsp?OP_TYPE=ADD&BILL_ID=" + billId
						+ "&bill_type=" + getTextBoxValue('billTypeTextInput'),
				"添加跟踪情况", panelWidth, panelHeight);
		openUI('addToolsUIForBatch');
	}

	//打开选择部门窗口
	function openAddToolsUIForExchangeBatch() {
		createModalDialog("addToolsUIForBatch",
				"openAddToolsUI.do?OP_TYPE=EXCHANGE_TO_CHECKIN&bill_type="
						+ getTextBoxValue('billTypeTextInput'), "转仓入库", 500,
				400);
		openUI('addToolsUIForBatch');
	}

	//删除
	function delBatchs() {
		if (checkSelectedItems('datagridForBatch', '请选择批次')) {
			var ids = getIdsOfSelectedItems('datagridForBatch', 'BILL_ID');
			if (ids != null && ids != '') {
				var params = {
					BILL_IDS : ids
				};
				showMessageBox(params, 'delBatchs.do', '是否删除所选批次?',
						successFunctionForOption);
			}
		}
	}

	//删除
	function delToolAndTrack(toolId, trackId, billId) {
		var params = {
			TOOL_ID : toolId,
			TRACK_ID : trackId,
			BILL_ID : billId
		};
		showMessageBox(params, 'delToolAndTrack.do', '是否删除所选工器具?',
				successFunctionForOptionToolTrack);
	}

	//确认
	function confirmBatchs() {
		if (checkSelectedItems('datagridForBatch', '请选择批次')) {
			var ids = getIdsOfSelectedItems('datagridForBatch', 'BILL_ID');
			if (ids != null && ids != '') {
				var params = {
					BILL_IDS : ids,
					bill_type : getTextBoxValue('billTypeTextInput')
				};
				showMessageBox(params, 'confirmBatchs.do', '是否确认所选批次?',
						successFunctionForOption);
			}
		}
	}

	//领用
	function takeBatchs() {
		if (checkSelectedItems('datagridForBatch', '请选择批次')) {
			var ids = getIdsOfSelectedItems('datagridForBatch', 'BILL_ID');
			if (ids != null && ids != '') {
				var params = {
					BILL_IDS : ids
				};
				showMessageBox(params, 'takeBatchs.do', '是否领用所选批次?',
						successFunctionForOption);
			}
		}
	}

	//回调函数，删除或其他操作成功后调用
	function successFunctionForOption(result) {
		showMessage(result.msg, result.msg);
		reloadDataGrid('datagridForBatch');
	}

	//回调函数，删除或其他操作成功后调用
	function successFunctionForOptionToolTrack(result) {
		showMessage(result.msg, result.msg);
		var rowData = getRowDataOfSelfDataGrid('datagridForBatch',
				rowIndexOfDataGrid);
		queryToolTracks(rowData.BILL_ID);
	}

	//用在点击查询按钮的时候
	function queryBatchPagesForSearch() {
		queryBatchs();
	}

	//用在点击查询按钮的时候
	function queryToolTrackPagesForSearch() {
		var rowData = getRowDataOfSelfDataGrid('datagridForBatch',
				rowIndexOfDataGrid);
		queryToolTracks(rowData.BILL_ID);
	}

	//查询
	function queryBatchs() {
		var params = {
			bill_type : getTextBoxValue('billTypeTextInput'),
			keyWord : getTextBoxValue('keyWordForBatchTextInput'),
			page : 1,
			rows : getPageSizeOfDataGrid('datagridForBatch')
		};
		query(params, 'queryBatchsPage.do', successFunctionForQueryBatchs);
	}

	//回调函数，查询成功后调用
	function successFunctionForQueryBatchs(result) {
		dataGridLoadData('datagridForBatch', result);
	}

	//查询
	function queryToolTracks(billId) {
		var params = {
			BILL_ID : billId,
			keyWord : getTextBoxValue('keyWordForToolTrackTextInput'),
			page : 1,
			rows : getPageSizeOfDataGrid('datagridForToolTrack')
		};
		query(params, 'queryToolTracksPage.do',
				successFunctionForQueryToolTracks);
	}

	//回调函数，查询成功后调用
	function successFunctionForQueryToolTracks(result) {
		dataGridLoadData('datagridForToolTrack', result);
	}

	//页面加载完
	$(document).ready(
			function() {
				closeCache();
				registerKeyPressForTextInput('keyWordForBatchTextInput',
						queryBatchPagesForSearch);
				registerKeyPressForTextInput('keyWordForToolTrackTextInput',
						queryToolTrackPagesForSearch);
				initDataGridForBatch();
				initDataGridForToolTrackDetail();
				initToolTrackPanel();
				var billType = getTextBoxValue('billTypeTextInput');
				if (billType == 1 || billType == 2 || billType == 7
						|| billType == 5) {
					$('#datagridForBatch').datagrid('showColumn',
							'BILL_TAKE_DEPT_NAME');
					$('#datagridForBatch').datagrid('showColumn',
							'BILL_TAKE_USER_NAME');
					$('#datagridForBatch').datagrid('showColumn',
							'BILL_TAKE_TIME');
					if (billType == 7) {
						$('#datagridForBatch').datagrid('hideColumn',
								'addToolColumn');
						$('#datagridForToolTrack')
								.datagrid('hideColumn', 'del');
					}
				}

				if (billType == 6) {
					$('#datagridForBatch').datagrid('showColumn',
							'BILL_RETURN_USER_NAME');
				}

				var addToolBtnName = "";
				if (billType == 0) {
					addToolBtnName = "扫描入库工器具";
				} else if (billType == 1) {
					addToolBtnName = "扫描出库工器具";
				} else if (billType == 2) {
					addToolBtnName = "扫描转仓工器具";
				} else if (billType == 3) {
					addToolBtnName = "扫描退仓工器具";
				} else if (billType == 4) {
					addToolBtnName = "扫描报废工器具";
				} else if (billType == 5) {
					addToolBtnName = "扫描外站借用工器具";
				} else if (billType == 6) {
					addToolBtnName = "扫描外站归还工器具";
				} else if (billType == 8) {
					addToolBtnName = "扫描使用本站工器具";
				} else if (billType == 9) {
					addToolBtnName = "扫描归还本站工器具";
				}

				$('#addToolBtn').linkbutton({
					text : addToolBtnName
				});
			});

	//初始化明细界面
	function initToolTrackPanel() {
		$('#toolTrackUI').panel({
			closed : true
		});
	}

	//初始化列表元素
	function initDataGridForBatch() {
		$('#datagridForBatch')
				.datagrid(
						{
							//url : 'queryBatchsPage.do?bill_type='
							//		+ getTextBoxValue('billTypeTextInput'),
							url : 'bill_data.json',
							idField : 'BILL_ID',
							rownumbers : true,
							toolbar : '#toolbarForBatch',
							pagination : true,
							pageSize : 30,
							pageNumber : 1,
							checkOnSelect : false,
							fit : true,
							method : 'get',
							columns : [ [
									{
										field : 'op',
										title : '操作',
										align : 'center',
										formatter : function(fieldValue,
												rowData, rowIndex) {
											var billConfirmUserId = rowData.BILL_CONFIRM_USER_ID;
											var btn = '';
											btn = '<a class="easyui-linkbutton" '
													+ ' onclick="toDetail(\''
													+ rowIndex
													+ '\')" href="javascript:void(0)">情况跟踪</a>';
											return btn;
										}
									}, {
										field : 'EQUIPMENT_STATUS',
										title : '状态',
										width : 100
									}, {
										field : 'EQUIPMENT_CODE',
										title : '编号',
										width : 200
									}, {
										field : 'EQUIPMENT_NAME',
										title : '名称',
										width : 150,
									}, {
										field : 'MAN_NAME',
										title : '厂家',
										width : 150,
									}, {
										field : 'EQUIPMENT_STATION',
										title : '所属变电站',
										width : 150,
									}, {
										field : 'EQUIPMENT_REMARK',
										title : '备注',
										width : 100,
									} ] ],
							onBeforeLoad : function(param) {
								param.keyWord = getTextBoxValue('keyWordForBatchTextInput');
								param.bill_type = getTextBoxValue('billTypeTextInput');
							},
							onLoadSuccess : function(data) {
								var billType = getTextBoxValue('billTypeTextInput');
								if (billType != 7) {
									if (data.rows.length > 0) {
										//循环判断操作为新增的不能选择
										for (var i = 0; i < data.rows.length; i++) {
											//根据operate让某些行不可选
											if (data.rows[i].BILL_CONFIRM_USER_ID != null) {
												$("input[type='checkbox']")[i + 1].disabled = true;
												data.rows[i].disabled = true;
											}
										}
									}
								}
							},
							onCheckAll : function(rows) {
								for (var i = 0; i < rows.length; i++) {
									if (rows[i].disabled) {
										$("#datagridForBatch").datagrid(
												'uncheckRow', i);
									}
								}
							},
							onLoadError : function() {
								errorFunctionForQuery();
							}
						});
	}

	//初始化列表元素
	function initDataGridForToolTrackDetail() {
		$('#datagridForToolTrack')
				.datagrid(
						{
							idField : 'TRACK_ID',
							url : 'bill_detail_data.json',
							rownumbers : true,
							toolbar : '#toolbarForToolTrack',
							pagination : true,
							pageSize : 30,
							pageNumber : 1,
							checkOnSelect : false,
							fit : true,
							method : 'get',
							columns : [ [
									{
										field : 'ck',
										checkbox : true
									},
									{
										field : 'op',
										title : '修改',
										align : 'center',
										formatter : function(fieldValue,
												rowData, rowIndex) {
											var billConfirmUserId = rowData.BILL_CONFIRM_USER_ID;
											var btn = '';
											btn = '<a class="easyui-linkbutton" '
													+ ' onclick="toDetail(\''
													+ rowIndex
													+ '\')" href="javascript:void(0)">编辑</a>';
											return btn;
										}
									}, {
										field : 'EQUIPMENT_STATUS',
										title : '状态',
										width : 100
									}, {
										field : 'EQUIPMENT_SITUATION',
										title : '情况说明',
										align : 'center',
										width : 350
									}, {
										field : 'EQUIPMENT_DATE',
										title : '创建日期',
										align : 'center',
										width : 100
									}, {
										field : 'EQUIPMENT_REMARK',
										title : '备注',
										align : 'center',
										width : 100
									} ] ],
							onBeforeLoad : function(param) {
								param.keyWord = getTextBoxValue('keyWordForToolTrackTextInput');
							},
							onLoadError : function() {
								errorFunctionForQuery();
							}
						});
	}

	//操作类型
	var opType = '';

	//记录新增或者修改的方法
	var url;

	var rowIndexOfDataGrid = 0;

	//编辑界面
	function toDetail(rowIndex) {
		rowIndexOfDataGrid = rowIndex;
		var rowData = getRowDataOfSelfDataGrid('datagridForBatch', rowIndex);
		//queryToolTracks(rowData.BILL_ID);
		$('#billListUI').panel('close');
		$('#toolTrackUI').panel('open');
		$('#toolTrackUI').panel('maximize');
	}

	//列表界面
	function toList() {
		$('#billListUI').panel('open');
		$('#toolTrackUI').panel('close');
		$('#billListUI').panel('maximize');

		rowIndexOfDataGrid = 0;
		//清空明细列表
		//dataGridLoadData('datagridForToolTrack', {
		//	total : 0,
		//	rows : []
		//});

		//queryBatchs();
	}
</script>
</head>
<body>

	<div id="billListUI" class="easyui-panel"
		data-options="fit:true,border:false">
		<!-- 列表页面 -->
		<table id="datagridForBatch" class="easyui-datagrid">
		</table>
		<div id="toolbarForBatch">
			<div style="display: none">
				<input id="billTypeTextInput" class="easyui-textbox"
					value="<%=request.getParameter("bill_type")%>" />
			</div>
			<table style="width: 100%">
				<tr>
					<td><a href="#" class="easyui-linkbutton"
						iconCls="icon-reload" plain="true"
						onclick="refreshDataGrid('datagridForBatch')">刷新</a> <a
						href="#" class="easyui-linkbutton" iconCls="icon-add"
						plain="true" onclick="openAddToolsUIForBatch('')">添加</a>
					</td>
					<td align="right"><input
						id="keyWordForBatchTextInput" class="easyui-textbox"
						data-options="prompt:'编号',validType:'length[0,50]'"
						style="width: 200px"> <a href="#"
						class="easyui-linkbutton" iconCls="icon-search"
						onclick="queryBatchPagesForSearch()">查询</a>
				</tr>
			</table>
		</div>
	</div>
	<div id="toolTrackUI" class="easyui-panel"
		data-options="fit:true,border:false">
		<table id="datagridForToolTrack" class="easyui-datagrid">
		</table>

		<div id="toolbarForToolTrack">
			<div>
				<a href="#" class="easyui-linkbutton" plain="true"
					iconCls="icon-arrow_left" onclick="toList()">返回</a><a
					href="#" class="easyui-linkbutton" plain="true"
					iconCls="icon-remove" onclick="toList()">删除</a> <input
					id="keyWordForToolTrackTextInput"
					class="easyui-textbox"
					data-options="prompt:'工器具编号',validType:'length[0,50]'"
					style="width: 200px"> <a href="#"
					class="easyui-linkbutton" iconCls="icon-search"
					onclick="queryToolTrackPagesForSearch()">查询</a>
			</div>
		</div>
	</div>
</body>
</html>