/**
 * Name 添加记录
 */
function add() {
	$('#editForm').form('submit', {
		url : module+'/add.do',
		success : function(data) {
			var data = eval('(' + data + ')');
			if (data.isOk && data.isOk == 1) {
				$.messager.alert('信息提示', '提交成功！', 'info');
				$('#editDialog').dialog('close');
				refresh();
			} else {
				$.messager.alert('信息提示', '提交失败！', 'info');
			}
		}
	});
}

/**
 * Name 修改记录
 */
function edit() {
	$('#editForm').form('submit', {
		url : module+'/edit.do',
		success : function(data) {
			var data = eval('(' + data + ')');
			if (data.isOk && data.isOk == 1) {
				$.messager.alert('信息提示', '提交成功！', 'info');
				$('#editDialog').dialog('close');
				refresh();
			} else {
				$.messager.alert('信息提示', '提交失败！', 'info');
			}
		}
	});
}
function refresh() {
	$("#datagrid").datagrid('reload');
}
/**
 * Name 删除记录
 */
function remove(id) {
	$.messager.confirm('信息提示', '确定要删除该记录？', function(result) {
		if (result) {
			var ids = "";
			if (id) {
				ids += id;
			} else {
				var items = $('#datagrid').datagrid('getSelections');
				$(items).each(function() {
					ids += this.id + ",";
				});
			}
			if (ids == "") {
				$.messager.alert('信息提示', '请选择要删除的记录！', 'info');
				return;
			}
			$.ajax({
				url : module+'/delete.do',
				data : {
					ids : ids
				},
				dataType : "json",
				success : function(data) {
					if (data.isOk && data.isOk == 1) {
						$.messager.alert('信息提示', '删除成功！', 'info');
						refresh();
					} else {
						$.messager.alert('信息提示', '删除失败！', 'info');
					}
				}
			});
		}
	});
}

/**
 * Name 打开添加窗口
 */
function addUI() {
	$('#editForm').form('clear');
	$('#editDialog').dialog({
		closed : false,
		modal : true,
		title : "添加信息",
		buttons : [ {
			text : '确定',
			iconCls : 'icon-ok',
			handler : add
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$('#editDialog').dialog('close');
			}
		} ]
	});
}

/**
 * Name 打开修改窗口
 */
function editUI(id) {
	$('#editForm').form('clear');
	var tempid = "";
	if (id) {
		tempid = id;
	} else {
		var item = $('#datagrid').datagrid('getSelected');
		if (item) {
			tempid = item.id;
		} else {
			$.messager.alert('信息提示', '请选择要修改的记录！', 'info');
			return;
		}
	}
	$.ajax({
		url : module+'/editUI.do',
		data : {
			id : tempid
		},
		dataType : "json",
		success : function(data) {
			if (data) {
				$('#editForm').form('load', data);
			} else {
				$('#editDialog').dialog('close');
			}
		}
	});
	$('#editDialog').dialog({
		closed : false,
		modal : true,
		title : "修改信息",
		buttons : [ {
			text : '确定',
			iconCls : 'icon-ok',
			handler : edit
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$('#editDialog').dialog('close');
			}
		} ]
	});
}

/**
 * Name 分页过滤器
 */
function pagerFilter(data) {
	if (typeof data.length == 'number' && typeof data.splice == 'function') {// is array                
		data = {
			total : data.length,
			rows : data
		}
	}
	var dg = $(this);
	var opts = dg.datagrid('options');
	var pager = dg.datagrid('getPager');
	pager.pagination({
		onSelectPage : function(pageNum, pageSize) {
			opts.pageNumber = pageNum;
			opts.pageSize = pageSize;
			pager.pagination('refresh', {
				pageNumber : pageNum,
				pageSize : pageSize
			});
			dg.datagrid('loadData', data);
		}
	});
	if (!data.originalRows) {
		data.originalRows = (data.rows);
	}
	var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);
	var end = start + parseInt(opts.pageSize);
	data.rows = (data.originalRows.slice(start, end));
	return data;
}

/**
 * Name 载入数据
 */
$('#datagrid').datagrid({
	url : module+'/jsonList.do',
	loadFilter : pagerFilter,
	rownumbers : true,
	singleSelect : false,
	pageSize : 20,
	pagination : true,
	multiSort : true,
	fitColumns : true,
	fit : true,
	idField:"id",
	striped : true,
	columns : [columns],
	onLoadSuccess : function(data) {
		$("a.edit").linkbutton({
			text : '修改',
			plain : true,
			iconCls : 'icon-pencil'
		});
		$("a.del").linkbutton({
			text : '删除',
			plain : true,
			iconCls : 'icon-delete'
		});
	}
});

$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name] !== undefined) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};
function doSearch() {
	$('#datagrid').datagrid('load', $("#searchForm").serializeObject());
}