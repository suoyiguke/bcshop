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
			$("#delBtn").naviBatchDelete({url:"<%=basePath %>pipeInfo/delete.do"});
			//单个删除
			$(".fam-cross").naviDelete({url:"<%=basePath %>pipeInfo/delete.do"});
			//全选、反选
			$("#chkAll").naviCheckAll();
			$("#searchBtn").click(function(){
				$("#NaviForm").submit();
			});
			//编辑弹出层
			$(".fam-pencil").naviLayer();
			$(".go_detail").click(function(){
				var tabName=$(this).attr("objname");
				var url="pipeInfo/detail.do?id="+$(this).attr("id");
	    		window.parent.addTab(tabName,url);
			});
			$(".fam-table-go").click(function(){
				var tabName=$(this).attr("objname");
				var url="pipeInfo/detail.do?id="+$(this).attr("id");
	    		window.parent.addTab(tabName,url);
			});
			//$("#addUIBtn").naviPanel({selector:"naviPanel",theme:"lightBlue"});
			//添加弹出层
			$("#addUIBtn").naviLayer();
			//类型
			$("span.getFieldNameById").naviGetFieldNameById();
			$(".addWorkflow").click(function(){
				window.open("workflow/addUI.do?pipeId="+$(this).attr("id"));
			});
		});
	</script>
  </head>
 <body>
 	<div id="naviPanel"></div>
	<div id="wraper">
		<div class="nav">
			系统设置> 流程列表
		</div>
		<div class="toolbar" >
			<button class="btn" id="searchBtn">搜索(S)</button>
			<!--  <button class="btn" isModal="0" w="450" h="230",t="center" ctrBtn="all" url="pipeInfo/addUI.do" title="类型新增" id="addUIBtn">新增(N)</button> -->
			<button class="btn" w="600" h="360" t="50" url="<%=basePath%>pipeInfo/addUI.do" title="设置项新增" id="addUIBtn">新增(N)</button>
			<button class="btn" id="delBtn" chkListCls="chkList">删除(D)</button>
		</div>
		<form id="NaviForm" action="<%=basePath %>pipeInfo/list.do" method="post">
		<div class="searchbar">
			<table>
				<tr>
					<th>名称</th>
					<td>
						<input type="text" name="objname"  value="${requestScope.pipeInfo.objname }"/>
					</td>
					<th>分类</th>
					<td>
						<select name="typeId">
							<option value="">==请选择分类==</option>
							<c:forEach items="${requestScope.typeList }" var="s">
								<option value="${s.id }" <c:if test="${s.id==requestScope.pipeInfo.typeId }">selected="selected"</c:if>>${s.objname }</option>
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
					<col width="">
					<col width="">
					<col width="">
					<col width="20%">
				</colgroup>
				<tr>
					<th><input type="checkbox" chkListCls="chkList" id="chkAll"/></th>
					<th>流程名称</th>
					<th>分类</th>
					<th>顺序</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
				<tr>
					<td>
						<input type="checkbox" class="chkList" id="${s.id }"/>
					</td>
					<td><a id="${s.id }" objname="${s.objname }" href="javascript:void(0);" class="go_detail">${s.objname }</a></td>
					<td><span class="getFieldNameById" tableName="selectitem" fieldName="objname" id="${s.typeId }"></span></td>
					<td>${s.position }</td>
					<td>
						&nbsp;&nbsp;
						<i class="fam-table-go" id="${s.id }" objname="${s.objname }" style="cursor:pointer" title="流程设置"></i>&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="fam-pencil" id="${s.id }" w="600" h="360" t="50"  url="<%=basePath%>pipeInfo/editUI.do?id=${s.id}" style="cursor:pointer" title="流程修改"></i>&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="fam-cross" id="${s.id }" style="cursor:pointer" title="删除"></i>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  id="${s.id }" class="addWorkflow">新建流程</a>
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