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
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/layer/layer.js"></script>
    <link  rel="stylesheet" href="<%=basePath %>js/layer/skin/layer.css" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-layer.js"></script>
	<script type="text/javascript">
		$(function(){
			//鼠标移动换色
			$(".tabList").naviTableList();
			//批量删除
			$("#delBtn").naviBatchDelete({url:"<%=basePath %>refobj/delete.do"});
			//单个删除
			$(".fam-cross").naviDelete({url:"<%=basePath %>refobj/delete.do"});
			//全选、反选
			$("#chkAll").naviCheckAll();
			$("#searchBtn").click(function(){
				$("#NaviForm").submit();
			});
			//添加弹出层
			$("#addUIBtn").naviLayer();
			//类型
			$("span.getFieldNameById").naviGetFieldNameById();
			//编辑弹出层
			$(".fam-pencil").naviLayer();
			$(".naviEdit").naviLayer();
			$(".fam-page-white").click(function(){
				var tabName=$(this).attr("objname");
				var url="refobj/browser.do?id="+$(this).attr("id");
	    		window.parent.addTab(tabName+"-预览",url);
			});
		});
	</script>
  </head>
 <body>
 	<div id="naviPanel"></div>
	<div id="wraper">
		<div class="nav">
			系统设置> 报表列表
		</div>
		<div class="toolbar" >
			<button class="btn" id="searchBtn">搜索(S)</button>
			<button class="btn" w="680"h="450" t="20" url="<%=basePath%>refobj/addUI.do" title="关联选择项新增" id="addUIBtn">新增(N)</button>
			<button class="btn" id="delBtn" chkListCls="chkList">删除(D)</button>
		</div>
		<form id="NaviForm" action="<%=basePath %>refobj/list.do" method="post">
		<div class="searchbar">
			<table>
				<tr>
					<th>名称</th>
					<td>
						<input type="text" name="objname"  value="${requestScope.refobj.objname }"/>
					</td>
					<th>数据库表名</th>
					<td>
						<input type="text" name="tabName"  value="${requestScope.refobj.tabName }"/>
					</td>
					<th>分类</th>
					<td>
  						<select name="typeId" id="typeId">
  							<option value="">==请选择分类==</option>
  							<c:forEach items="${requestScope.itemTypeList }" var="s">
  								<option value="${s.id }" <c:if test="${s.id==requestScope.refobj.typeId }">selected="selected"</c:if>>${s.objname }</option>
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
					<col width="10%">
					<col width="8%">
					<col width="6%">
					<col width="10%">
					<col width="10%">
					<col width="20%">
					<col width="12%">
					<col width="8%">
					<col width="12%">
				</colgroup>
				<tr>
					<th><input type="checkbox" chkListCls="chkList" id="chkAll"/></th>
					<th>名称</th>
					<th>数据库表名</th>
					<th>唯一标识</th>
					<th>显示ID</th>
					<th>显示Objname</th>
					<th>关联的链接</th>
					<th>分类</th>
					<th>顺序</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
				<tr>
					<td>
						<input type="checkbox" class="chkList" id="${s.id }"/>
					</td>
					<td><a id="${s.id }" class="naviEdit" w="650"h="380" t="20" url="<%=basePath%>refobj/editUI.do?id=${s.id}" style="cursor:pointer" title="关联选择项修改" href="javascript:void(0);">${s.objname }</a></td>
					<td>${s.tabName }</td>
					<td>${s.idName }</td>
					<td>${s.idField }</td>
					<td>${s.showField }</td>
					<td>${s.refUrl }</td>
					<td><span id="${s.typeId }" tableName="itemType" fieldName="objname" class="getFieldNameById"></span></td>
					<td>${s.position }</td>
					<td>
						&nbsp;&nbsp;
						<i class="fam-page-white" id="${s.id }" objname="${s.objname }" style="cursor:pointer"  title="预览"></i>&nbsp;&nbsp;
						<i class="fam-pencil" id="${s.id }" w="680"h="450" t="20" url="<%=basePath%>refobj/editUI.do?id=${s.id}" style="cursor:pointer" title="关联选择项修改"></i>&nbsp;&nbsp;
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