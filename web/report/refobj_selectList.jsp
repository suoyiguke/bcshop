<%@page import="com.navi.utils.IPage"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	IPage pageBean=(IPage)request.getAttribute("pageBean");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
	<base href="<%=basePath%>" >
    <title></title>
    <%@include file="/public/common.jsp" %>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-browse_select.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
    <style type="text/css">
    </style>
    <script type="text/javascript">
    	function search(){
    		$("#NaviForm").submit();
    	}
    	$(function(){
    		$(".tabList").naviTableList();
    	});
    </script>
  </head>
 <body>
 	<div id="warper">
 		<div class="nav">
  			系统设置> 选择项列表>
  		</div>
  		<div class="toolbar" >
  			<button class="btn" onclick="search();">搜索(S)</button>
  			<button class="btn" onclick="clearSelect('${requestScope.inputId}','${requestScope.inputName }');">清除(C)</button>
  		</div>
  		<form id="NaviForm" name="NaviForm" action="<%=basePath %>refobj/selectList.do" method="post">
  		<div class="searchbar">
  			<table>
  				<tr>
  					<th>选择项名称</th>
  					<td>
  					<input type="text" name="objname"  id="objname" value="${requestScope.refobj.objname }"/>
  					<input type="hidden" name="inputId" value="${requestScope.inputId }" id="inputId"/>
  					<input type="hidden" name="inputName" value="${requestScope.inputName }" id="inputName"/>
  					</td>
  				</tr>
  			</table>
  		</div>
  		<div>
  			<table class="tabList">
  				<tr>
  					<th>关联项名称</th>
  				</tr>
  				<c:forEach items="${requestScope.pageBean.recordList }" var="s" >
  				<tr style="cursor:pointer;" onclick="selectRefobj('${s.id }','${s.objname }');">
  					<td>${s.objname }</td>
  				</tr>
  				</c:forEach>
  			</table>
  		</div>
  		<%@include file="/public/pagination.jsp" %>
  		</form>
	</div>
</body>
</html>