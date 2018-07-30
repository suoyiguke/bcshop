<%@page import="com.navi.utils.IPage"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
			$("#delBtn").naviBatchDelete({url:"<%=basePath %>website/mail/delete.do"});
			//单个删除
			$(".fam-cross").naviDelete({url:"<%=basePath %>website/mail/delete.do"});
			//全选、反选
			$("#chkAll").naviCheckAll();
			$("#searchBtn").click(function(){
				$("#NaviForm").submit();
			});
			//编辑弹出层
			$(".fam-pencil").naviLayer();
			//$("#addUIBtn").naviPanel({selector:"naviPanel",theme:"lightBlue"});
			//添加弹出层
			$("#addUIBtn").naviLayer();
			//类型
			$("span.getFieldNameById").naviGetFieldNameById();
		});
	</script>
  </head>
 <body>
 	<div id="naviPanel"></div>
	<div id="wraper">
		<div class="nav">
			系统设置> 留言列表
		</div>
		<div class="toolbar" >
			<button class="btn" id="searchBtn">搜索(S)</button>
			<button class="btn" id="delBtn" chkListCls="chkList">删除(D)</button>
		</div>
		<form id="NaviForm" action="<%=basePath %>website/mail/list.do" method="post">
		<div class="searchbar">
			<table>
				<tr>
					<th>标题</th>
					<td>
						<input type="text" name="objname"  value="${requestScope.mail.objname }"/>
					</td>
					<th>姓名</th>
					<td>
						<input type="text" name="username"  value="${requestScope.mail.username }"/>
					</td>
					<th>公司名称</th>
					<td>
						<input type="text" name="companyname"  value="${requestScope.mail.companyname }"/>
					</td>
				</tr>
			</table>
		</div>
		<div>
			<table class="tabList">
				<colgroup>
					<col width="4%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="">
					<col width="15%">
					<col width="8%">
				</colgroup>
				<tr>
					<th><input type="checkbox" chkListCls="chkList" id="chkAll"/></th>
					<th>标题</th>
					<th>姓名</th>
					<th>邮件地址</th>
					<th>电话</th>
					<th>公司名称</th>
					<th>创建日期</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
				<tr>
					<td>
						<input type="checkbox" class="chkList" id="${s.id }"/>
					</td>
					<td>${s.objname }</td>
					<td>${s.username }</td>
					<td>
						${s.email }
					</td>
					<td>
						${s.tel }
					</td>
					<td>
						${s.companyname }
					</td>
					<td>${s.createdate }</td>
					<td>
						&nbsp;&nbsp;
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