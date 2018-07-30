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
	<script type="text/javascript">
		$(function(){
			//鼠标移动换色
			$(".tabList").naviTableList();
			//批量删除
			$("#delBtn").naviBatchDelete({url:"<%=basePath %>formLayout/delete.do"});
			//单个删除
			$(".fam-cross").naviDelete({url:"<%=basePath %>formLayout/delete.do"});
			//全选、反选
			$("#chkAll").naviCheckAll();
			$("#searchBtn").click(function(){
				$("#NaviForm").submit();
			});
			//编辑弹出层
			$(".fam-pencil").click(function(){
				var id=$(this).attr("id");
				window.open("<%=basePath%>formLayout/editUI.do?id="+id);
			});
			//类型
			$("span.getFieldNameById").naviGetFieldNameById();
			
			//设置
			$(".setting").click(function(){
				window.open('<%=basePath%>formLayoutField/editUI.do?formLayoutId='+$(this).attr("id"));
			});
			if("${requestScope.formLayout.pipeId }"){
				$.post("<%=basePath%>nodeInfo/getJsonListByPipeId.do",{pipeId:"${requestScope.formLayout.pipeId }"},function(data){
					var html="";
					for(var i=0;i<data.length;i++){
						var obj=data[i];
						html+="<option value='"+obj.id+"'>"+obj.objname+"</option>";
					}
					$("#nodeSelect").append(html);
				},"json");	
			}
		});
		function viewLayout(id){
    		window.open("<%=basePath%>formLayout/addDataUI.do?id="+id);
    	}
		function addLayout(type){
			var nodeId=$("#nodeSelect").val();
			var objname="";
			if(nodeId){
				var nodeName=$("#nodeSelect").find("option:selected").text();
				objname=nodeName+"_"+(type=="show"?"显示布局":"编辑布局");
			}
			var url="<%=basePath%>formLayout/addUI.do?formId=${requestScope.formLayout.formId }&pipeId=${requestScope.formLayout.pipeId }&nodeId="+nodeId+"&objname="+objname+"&formLayoutType="+type;
			url=encodeURI(url);
			window.open(url);
		}
	</script>
  </head>
 <body>
 	<div id="naviPanel"></div>
	<div id="wraper">
		<div class="nav">
			系统设置> 布局列表
		</div>
		<div class="toolbar" >
			<c:if test="${!empty requestScope.formLayout.pipeId}">
			<select id="nodeSelect">
				<option value="">===请选择对应布局的节点===</option>
			</select>
			</c:if>
			<button class="btn" id="searchBtn">搜索(S)</button>
			<button class="btn" onclick="addLayout('show');">新增显示布局(A)</button>
  			<button class="btn" onclick="addLayout('edit');">新增编辑布局(A)</button>
			<button class="btn" id="delBtn" chkListCls="chkList">删除(D)</button>
		</div>
		<form id="NaviForm" action="<%=basePath %>formLayout/list.do" method="post">
		<div class="searchbar">
			<table>
				<tr>
					<th>布局名称</th>
					<td>
						<input type="text" name="objname"  value="${requestScope.formLayout.objname }"/>
						<input type="hidden" name="formId" value="${requestScope.formLayout.formId }"/>
					</td>
					<th>布局类型</th>
					<td>
						<select name="formLayoutType" id="formLayoutType">
  							<option value="">==请选择类型==</option>
  							<option value="edit" <c:if test="${'edit'==requestScope.formLayout.formLayoutType }">selected="selected"</c:if>>编辑布局</option>
  							<option value="show" <c:if test="${'show'==requestScope.formLayout.formLayoutType }">selected="selected"</c:if>>显示布局</option>
  						</select>
					</td>
					<th>分类</th>
					<td>
  						<select name="typeId" id="typeId">
  							<option value="">==请选择分类==</option>
  							<c:forEach items="${requestScope.typeList }" var="s">
  								<option value="${s.id }" <c:if test="${s.id==requestScope.formLayout.typeId }">selected="selected"</c:if>>${s.objname }</option>
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
					<col width="10%">
					<col width="8%">
					<col width="15%">
				</colgroup>
				<tr>
					<th><input type="checkbox" chkListCls="chkList" id="chkAll"/></th>
					<th>布局名称</th>
					<th>布局类型</th>
					<th>分类</th>
					<th>布局字段设置</th>
					<th>顺序</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
				<tr>
					<td>
						<input type="checkbox" class="chkList" id="${s.id }"/>
					</td>
					<td>${s.objname }</td>
					<td>${s.formLayoutType=='edit'?'编辑布局':'显示布局' }</td>
					<td><span id="${s.typeId }" tableName="selectitem" fieldName="objname" class="getFieldNameById"></span></td>
					<td><a class="setting" id="${s.id }" href="javascript:void(0)">设置</a></td>
					<td>${s.position }</td>
					<td>
						&nbsp;&nbsp;
						<i class="fam-page-white" style="cursor:pointer" onclick="viewLayout('${s.id}')" title="预览"></i>&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="fam-pencil" id="${s.id}" style="cursor:pointer" title="布局修改"></i>&nbsp;&nbsp;&nbsp;&nbsp;
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