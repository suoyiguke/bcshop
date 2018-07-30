<%@page import="com.navi.report.model.SearchFieldType"%>
<%@page import="com.navi.report.model.ReportColumn"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String colNames="[";
	String colModel="[";
	List<ReportColumn> cols=(List<ReportColumn>)request.getAttribute("reportColumnList");
	for(int i=0;i<cols.size();i++){
		ReportColumn col=cols.get(i);
		String sort=",sortable:false";
		String frozen=",frozen:false";
		String width=",width:150";
		if(col.getIsSort()==1){
			sort=",sortable:true";
		}
		if(col.getIsFrozen()==1){
			frozen=",frozen:true";
		}
		if(col.getWidthPercent()!=0){
			width=",width:"+col.getWidthPercent();
		}
		colNames+="'"+col.getObjname()+"'";
		colModel+="{'name':'"+col.getColName()+"','index':'"+col.getColName()+"'"+sort+frozen+width+"}";
		if(i!=cols.size()-1){
			colNames+=",";
			colModel+=",";
		}
	}
	colModel+="]";
	colNames+="]";
	List<ReportColumn> searchColumnList=(List<ReportColumn>)request.getAttribute("searchColumnList");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	 <base href="<%=basePath%>">
    <title></title>
    <%@include file="/public/common.jsp" %>
	<link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
    <link rel="stylesheet" href="<%=basePath %>js/jqGrid4.6/css/ui.jqgrid.css"/>
    <link rel="stylesheet" href="<%=basePath %>js/jqueryui/css/redmond/jquery-ui-1.10.4.custom.min.css"/>
    <script type="text/javascript" src="<%=basePath %>js/jqueryui/jquery-ui-1.10.4.custom.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jqGrid4.6/js/i18n/grid.locale-cn.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jqGrid4.6/js/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableGrid.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-popWin.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/datepicker/My97DatePicker/WdatePicker.js"></script>
    <style type="text/css">
    	
    </style>
    <script type="text/javascript">
    	function deleteRows(){
    		var ids= $("#list").jqGrid('getGridParam','selarrrow');
    		if(ids!=""&&ids.length>0&& confirm('您确定要删除吗？')){
    			$.post("<%=basePath%>reportTable/delete.do",{ids:ids.toString()},function(data){
	    			if(data=="ok"){
	    				reloadGrid($("#list"));
	    			}
    			});
    		}
    	}
    	function deleteRow(id){
    		if(confirm('您确定要删除吗？')){
    			$.post("<%=basePath%>reportTable/delete.do",{ids:id},function(data){
	    			if(data=="ok"){
	    				reloadGrid($("#list"));
	    			}
    			});
    		}
    	}
    	
    	function editRow(el,id,tabName){
    		var url="reportTable/detail.do?id="+id+"&selectItemId=${requestScope.selectItemId}";
    		window.parent.addTab(el,tabName+"-报表",url);
    	}
    	
    	function search(){
			var postData={};
			$(".searchBar input").each(function(){
				var c=$(this);
				postData[c.attr("name")]=c.val();
			});
			jQuery("#list").jqGrid('setGridParam',
			{
				url:"<%=basePath%>reportTable/jqgridJsonList.do",
				page:1,
				postData:postData
			}).trigger("reloadGrid");
		}
		
		$(function(){
			var colNames=['id'];
			var cNames=eval("(<%=colNames%>)");
			var cModel=eval("(<%=colModel%>)");
			colNames=colNames.concat(cNames);
			var colModel=[
		   		{name:"id",index:"id",hidden:true,frozen:true}
			 ];
			 colModel=colModel.concat(cModel);
			 var width=$("#warper").width();
			 var url="<%=basePath%>reportTable/jqgridJsonList.do?id=${requestScope.reportTable.id}";
			 $("#list").naviGrid({colNames:colNames,colModel:colModel,width:width,url:url});
		});
    </script>
  </head>
 <body>
 	<div id="warper">
 		<div class="nav">
  			系统设置> 报表 > ${requestScope.reportTable.objname }
  		</div>
  		<div class="toolbar" >
  			<button class="btn" onclick="search();">搜索(S)</button>
  		</div>
  		<form action="<%=basePath%>reportTable/jqgridJsonList.do" method="post">
	  		<div class="searchbar">
	  			<input type="hidden" name="id" value="${requestScope.reportTable.id}"/>
	  			<table>
	  				
					<%
					for(int i=0;i<searchColumnList.size();i++){ 
						ReportColumn rc=searchColumnList.get(i);
					%>
						<%if((i%3)==0){%>
							<tr>
						<%} %>
						<th><%=rc.getObjname() %></th>
						<td>
						<%if(SearchFieldType.TEXT.equals(rc.getSearchFieldType())){ %>
							<input type="text" name="<%=rc.getColName() %>"  id="<%=rc.getColName() %>" value=""/>
						<%}else if(SearchFieldType.DATE.equals(rc.getSearchFieldType())){ %>
							<input readonly="readonly" style="width:100px;"class="Wdate" type="text" onclick="WdatePicker({isShowWeek:true})" id="<%=rc.getColName() %>_begin" name="<%=rc.getColName() %>_begin">-
							<input readonly="readonly"  style="width:100px;" class="Wdate" type="text" onclick="WdatePicker({isShowWeek:true})" id="<%=rc.getColName() %>_end" name="<%=rc.getColName() %>_end">
							<a onclick="clearValue('<%=rc.getColName()%>_begin','<%=rc.getColName() %>_end');" href="javascript:void(0);">清除</a>
						<%}else if(SearchFieldType.SELECTITEM.equals(rc.getSearchFieldType())){ %>
							<input type="hidden"  id="<%=rc.getColName() %>" name="<%=rc.getColName() %>" value=""/>
		                	<input readOnly="readOnly" type="text" onclick="popWin('<%=basePath %>selectitem/selectList.do?pid=<%=rc.getSearchBrowserValue()%>','<%=rc.getColName() %>','<%=rc.getColName() %>_name')" id="<%=rc.getColName() %>_name" value=""name="<%=rc.getColName() %>_name"/>
		                	<button type="button" class="browser"  onclick="popWin('<%=basePath %>selectitem/selectList.do?pid=<%=rc.getSearchBrowserValue()%>','<%=rc.getColName() %>','<%=rc.getColName() %>_name')">
		                	</button>
							<a onclick="clearValue('<%=rc.getColName()%>','<%=rc.getColName() %>_name');" href="javascript:void(0);">清除</a>
						<%}else if(SearchFieldType.REFOBJ.equals(rc.getSearchFieldType())){ %>
							<input type="hidden"  id="<%=rc.getColName() %>" name="<%=rc.getColName() %>" value=""/>
		                	<input readOnly="readOnly" onclick="popWin('<%=basePath %>refobj/browser.do?id=<%=rc.getSearchBrowserValue()%>','<%=rc.getColName() %>','<%=rc.getColName() %>_name')" type="text" id="<%=rc.getColName() %>_name" value=""name="<%=rc.getColName() %>_name"/>
		                	<button type="button" class="browser" onclick="popWin('<%=basePath %>refobj/browser.do?id=<%=rc.getSearchBrowserValue()%>','<%=rc.getColName() %>','<%=rc.getColName() %>_name')">
		                	</button>
							<a onclick="clearValue('<%=rc.getColName()%>','<%=rc.getColName() %>_name');" href="javascript:void(0);">清除</a>
						<%}else{%>
							<input type="text" name="<%=rc.getColName() %>"  id="<%=rc.getColName() %>" value=""/>
						<%} %>
						</td>
						<%if((i!=0)&&((i-2)%3)==0){ 
						%>
							</tr>
						<%} 
					}
					%>
	  			</table>
	  		</div>
			<table id="list"></table>
			<div id="pager"></div>
		</form>
	</div>
</body>
</html>