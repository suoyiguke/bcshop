<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Category_add.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@include file="/public/common.jsp" %>
	<link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
	<script type="text/javascript">
		function formSubmit(){
			$("#NaviForm").submit();
		}
		function deleteOrg(id){
			$.post("<%=basePath %>/org/delete.do",{id:id},function(data){
				if(data=="ok"){
					alert("删除成功！");
					location.href="<%=basePath %>/org/detail.do?type=org&id=${requestScope.parent.id}";
				}else if("hasStation"==data){
					alert("此组织还有岗位，不能执行删除操作!");
				}else if("hasOrg"==data){
					alert("此组织还有下级组织，不能执行删除操作!");
				}
			});
		}
		$(function(){
			$(".detailTable").naviTableList();
		});
	</script>
	<style type="text/css">
	</style>
  </head>
  <body style="background:#fff;">
  	<div id="wrap">
  		<div class="nav">
  			系统设置 > 组织单元 > ${requestScope.org.objname}
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="location.href='<%=basePath%>org/editUI.do?id=${requestScope.org.id}'">编辑(E)</button>
  			<button class="btn" onclick="deleteOrg('${requestScope.org.id}')">删除(D)</button>
  			<button class="btn" onclick="location.href='<%=basePath%>station/addUI.do?orgId=${requestScope.org.id}'">新建岗位(N)</button>
  			<button class="btn" onclick="location.href='<%=basePath%>org/addUI.do?pid=${requestScope.org.id}'">新建下级组织(N)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">组织基本信息</a></li>
  			</ul>
  			<div class="tabContent">
			       	<table class="detailTable">
			           <tbody>
			           	   <tr>
			                   <th>编号</th>
			                   <td>${(empty requestScope.org) ? '':requestScope.org.objno }</td>
			               </tr>
			               <tr>
			                   <th>名称</th>
			                   <td>${(empty requestScope.org) ? '':requestScope.org.objname }</td>
			               </tr>
			               <tr>
			                   <th>上级组织</th>
			                   <td>${(empty requestScope.org) ? '':requestScope.parent.namePath }</td>
			               </tr>
			               <tr>
			                   <th>上级管理岗位</th>
			                   <td>${empty requestScope.parentStation?'': requestScope.parentStation.objname}</td>
			               </tr>
			               <tr>
			                   <th>组织负责岗位</th>
			                   <td>${empty requestScope.manageStation?'': requestScope.manageStation.objname}</td>
			               </tr>
			                <tr>
			                   <th>组织负责人</th>
			                   <td>${empty requestScope.manager?'': requestScope.manager.objname}</td>
			               </tr>
			               <tr>
			                   <th>顺序</th>
			                   <td>${(empty requestScope.org) ? '':requestScope.org.position }</td>
			               </tr>
			           </tbody>
			      	</table>
	      </div>
      	</div>
      </div>
  </body>
</html>
