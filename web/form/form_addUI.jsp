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
    <%@include file="/public/common.jsp" %>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- Bootstrap framework -->
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
	<script type="text/javascript">
	</script>
  </head>
  <body style="background:#fff;">
  	<div id="wrap">
  		<div class="nav">
  			系统设置> 表单${(empty requestScope.form) ?"添加":"修改"}
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="addOrEdit();">提交(S)</button>
  			<button class="btn" onclick="closePanel()">取消(C)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">类型${(empty requestScope.form) ?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviAddForm" name="NaviAddForm" action="<%=basePath %>form/${(empty requestScope.form) ?"add":"edit" }.do" method="post">
			       	<table class="addTable">
			           <tbody>
			           		<tr>
			                   <th>表单名称</th>
			                   <td>
			                   <input type="text" class="text" name="objname" value="${requestScope.form.objname }"/>
			                   <input type="hidden" class="text" name="id" value="${requestScope.form.id }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>数据库表名</th>
			                   <td>
			                   <input type="text" class="text" name="tabName" ${(empty requestScope.form) ? '':'readonly' } value="${requestScope.form.tabName }"/>
			                   </td>
			               </tr>
			               <tr>
				               	<th>分类</th>
		  						<td>
		  						<select name="typeId" id="typeId">
		  							<option value="">==请选择分类==</option>
		  							<c:forEach items="${requestScope.typeList }" var="s">
		  								<option value="${s.id }" <c:if test="${s.id==requestScope.form.typeId }">selected="selected"</c:if>>${s.objname }</option>
		  							</c:forEach>
		  						</select>
	  							</td>
  						  </tr>
  						   <tr>
			                   <th>表单类型</th>
			                   <td>
			                   	<c:if test="${!empty requestScope.form }">
			                   		${0==requestScope.form.isEntityForm?'虚拟表单':'实体表单' }
			                   	</c:if>
			                   	<c:if test="${empty requestScope.form }">
			                   	<input type="radio" checked="checked" class="text" name="isEntityForm" value="1"/>实体表单
			                   	<input type="radio" class="text" name="isEntityForm" value="0"/>虚拟表单
			                   	</c:if>
			                   </td>
			               </tr>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${requestScope.form.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
      </div>
  </body>
</html>
