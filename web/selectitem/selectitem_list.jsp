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
			$("#delBtn").naviBatchDelete({url:"<%=basePath %>selectitem/delete.do"});
			//单个删除
			$(".fam-cross").naviDelete({url:"<%=basePath %>selectitem/delete.do"});
			//全选、反选
			$("#chkAll").naviCheckAll();
			//搜索
			$("#searchBtn").click(function(){
				$("#NaviForm input[name='objname']").val($(".searchbar input[name='objname']").val());
				$("#NaviForm input[name='objdesc']").val($(".searchbar input[name='objdesc']").val());
				$("#NaviForm input[name='typeId']").val($(".searchbar select[name='typeId']").val());
				$("#NaviForm").submit();
			});
			//保存
			$("#saveBtn").click(function(){
				var f=$("#NaviAddForm");
				var url=f.attr("action");
				$.post(url,f.serialize(),function(data){
					if(data.isOk==1){
						location.reload();
					}else{
						alert(data.msg);
					}
				},"json");
			});
			//编辑弹出层
			$(".fam-pencil").naviLayer();
			//$("#addUIBtn").naviPanel({selector:"naviPanel",theme:"lightBlue"});
			//添加弹出层
			$("#addUIBtn").naviLayer();
			$("#addRowBtn").click(function(){
				$("#tabList").append("<tr><td><input type=\"checkbox\" id=\"\"/><input type=\"hidden\" name=\"pid\" value=\"${requestScope.parent.id }\"/></td><td><input type=\"text\" name=\"objname\" value=\"\"></td><td><input type=\"text\" name=\"objdesc\" value=\"\"></td><td><input type=\"text\" name=\"position\" value=\"\"></td><td></td></tr>");
			});
			//下一层级
			$(".fam-table-go").click(function(){
				location.href="<%=basePath%>selectitem/list.do?pid="+$(this).attr("id");
			});
			//返回父级
			$("#backBtn").click(function(){
				location.href="<%=basePath%>selectitem/list.do?pid=${requestScope.parent.pid}";
			});
			//类型
			$("span.getFieldNameById").naviGetFieldNameById();
		});
	</script>
  </head>
 <body>
 	<div id="naviPanel"></div>
	<div id="wraper">
		<div class="nav">
			系统设置> 选择项列表
		</div>
		<div class="toolbar" >
			<button class="btn" id="searchBtn">搜索(S)</button>
			<!--  <button class="btn" isModal="0" w="450" h="230",t="center" ctrBtn="all" url="selectitem/addUI.do" title="类型新增" id="addUIBtn">新增(N)</button> -->
			<c:if test="${ empty(requestScope.parent) }">
			<button class="btn" w="600px" h="280px"  url="<%=basePath%>selectitem/addUI.do?pid=${requestScope.parent.id}" title="选择项新增" id="addUIBtn">新增(N)</button>
			</c:if>
			<c:if test="${ !empty(requestScope.parent) }">
			<button class="btn" id="addRowBtn">新增(N)</button>
			<button class="btn" id="saveBtn">保存(S)</button>
			</c:if>
			<button class="btn" id="delBtn" chkListCls="chkList">删除(D)</button>
			<c:if test="${ !empty(requestScope.parent) }">
			<button class="btn" id="backBtn">返回父级(B)</button>
			</c:if>
		</div>
		
		<div class="searchbar">
			<table>
				<tr>
					<th>名称</th>
					<td>
						<input type="text"  name="objname"  value="${requestScope.selectitem.objname }"/>
					</td>
					<th>分类</th>
					<td>
						<select name="typeId">
							<option value="">==请选择分类==</option>
							<c:forEach items="${requestScope.typeList }" var="s">
								<option value="${s.id }" <c:if test="${s.id==requestScope.selectitem.typeId }">selected="selected"</c:if>>${s.objname }</option>
							</c:forEach>
						</select>
					</td>
					<th>描述</th>
					<td>
						<input type="text"  name="objdesc"  value="${requestScope.selectitem.objdesc }"/>
					</td>
				</tr>
			</table>
		</div>
		<div>
			<form id="NaviAddForm" action="<%=basePath %>selectitem/batchUpdate.do" method="post">
			<table class="tabList" id="tabList">
				<colgroup>
					<col width="4%">
					<col width="20%">
					<col width="">
					<c:if test="${empty requestScope.parent}">
					<col width="15%">
					<col width="10%">
					</c:if>
					<col width="10%">
					<col width="15%">
				</colgroup>
				<tr>
					<th><input type="checkbox" chkListCls="chkList" id="chkAll"/></th>
					<th>名称</th>
					<th>描述</th>
					<c:if test="${empty requestScope.parent}">
					<th>分类</th>
					<th>唯一标识</th>
					</c:if>
					<th>顺序</th>
					<th>操作</th>
				</tr>
				<c:if test="${empty requestScope.parent}">
					<c:forEach items="${requestScope.pageBean.recordList }" var="s">
					<tr>
						<td>
							<input type="checkbox" class="chkList" id="${s.id }"/>
						</td>
						<td>${s.objname }</td>
						<td>${s.objdesc }</td>
						<c:if test="${empty requestScope.parent}">
						<td>
							<span class="getFieldNameById" tableName="selectitem" fieldName="objname" id="${s.typeId }"></span>
						</td>
						<td>${s.idName }</td>
						</c:if>
						<td>${s.position }</td>
						<td>
							&nbsp;&nbsp;
							<i class="fam-table-go" id="${s.id }" style="cursor:pointer" title="子项"></i>&nbsp;&nbsp;&nbsp;&nbsp;
							<i class="fam-pencil" w="600" h="280" t="50" id="${s.id }" url="<%=basePath%>selectitem/editUI.do?id=${s.id}" style="cursor:pointer" title="选择项修改"></i>&nbsp;&nbsp;&nbsp;&nbsp;
							<i class="fam-cross" id="${s.id }" style="cursor:pointer" title="删除"></i>
						</td>
					</tr>
					</c:forEach>
				</c:if>
				
					<c:if test="${!empty requestScope.parent}">
						<c:forEach items="${requestScope.pageBean.recordList }" var="s">
						<tr>
							<td>
								<input type="checkbox" class="chkList" id="${s.id }"/>
								<input type="hidden" name="id" value="${s.id }"/>
								<input type="hidden" name="pid" value="${requestScope.parent.id }"/>
							</td>
							<td><input type="text" name="objname" value="${s.objname }"></td>
							<td><input type="text" name="objdesc" value="${s.objdesc }"></td>
							<td><input type="text" name="position" value="${s.position  }"></td>
							<td>
								&nbsp;&nbsp;
								<i class="fam-table-go" id="${s.id }" style="cursor:pointer" title="子项"></i>&nbsp;&nbsp;&nbsp;&nbsp;
								<i class="fam-pencil" w="600" h="280" t="50" id="${s.id }" url="<%=basePath%>selectitem/editUI.do?id=${s.id}" style="cursor:pointer" title="选择项修改"></i>&nbsp;&nbsp;&nbsp;&nbsp;
								<i class="fam-cross" id="${s.id }" style="cursor:pointer" title="删除"></i>
							</td>
						</tr>
						</c:forEach>
					</c:if>
			</table>
			</form>
		<form id="NaviForm" action="<%=basePath %>selectitem/list.do" method="post">
			<input type="hidden" name="objname" value=""/>
			<input type="hidden" name="objdesc" value=""/>
			<input type="hidden" name="typeId" value=""/>
			<input type="hidden" name="pid" value="${requestScope.parent.id }"/>
			<%@include file="/public/pagination.jsp" %>
		</form>
		 </div>
	</div>
</body>
</html>