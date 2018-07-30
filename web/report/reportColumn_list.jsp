<%@page import="com.navi.utils.IPage"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>" >
    <title></title>
    <%@include file="/public/common.jsp" %>
	<link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
    <link rel="stylesheet" href="<%=basePath %>js/jqGrid4.6/css/ui.jqgrid.css"/>
    <link rel="stylesheet" href="<%=basePath %>js/jqueryui/css/redmond/jquery-ui-1.10.4.custom.min.css"/>
    <script type="text/javascript" src="<%=basePath %>js/jqueryui/jquery-ui-1.10.4.custom.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jqGrid4.6/js/i18n/grid.locale-cn.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jqGrid4.6/js/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableGrid.js"></script>
	<script type="text/javascript">
		function search(){
			var columnName=$("#objname").val();
			var description=$("#description").val();
			var selectItemId=$("#selectItemId").val();
			jQuery("#list").jqGrid('setGridParam',{url:"columnInfo/jsonList.do?columnName="+columnName+"&selectItemId="+selectItemId+"&description="+description,page:1}).trigger("reloadGrid");
		}
		function deleteRows(){
    		var ids= $("#list").jqGrid('getGridParam','selarrrow');
    		if(ids!=""&&ids.length>0&& confirm('您确定要删除吗？')){
    			$.post("<%=basePath%>columnInfo/delete.do",{ids:ids.toString()},function(data){
	    			if(data=="ok"){
	    				reloadGrid($("#list"));
	    			}
    			});
    		}
    	}
    	function deleteRow(id){
    		if(confirm('您确定要删除吗？')){
    			$.post("<%=basePath%>columnInfo/delete.do",{ids:id},function(data){
	    			if(data=="ok"){
	    				reloadGrid($("#list"));
	    			}
    			});
    		}
    	}
    	
    	function editRow(id){
    		var url="columnInfo/editUI.do?id="+id+"&selectItemId=${requestScope.selectItemId}";
    		location.href=url;
    	}
    	
		$(function(){
			   var url="<%=basePath%>columnInfo/jsonList.do?tableInfoId=${requestScope.tableInfo.id}";
			   var width=$("#wraper").width();
			   var colNames=['id','字段名称','字段描述','字段类型', '顺序','操作'];
			   var colModel=[
			   		{name:"id",hidden:true,index:"id",width:70},
			   		{name:'columnName',index:'columnName', width:55},
			   		{name:'description',index:'description', width:100},
			   		{name:'columnType',index:'columnType', width:30},
			   		{name:'position',index:'position', width:30},
			   		{name:'act',index:'act', width:35,sortable:false,align:'center'}
				];
				var gridComplete=function(){
				 	var grid=$("#list");
				 	var ids = grid.jqGrid('getDataIDs');
					for(var i=0;i < ids.length;i++){
						var cl = ids[i];
						var ret = grid.jqGrid('getRowData',cl);
						var be = "<i class=\"fam-pencil\" style=\"cursor:pointer\" onclick=\"editRow('"+ret.id+"')\" title=\"编辑\"></i>&nbsp;"; 
						var se = "<i class=\"fam-cross\" style=\"cursor:pointer\" onclick=\"deleteRow('"+ret.id+"')\" title=\"删除\"></i>&nbsp;";
						var showType="";
						if(ret.columnType=="TEXT_SIMPLE"){
							showType="单行文本";
						}else if(ret.columnType=="TEXTAREA"){
							showType="多行文本";
						}else if(ret.columnType=="INT"){
							showType="整型";
						}else if(ret.columnType=="DOUBLE"){
							showType="浮点型";
						}else if(ret.columnType=="DATE"){
							showType="日期";
						}else if(ret.columnType=="SELECT_ITEM"){
							showType="选择项";
						}else if(ret.columnType=="REF_OBJ"){
							showType="关联对象";
						}else if(ret.columnType=="RICH_TEXT"){
							showType="富文本";
						}else if(ret.columnType=="TIME"){
							showType="时间";
						}else if(ret.columnType=="CHECKBOX"){
							showType="checkbox";
						}else if(ret.columnType=="DATETIME"){
							showType="日期时间";
						}else if(ret.columnType=="REF_OBJ_MULTI"){
							showType="关联对象多选";
						}else if(ret.columnType=="SELECT_ITEM_MULTI"){
							showType="选择项多选";
						}else if(ret.columnType=="FILE"){
							showType="附件";
						}else if(ret.columnType=="FILES"){
							showType="附件多个";
						}else if(ret.columnType=="PICTURE"){
							showType="图片";
						}else if(ret.columnType=="PICTURES"){
							showType="图片多个";
						}
						var setting="<a style=\"color:blue;\" onclick=\"setting('"+ret.id+"');\" href=\"javascript:void(0);\">设置</a>";
						grid.jqGrid('setRowData',ids[i],{act:be+se,columnType:showType,setting:setting});
					}	
				};
				$("#list").naviGrid({url:url,colNames:colNames,colModel:colModel,width:width,gridComplete:gridComplete});
		});
	</script>
  </head>
 <body>
<div id="wraper">
	<div class="nav">
  			系统设置> 字段列表>
  		</div>
  		<div class="toolbar" >
  			<button class="btn" onclick="search();">搜索(S)</button>
  			<button class="btn" onclick="location.href='<%=basePath%>columnInfo/addUI.do?tableInfoId=${requestScope.tableInfo.id}'">新增(A)</button>
  			<button class="btn" onclick="deleteRows();">删除(D)</button>
  		</div>
  		<div class="searchbar">
  			<table>
  				<tr>
  					<th>字段名称</th>
  					<td><input type="text" name="objname"  id="objname" value=""/></td>
  					<th>字段描述</th>
  					<td><input type="text" name="description"  id="description" value=""/></td>
  				</tr>
  			</table>
  		</div>
		<table id="list"></table>
		<div id="pager"></div>
	</div>
</body>
</html>