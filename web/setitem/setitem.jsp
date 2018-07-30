<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <div id="wu-toolbar-2">
        <div class="wu-toolbar-button">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addUI()" plain="true">添加</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="editUI()" plain="true">修改</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="remove()" plain="true">删除</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" onclick="refresh()" plain="true">刷新</a>
        </div>
        <form id="searchForm" method="post" action="">
        <div class="wu-toolbar-search">
            <label>名称：</label><input class="wu-text" name="objname" style="width:100px">
            <label>描述：</label><input class="wu-text" name="objdesc" style="width:100px">
            <label>分类：</label> 
            <select class="easyui-combobox" panelHeight="auto" style="width:100px">
                <option value="0">选择分类</option>
                <option value="1">黄钻</option>
                <option value="2">红钻</option>
                <option value="3">蓝钻</option>
            </select>
            <label>关键词：</label><input class="wu-text" style="width:100px">
            <a href="javascript:void(0)" onclick="doSearch()" class="easyui-linkbutton" iconCls="icon-search">开始检索</a>
        </div>
        </form>
    </div>
    <!-- End of toolbar -->
    <table id="datagrid" class="easyui-datagrid" toolbar="#wu-toolbar-2"></table>
</div>
<!-- Begin of easyui-dialog -->
<div id="editDialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="editForm" class="editForm"  method="post">
        <table class="editTab">
            <tr>
                <th>设置项名称:</th>
                <td>
                <input type="hidden" class="text" name="id"/>
                <input type="text" id="objname" name="objname" class="wu-text" />
                </td>
            </tr>
            <tr>
                <th>设置项值:</th>
                <td><input type="text" name="objvalue" class="wu-text" /></td>
            </tr>
            <tr>
                <th>设置项描述:</th>
                <td><input type="text" name="objdesc" class="wu-text" /></td>
            </tr>
            <tr>
                <th>唯一标识:</th>
                <td><input type="text" name="idName" class="wu-text" /></td>
            </tr>
            <tr>
                <th>分类:</th>
                <td>
                	<select name="typeId" class="wu-sel" id="typeId">
						<option value="">==请选择分类==</option>
						<option value=""></option>
					</select>
                </td>
            </tr>
             <tr>
                <th>显示顺序:</th>
                <td><input type="text" name="position" class="wu-text" /></td>
            </tr>
        </table>
    </form>
</div>
<!-- End of easyui-dialog -->
<script type="text/javascript">
var module="${module}";
var columns=[
  {checkbox : true}, 
  {field : 'objname',title : '设置项名称',width : 180,sortable : true}, 
  {field : 'idName',  title : '唯一标识',	width : 100,sortable : true},
  {field : 'objvalue',title : '设置项值',	width : 100}, 
  {field : 'typeid',  title : '类别',width : 100}, 
  {field : 'objdesc', title : '设置项描述',width : 100},
  {field : 'position',title : '显示顺序',	width : 100}, 
  {field : '_operator',title : '操作',width : 100,formatter:formatOper}
];
function formatOper(val, row, index) {
	return '<a href="javascript:void(0)" onclick="editUI(\''
			+ row.id
			+ '\')" class="edit easyui-linkbutton" ></a><a href="javascript:void(0)" onclick="remove(\''
			+ row.id + '\')" class="del easyui-linkbutton"></a>';
}
</script>
<script type="text/javascript" src="js/navi/navi-pageHandler.js"></script>