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
    <base href="<%=basePath%>" >
    <title></title>
     <%@include file="/public/common.jsp" %>
    <link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
    <link  rel="stylesheet" href="<%=basePath %>js/jsPanel/jquery-ui.min.css" type="text/css"/>
    <link  rel="stylesheet" href="<%=basePath %>js/jsPanel/jquery.jspanel.css" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>js/jsPanel/mobile-detect.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jsPanel/jquery-ui.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jsPanel/jquery.jspanel.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-checkAll.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-batchDelete.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-delete.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-panel.js"></script>
	<script type="text/javascript">
		$(function(){
			//鼠标移动换色
			$(".tabList").naviTableList();
			//批量删除
			$("#delBtn").naviBatchDelete({url:"<%=basePath %>humres/delete.do"});
			//单个删除
			$(".fam-cross").naviDelete({url:"<%=basePath %>humres/delete.do"});
			//全选、反选
			$("#chkAll").naviCheckAll();
			$("#searchBtn").click(function(){
				$("#NaviForm").submit();
			});
			//编辑弹出层
			$(".fam-pencil").naviPanel();
			//$("#addUIBtn").naviPanel({selector:"naviPanel",theme:"lightBlue"});
			//添加弹出层
			$("#addUIBtn").naviPanel();
			$("span.getFieldNameById").naviGetFieldNameById();
		});
	</script>
  </head>
 <body>
 	<div id="naviPanel"></div>
	<div id="wraper">
		<div class="nav">
			系统设置> 人员列表
		</div>
		<div class="toolbar" >
			<button class="btn" id="searchBtn">搜索(S)</button>
			<button class="btn"  w="600" h="320" url="<%=basePath%>humres/addUI.do" title="角色新增" id="addUIBtn">新增(N)</button>
			<button class="btn" id="delBtn" chkListCls="chkList">删除(D)</button>
		</div>
		<form id="NaviForm" action="<%=basePath %>humres/list.do" method="post">
		<div class="searchbar">
			<table>
				<tr>
					<th>姓名</th>
					<td>
						<input type="text" name="objname"  value="${requestScope.humres.objname }"/>
					</td>
					<th>账号</th>
					<td>
						<input type="text" name="objno"  value="${requestScope.humres.objno }"/>
					</td>
				</tr>
			</table>
		</div>
		<div>
			<table class="tabList">
				<colgroup>
					<col width="4%">
					<col width="15%">
					<col width="15%">
					<col width="8%">
					<col width="20%">
					<col width="20%">
					<col width="8%">
					<col width="10%">
				</colgroup>
				<tr>
					<th><input type="checkbox" chkListCls="chkList" id="chkAll"/></th>
					<th>姓名</th>
					<th>账号</th>
					<th>账号状态</th>
					<th>组织</th>
					<th>岗位</th>
					<th>顺序</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
				<tr>
					<td>
						<input type="checkbox" class="chkList" id="${s.id }"/>
					</td>
					<td>${s.objname }</td>
					<td>${s.objno }</td>
					<td></td>
					<td><span id="${s.orgId }" tableName="org" fieldName="namepath" class="getFieldNameById"></span></td>
					<td><span id="${s.stationId }" tableName="station" fieldName="objname" class="getFieldNameById"></span></td>
					<td>${s.position }</td>
					<td>
						&nbsp;&nbsp;
						<i class="fam-pencil" w="600" h="320" id="${s.id }" url="<%=basePath%>humres/editUI.do?id=${s.id}" style="cursor:pointer" title="资源修改"></i>&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="fam-cross" id="${s.id }" style="cursor:pointer" title="删除"></i>
					</td>
				</tr>
				</c:forEach>
			</table>
			<%@include file="/public/pagination.jsp" %>
		 </div>
		 </form>
	</div>
</body>
</html>