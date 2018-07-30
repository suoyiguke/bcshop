<%@page import="com.navi.utils.StringUtils"%>
<%@page import="com.navi.report.model.SearchFieldType"%>
<%@page import="com.navi.utils.IPage"%>
<%@page import="com.navi.report.model.Refobj"%>
<%@page import="com.navi.report.model.ReportColumn"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	IPage pageBean=(IPage)request.getAttribute("pageBean");
	List<ReportColumn> showHeaderList=(List<ReportColumn>)request.getAttribute("showHeaderList");
	List<ReportColumn> searchFieldList=(List<ReportColumn>)request.getAttribute("searchFieldList");
	Map<String,String> searchMap=(Map<String,String>)request.getAttribute("searchMap");
	String inputId=(String)request.getAttribute("inputId");
	String inputName=(String)request.getAttribute("inputName");
	Refobj refObj=(Refobj)request.getAttribute("refObj");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
	<base href="<%=basePath%>" >
    <title></title>
    <%@include file="/public/common.jsp" %>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-browse_select.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/datepicker/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
    <style type="text/css">
    	
    </style>
    <script type="text/javascript">
    	$(function(){
    		$(".tabList").naviTableList();
    		$(".getFieldNameById").naviGetFieldNameById({idKey:"dataKey"});
    	});
    	function search(){
    		$("#NaviForm").submit();
    	}
    </script>
  </head>
 <body>
	<form id="NaviForm" name="NaviForm" action="<%=basePath %>refobj/browser.do" method="post">
 	<div id="warper">
  		<div class="toolbar" >
  			<button class="btn" type="button" onclick="clearSelect('${requestScope.inputId }','${requestScope.inputName }');">清除(C)</button>
  			<button class="btn" type="button" onclick="search();">搜索(S)</button>
  		</div>
  		<input type="hidden" name="id"  value="${requestScope.refObj.id }"/>
  		<div class="searchbar">
  			<table>
  				<%
					for(int i=0;i<searchFieldList.size();i++){ 
						ReportColumn rc=searchFieldList.get(i);
						if("id".equalsIgnoreCase(rc.getObjname())){
							continue;
						}
					%>
						<%if(i%3==0){ %>
							<tr>
						<%} %>
						<th><%=rc.getObjname() %></th>
						<td>
						<%if(SearchFieldType.TEXT.equals(rc.getSearchFieldType())){ 
						%>
							<input type="text" name="<%=rc.getColName() %>"  id="<%=rc.getColName() %>" value="<%=StringUtils.trim(searchMap.get(rc.getColName())) %>"/>
						<%}else if(SearchFieldType.DATE.equals(rc.getSearchFieldType())){ %>
							<input readonly="readonly" style="width:100px;"class="Wdate" type="text" value="<%=StringUtils.trim(searchMap.get(rc.getColName()+"_begin")) %>" onclick="WdatePicker({isShowWeek:true})" id="<%=rc.getColName() %>_begin" name="<%=rc.getColName() %>_begin">-
							<input readonly="readonly"  style="width:100px;" class="Wdate" type="text" value="<%=StringUtils.trim(searchMap.get(rc.getColName()+"_end")) %>"onclick="WdatePicker({isShowWeek:true})" id="<%=rc.getColName() %>_end" name="<%=rc.getColName() %>_end">
							<a onclick="clearValue('<%=rc.getColName() %>_begin','<%=rc.getColName() %>_end');" href="javascript:void(0);">清除</a>
						<%}else if(SearchFieldType.SELECTITEM.equals(rc.getSearchFieldType())){ %>
							<input type="hidden"  id="<%=rc.getColName() %>" name="<%=rc.getColName() %>" value="<%=StringUtils.trim(searchMap.get(rc.getColName()))%>"/>
		                	<input class="getFieldNameById" tableName="selectitem" fieldName="objname"  readOnly="readOnly" type="text" onclick="popWin('<%=basePath %>selectitem/selectList.do?pid=<%=rc.getSearchBrowserValue()  %>','<%=rc.getColName() %>','<%=rc.getColName() %>_name')" id="<%=rc.getColName() %>_name" dataKey="<%=StringUtils.trim(searchMap.get(rc.getColName())) %>" value="" name="<%=rc.getColName() %>_name"/>
		                	<button type="button" class="browser" onclick="popWin('<%=basePath %>selectitem/selectList.do?pid=<%=rc.getSearchBrowserValue()  %>','<%=rc.getColName() %>','<%=rc.getColName() %>_name')">
		                	</button>
	                		<a onclick="clearValue('<%=rc.getColName() %>','<%=rc.getColName() %>_name');" href="javascript:void(0);">清除</a>
						<%}else if(SearchFieldType.REFOBJ.equals(rc.getSearchFieldType())){ %>
							<input type="text" name="<%=rc.getColName() %>"  id="<%=rc.getColName() %>" value=""/>
						<%}else{%>
							<input type="text" name="<%=rc.getColName() %>"  id="<%=rc.getColName() %>" value="<%=StringUtils.trim(searchMap.get(rc.getColName())) %>"/>
						<%} %>
						</td>
						<%if(i!=0&&i%3==0){ %>
							</tr>
						<%} 
					}
					%>
  				
  			</table>
  		</div>
  		<div class="tab">
			<table class="tabList">
				<tr>
					<%for(ReportColumn c:showHeaderList){ %>
						<%if(!"id".equalsIgnoreCase(c.getObjname())){ %>
						<th><%=c.getObjname() %></th>
						<%} %>
					<%}%>
				</tr>
				<%
					List<Map<String,Object>> list=pageBean.getRecordList();
					for(int i=0;i<list.size();i++){
						Map<String,Object> map=list.get(i);
				 %>
				<tr style="cursor:pointer;" onclick="selectRefobj('<%=map.get(refObj.getIdField())%>','<%=map.get(refObj.getShowField())%>');">
					<%
					for(ReportColumn tf:showHeaderList){
						if("id".equalsIgnoreCase(tf.getColName())){
							continue;
						}
					%>
					<td><%=StringUtils.trim(map.get(tf.getColName())) %></td>
					<%
					}
					%>	
				</tr>
				<%	} %>
				
			</table>
      	</div>
      	<%@include file="/public/pagination.jsp" %>
	</div>
	</form>
</body>
</html>