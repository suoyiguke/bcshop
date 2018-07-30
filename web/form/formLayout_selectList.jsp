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
  			系统设置> 表单布局列表>
  		</div>
  		<div class="toolbar" >
  			<button class="btn" onclick="search();">搜索(S)</button>
  			<button class="btn" onclick="clearSelect('${requestScope.inputId}','${requestScope.inputName }');">清除(C)</button>
  		</div>
  		<form id="NaviForm" name="NaviForm" action="<%=basePath %>selectitem/selectList.do" method="post">
  		<div class="searchbar">
  			<table>
  				<tr>
  					<th>选择项名称</th>
  					<td>
  					<input type="text" name="objname"  id="objname" value="${requestScope.selectitem.objname }"/>
  					<input type="hidden" name="pid" value="${requestScope.selectitem.pid }" id="pid"/>
  					<input type="hidden" name="inputId" value="${requestScope.inputId }" id="inputId"/>
  					<input type="hidden" name="inputName" value="${requestScope.inputName }" id="inputName"/>
  					</td>
  					<th>选择项描述</th>
  					<td><input type="text" name="description" id="description" value="${requestScope.selectitem.objdesc }"/></td>
  					<c:if test="${empty requestScope.parent }">
  					<th>分类</th>
  					<td>
  						<select name="selectitemId" id="selectitemId">
  							<option value="">==请选择分类==</option>
  							<c:forEach items="${requestScope.itemTypeList }" var="s">
  								<option value="${s.id }">${s.objname }</option>
  							</c:forEach>
  						</select>
  					</td>
  					</c:if>
  				</tr>
  			</table>
  		</div>
  		<div>
  			<table class="tabList">
  				<tr>
  					<th>选择项名称</th>
  					<th>选择项描述</th>
  				</tr>
  				<c:forEach items="${requestScope.pageBean.recordList }" var="s" >
  				<tr style="cursor:pointer;" onclick="singleSelect('${requestScope.inputId }','${requestScope.inputName }','${s.id }','${s.objname }');">
  					<td>${s.objname }</td>
  					<td>${s.objdesc }</td>
  				</tr>
  				</c:forEach>
  			</table>
  		</div>
  		<%@include file="/public/pagination.jsp" %>
  		</form>
	</div>
</body>
</html>