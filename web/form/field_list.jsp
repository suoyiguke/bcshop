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
		function addOrEdit(){
			var naviForm=$("#NaviAddForm");
			var url=naviForm.attr("action");
			$.post(url,naviForm.serialize(),function(data){
				if(data.success=="ok"){
					closePanel();
					if(url.indexOf("add")!=-1){
						$("#addUIBtn").click();
					}
					
				}else{
					alert(data.msg);
					closePanel("naviPanel",true);
				}
			},"json");
		}
		$(function(){
			//鼠标移动换色
			$(".tabList").naviTableList();
			//批量删除
			$("#delBtn").naviBatchDelete({url:"<%=basePath %>field/delete.do"});
			//单个删除
			$(".fam-cross").naviDelete({url:"<%=basePath %>field/delete.do"});
			//全选、反选
			$("#chkAll").naviCheckAll();
			$("#searchBtn").click(function(){
				$("#NaviForm").submit();
			});
			//编辑弹出层
			$(".fam-pencil").naviLayer();
			$(".field_edit").naviLayer();
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
			系统设置> 字段列表
		</div>
		<div class="toolbar" >
			<button class="btn" id="searchBtn">搜索(S)</button>
			<!--  <button class="btn" isModal="0" w="450" h="230",t="center" ctrBtn="all" url="formInfo/addUI.do" title="类型新增" id="addUIBtn">新增(N)</button> -->
			<button class="btn" w="680" h="360",t="10" url="<%=basePath%>field/addUI.do?formId=${requestScope.field.formId}" title="字段新增" id="addUIBtn">新增(N)</button>
			<button class="btn" id="delBtn" chkListCls="chkList">删除(D)</button>
		</div>
		<form id="NaviForm" action="<%=basePath %>field/list.do" method="post">
		<div class="searchbar">
			<table>
				<tr>
					<th>字段描述</th>
					<td>
						<input type="text" name="objdesc"  value="${requestScope.field.objname }"/>
					</td>
					<th>数据库字段名</th>
					<td>
						<input type="text" name="objname"  value="${requestScope.field.colName }"/>
					</td>
					<th>分类</th>
					<td>
  						<select name="typeId" id="typeId">
  							<option value="">==请选择分类==</option>
  							<c:forEach items="${requestScope.typeList }" var="s">
  								<option value="${s.id }" <c:if test="${s.id==requestScope.field.typeId }">selected="selected"</c:if>>${s.objname }</option>
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
					<col width="10%">
					<col width="15%">
				</colgroup>
				<tr>
					<th><input type="checkbox" chkListCls="chkList" id="chkAll"/></th>
					<th>字段描述</th>
					<th>数据库字段名</th>
					<th>字段类型</th>
					<th>分类</th>
					<th>顺序</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
				<tr>
					<td>
						<input type="checkbox" class="chkList" id="${s.id }"/>
					</td>
					<td><a class="field_edit" id="${s.id }" w="680" h="360",t="50" url="<%=basePath%>field/editUI.do?id=${s.id}" style="cursor:pointer" title="字段修改" href="javascript:void(0);">${s.objname }</a></td>
					<td>${s.colName }</td>
					<td>
						<c:choose>
							<c:when test="${s.fieldType=='text_simple' }">
							单行文本
							</c:when>
							<c:when test="${s.fieldType=='int' }">
							整数
							</c:when>
							<c:when test="${s.fieldType=='textarea' }">
							多行文本
							</c:when>
							<c:when test="${s.fieldType=='double' }">
							浮点
							</c:when>
							<c:when test="${s.fieldType=='date' }">
							日期
							</c:when>
							<c:when test="${s.fieldType=='refobj' }">
							关联选择
							</c:when>
							<c:when test="${s.fieldType=='refobj_multi' }">
							关联选择多选
							</c:when>
							<c:when test="${s.fieldType=='selectitem' }">
							选择项
							</c:when>
							<c:when test="${s.fieldType=='selectitem_multi' }">
							选择项多选
							</c:when>
							<c:when test="${s.fieldType=='file' }">
							 附件
							</c:when>
							<c:when test="${s.fieldType=='files' }">
							附件多选
							</c:when>
							<c:when test="${s.fieldType=='picture' }">
							图片
							</c:when>
							<c:when test="${s.fieldType=='pictures' }">
							图片多选
							</c:when>
							<c:when test="${s.fieldType=='rich_text' }">
							富文本
							</c:when>
							<c:when test="${s.fieldType=='datetime' }">
							日期时间
							</c:when>
							<c:when test="${s.fieldType=='time' }">
							时间
							</c:when>
							<c:when test="${s.fieldType=='checkbox' }">
							checkbox
							</c:when>
						</c:choose>
						
					
					</td>
					<td><span id="${s.typeId }" tableName="selectitem" fieldName="objname" class="getFieldNameById"></span></td>
					<td>${s.position }</td>
					<td>
						&nbsp;&nbsp;
						<i class="fam-pencil" id="${s.id }" w="680" h="360",t="50" url="<%=basePath%>field/editUI.do?id=${s.id}" style="cursor:pointer" title="字段修改"></i>&nbsp;&nbsp;&nbsp;&nbsp;
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