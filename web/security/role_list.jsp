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
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-checkAll.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-batchDelete.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-delete.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/layer/layer.js"></script>
    <link  rel="stylesheet" href="<%=basePath %>js/layer/skin/layer.css" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-layer.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
	<script type="text/javascript">
		$(function(){
			//鼠标移动换色
			$(".tabList").naviTableList();
			//批量删除
			$("#delBtn").naviBatchDelete({url:"<%=basePath %>role/delete.do"});
			//单个删除
			$(".fam-cross").naviDelete({url:"<%=basePath %>role/delete.do"});
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
			//类型
			$("span.getFieldNameById").naviGetFieldNameById();
		});
	</script>
  </head>
 <body>
 	<div id="naviPanel"></div>
	<div id="wraper">
		<div class="nav">
			系统设置> 角色列表
		</div>
		<div class="toolbar" >
			<button class="btn" id="searchBtn">搜索(S)</button>
			<button class="btn" w="600" h="260" t="50" url="<%=basePath%>role/addUI.do" title="角色新增" id="addUIBtn">新增(N)</button>
			<button class="btn" id="delBtn" chkListCls="chkList">删除(D)</button>
		</div>
		<form id="NaviForm" action="<%=basePath %>role/list.do" method="post">
		<div class="searchbar">
			<table>
				<tr>
					<th>名称</th>
					<td>
						<input type="text" name="objname"  value="${requestScope.role.objname }"/>
					</td>
					<th>描述</th>
					<td>
						<input type="text" name="objdesc"  value="${requestScope.role.objdesc }"/>
					</td>
					<th>分类</th>
					<td>
						<select name="typeId" id="typeId">
  							<option value="">==请选择分类==</option>
  							<c:forEach items="${requestScope.itemTypeList }" var="s">
  								<option value="${s.id }" <c:if test="${s.id==requestScope.role.typeId }">selected="selected"</c:if>>${s.objname }</option>
  							</c:forEach>
  						</select>
					</td>
				</tr>
			</table>
		</div>
		<div>
			<table class="tabList">
				<colgroup>
					<col width="4%">
					<col width="15%">
					<col width="">
					<col width="15%">
					<col width="10%">
					<col width="13%">
				</colgroup>
				<tr>
					<th><input type="checkbox" chkListCls="chkList" id="chkAll"/></th>
					<th>角色名称</th>
					<th>描述</th>
					<th>分类</th>
					<th>顺序</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
				<tr>
					<td>
						<input type="checkbox" class="chkList" id="${s.id }"/>
					</td>
					<td>${s.objname }</td>
					<td>${s.objdesc }</td>
					<td><span id="${s.typeId }" tableName="itemType" fieldName="objname" class="getFieldNameById"></span></td>
					<td>${s.position }</td>
					<td>
						&nbsp;&nbsp;
						<i class="fam-pencil" id="${s.id }" w="600" h="280" t="50"  url="<%=basePath%>role/editUI.do?id=${s.id}" style="cursor:pointer" title="类型修改"></i>&nbsp;&nbsp;&nbsp;&nbsp;
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