<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
    <base href="<%=basePath%>">
    <%@include file="/public/common.jsp" %>
	<style type="text/css">
	</style>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
	<script type="text/javascript">
	</script>
  </head>
 <body>
	<div id="wrap">
		<div class="nav">
  			系统设置> 角色${(empty requestScope.role)?"添加":"修改"}>
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="addOrEdit();">提交(S)</button>
  			<button class="btn" onclick="closePanel()">取消(C)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">角色${(empty requestScope.role)?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviAddForm" name="NaviAddForm" action="<%=basePath %>role/${(empty requestScope.role) ?"add":"edit" }.do" method="post">
			       	<table>
			           <tbody class="addTable">
			               <tr>
			                   <th>角色名称</th>
			                   <td>
            			       <input type="hidden" class="text" name="id" value="${requestScope.role.id }"/>
			                   <input type="text" class="text" name="objname" value="${requestScope.role.objname }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>角色描述</th>
			                   <td><input type="text" class="text" name="objdesc" value="${requestScope.role.objdesc }"/></td>
			               </tr>
			               <tr>
				               	<th>分类</th>
		  						<td>
		  						<select name="typeId" id="typeId">
		  							<option value="">==请选择分类==</option>
		  							<c:forEach items="${requestScope.typeList }" var="s">
		  								<option <c:if test="${s.id==requestScope.role.typeId }">selected="selected"</c:if> value="${s.id }">${s.objname }</option>
		  							</c:forEach>
		  						</select>
	  							</td>
  						   </tr>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${requestScope.role.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
	</div>
</body>
</html>