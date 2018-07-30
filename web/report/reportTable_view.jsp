<%@page import="com.navi.utils.StringUtils"%>
<%@page import="com.navi.utils.IPage"%>
<%@page import="com.navi.report.model.SearchFieldType"%>
<%@page import="com.navi.report.model.ReportColumn"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	IPage pageBean=(IPage)request.getAttribute("pageBean");
	List<ReportColumn> searchColumnList=(List<ReportColumn>)request.getAttribute("searchColumnList");
	List<ReportColumn> reportColumnList=(List<ReportColumn>)request.getAttribute("reportColumnList");
	Map<String,String> searchMap=(Map<String,String>)request.getAttribute("searchMap");
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
    	function search(){
			/*var postData={};
			$(".searchBar input").each(function(){
				var c=$(this);
				postData[c.attr("name")]=c.val();
			});*/
			$('#NaviForm').submit();
		}
		
		$(function(){
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
  		<form id="NaviForm" action="<%=basePath%>reportTable/view.do" method="post">
	  		<div class="searchbar">
	  			<input type="hidden" name="id" value="${requestScope.reportTable.id}"/>
	  			<table>
					<%
					for(int i=0;i<searchColumnList.size();i++){ 
						ReportColumn rc=searchColumnList.get(i);
					%>
						<%if(i%3==0){ %>
							<tr>
						<%} %>
						<th><%=rc.getObjname() %></th>
						<td>
						<%if(SearchFieldType.TEXT.equals(rc.getSearchFieldType())){ %>
							<input type="text" name="<%=rc.getColName() %>"  id="<%=rc.getColName() %>" value="<%=StringUtils.trim(searchMap.get(rc.getColName()))%>"/>
						<%}else if(SearchFieldType.DATE.equals(rc.getSearchFieldType())){ %>
							<input readonly="readonly" style="width:100px;"class="Wdate" type="text"  value="<%=StringUtils.trim(searchMap.get(rc.getColName()+"_begin")) %>" onclick="WdatePicker({isShowWeek:true})" id="<%=rc.getColName() %>_begin" name="<%=rc.getColName() %>_begin">-
							<input readonly="readonly"  style="width:100px;" class="Wdate" type="text" value="<%=StringUtils.trim(searchMap.get(rc.getColName()+"_end")) %>" onclick="WdatePicker({isShowWeek:true})" id="<%=rc.getColName() %>_end" name="<%=rc.getColName() %>_end">
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
						<%if((i!=0)&&((i-2)%3)==0){ %>
							</tr>
						<%} 
					}
					%>
	  			</table>
	  		</div>
			<div>
			<table class="tabList">
				<colgroup>
					<col width="4%">
				<%
					for(int i=0;i<reportColumnList.size();i++){
						ReportColumn rc=reportColumnList.get(i);
					%>
					<col width="<%=rc.getWidthPercent() %>">
					<%} %>
				</colgroup>
				<tr>
					<th><input type="checkbox" chkListCls="chkList" id="chkAll"/></th>
					<%
					for(int i=0;i<reportColumnList.size();i++){
						ReportColumn rc=reportColumnList.get(i);
					%>
					<th><%=rc.getObjname() %></th>
					<%} %>
				</tr>
				<%
				List<Map<String,Object>> list=pageBean.getRecordList();
				for(int i=0;i<list.size();i++){ 
					Map<String,Object> map=list.get(i);
				%>
				<tr>
					<td>
						<input type="checkbox" class="chkList" id="<%=map.get("id")%>"/>
					</td>
					<%
					for(int j=0;j<reportColumnList.size();j++){
						ReportColumn rc=reportColumnList.get(j);
					%>
					<td><%=StringUtils.trim(map.get(rc.getColName())) %></td>
					<%} %>
				</tr>
				<%} %>
			</table>
			<%@include file="/public/pagination.jsp" %>
		 </div>
		</form>
	</div>
</body>
</html>