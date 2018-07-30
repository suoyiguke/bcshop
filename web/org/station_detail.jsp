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
    
    <title>岗位信息</title>
    
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
		function deleteStation(id){
			$.post("<%=basePath %>/station/delete.do",{id:id},function(data){
				if(data=="ok"){
					alert("删除成功！");
					location.href="<%=basePath %>/station/detail.do?type=station&id=${requestScope.parent.id}";
				}else if("hasHumres"==data){
					alert("此岗位还有人员，不能执行删除操作!");
				}else if("hasStation"==data){
					alert("此岗位还有下级岗位，不能执行删除操作!");
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
  			系统设置 > 岗位信息 > ${requestScope.station.objname}
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="location.href='<%=basePath%>station/editUI.do?id=${requestScope.station.id}'">编辑(E)</button>
  			<button class="btn" onclick="deleteStation('${requestScope.station.id}')">删除(D)</button>
  			<button class="btn" onclick="location.href='<%=basePath%>humres/addUI.do?stationId=${requestScope.station.id}'">添加人员(A)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">岗位基本信息</a></li>
  			</ul>
  			<div class="tabContent">
			       	<table class="detailTable">
			           <tbody>
			           	   <tr>
			                   <th>编号</th>
			                   <td>${(empty requestScope.station) ? '':requestScope.station.objno }</td>
			               </tr>
			               <tr>
			                   <th>名称</th>
			                   <td>${(empty requestScope.station) ? '':requestScope.station.objname }</td>
			               </tr>
			               <tr>
			                   <th>所属组织</th>
			                   <td>${(empty requestScope.station) ? '':requestScope.org.namePath }</td>
			               </tr>
			               <tr>
			                   <th>上级岗位</th>
			                   <td>${(empty requestScope.station) ? '':requestScope.parent.objname }</td>
			               </tr>
			               <tr>
			                   <th>顺序</th>
			                   <td>${(empty requestScope.station) ? '':requestScope.station.position }</td>
			               </tr>
			           </tbody>
			      	</table>
	      </div>
      	</div>
      </div>
  </body>
</html>
