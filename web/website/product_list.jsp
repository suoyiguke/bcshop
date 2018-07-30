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
			$("#delBtn").naviBatchDelete({url:"<%=basePath %>website/product/delete.do"});
			//单个删除
			$(".fam-cross").naviDelete({url:"<%=basePath %>website/product/delete.do"});
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
			系统设置> 产品列表
		</div>
		<div class="toolbar" >
			<button class="btn" id="searchBtn">搜索(S)</button>
			<button class="btn" w="800" h="560" t="50" url="<%=basePath%>website/product/addUI.do" title="网站产品新增" id="addUIBtn">新增(N)</button>
			<button class="btn" id="delBtn" chkListCls="chkList">删除(D)</button>
		</div>
		<form id="NaviForm" action="<%=basePath %>website/product/list.do" method="post">
		<div class="searchbar">
			<table>
				<tr>
					<th>产品名称</th>
					<td>
						<input type="text" name="objname"  value="${requestScope.product.objname }"/>
					</td>
					<th>摘要</th>
					<td>
						<input type="text" name="objdesc"  value="${requestScope.product.objdesc }"/>
					</td>
					<th>分类</th>
					<td>
						<select name="typeId" id="typeId">
  							<option value="">==请选择分类==</option>
  							<c:forEach items="${requestScope.typeList }" var="s">
  								<option value="${s.id }" <c:if test="${s.id==requestScope.product.typeId }">selected="selected"</c:if>>${s.objname }</option>
  							</c:forEach>
  						</select>
					</td>
				</tr>
				<tr>
					<th>推广类型</th>
					<td>
						<select name="type" id="type">
  							<option value="">==推广类型==</option>
							<option value="lb" <c:if test="${'首页轮播'==requestScope.product.type }">selected="selected"</c:if>>首页轮播</option>
							<option value="tw" <c:if test="${'首页图文'==requestScope.product.type }">selected="selected"</c:if>>首页图文</option>
  						</select>
					</td>
					<th>发布状态</th>
					<td>
						<select name="isActive" >
  							<option value="-1">==请选择发布状态==</option>
  							<option value="1" <c:if test="${product.isActive==1 }">selected="selected"</c:if>>已发布</option>
  							<option value="0" <c:if test="${product.isActive==0 }">selected="selected"</c:if>>未发布</option>
  						</select>
					</td>
					<th></th>
					<td>
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
					<col width="5%">
					<col width="8%">
					<col width="10%">
					<col width="10%">
					<col width="5%">
					<col width="8%">
				</colgroup>
				<tr>
					<th><input type="checkbox" chkListCls="chkList" id="chkAll"/></th>
					<th>产品名称</th>
					<th>产品摘要</th>
					<th>图片</th>
					<th>分类</th>
					<th>推广类型</th>
					<th>发布状态</th>
					<th>顺序</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
				<tr>
					<td>
						<input type="checkbox" class="chkList" id="${s.id }"/>
					</td>
					<td>${s.objname }</td>
					<td title="${s.objdesc }">
						<c:choose>  
						    <c:when test="${fn:length(s.objdesc) > 30}">  
						        <c:out value="${fn:substring(s.objdesc, 0, 30)}......" />  
						    </c:when>  
						   <c:otherwise>  
						      <c:out value="${s.objdesc}" />  
						    </c:otherwise>  
						</c:choose>  
					</td>
					<td>
					<c:if test="${!empty(s.img) }">
					<img width="25px" height="25px" src="<%=basePath %>attach/showPicture.do?id=${s.img }" />
					</c:if>
					</td>
					<td><span id="${s.typeId }" tableName="selectitem" fieldName="objname" class="getFieldNameById"></span></td>
					<td>${s.type }</td>
					<td>${s.isActive==1?"已发布":"未发布" }</td>
					<td>${s.position }</td>
					<td>
						&nbsp;&nbsp;
						<i class="fam-pencil" id="${s.id }" w="800" h="560" t="50"  url="<%=basePath%>website/product/editUI.do?id=${s.id}" style="cursor:pointer" title="类型修改"></i>&nbsp;&nbsp;&nbsp;&nbsp;
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