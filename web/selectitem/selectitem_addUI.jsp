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
	<script type="text/javascript"></script>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
  </head>
 <body>
	<div id="wrap">
		<div class="nav">
  			系统设置> 选择项${(empty requestScope.selectitem)?"添加":"修改"}>
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="addOrEdit();">提交(S)</button>
  			<button class="btn" onclick="closePanel()">取消(C)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">选择项${(empty requestScope.selectitem)?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviAddForm" name="NaviAddForm" action="<%=basePath %>selectitem/${(empty requestScope.selectitem) ?"add":"edit" }.do" method="post">
			       	<table>
			           <tbody class="addTable">
			           	   <c:if test="${(!empty requestScope.parent)}">
			           		<tr>
			                   <th>父选择项</th>
			                   <td>
				                   <input type="text" readonly="readonly" class="text" name="parentObjname" value="${requestScope.parent.objname }"/>
				                   <input type="hidden" class="text" name="pid" value="${requestScope.parent.id }"/>
			                   </td>
			               </tr>
			               </c:if>
			               <tr>
			                   <th>选择项名称</th>
			                   <td>
            			       <input type="hidden" class="text" name="id" value="${(empty requestScope.selectitem) ? '':requestScope.selectitem.id }"/>
			                   <input type="text" class="text" name="objname" value="${(empty requestScope.selectitem) ? '':requestScope.selectitem.objname }"/>
			                   </td>
			               </tr>
			               <c:if test="${empty requestScope.parent}">
			               <tr>
				               	<th>分类</th>
		  						<td>
		  						<select name="typeId" id="typeId">
		  							<option value="">==请选择分类==</option>
		  							<c:forEach items="${requestScope.typeList }" var="s">
		  								<option value="${s.id }" <c:if test="${s.id==requestScope.selectitem.typeId }">selected="selected"</c:if>>${s.objname }</option>
		  							</c:forEach>
		  						</select>
	  							</td>
  							</tr>
  							</c:if>
			               <tr>
			                   <th>选择项描述</th>
			                   <td><input type="text" class="text" name="objdesc" value="${requestScope.selectitem.objdesc }"/></td>
			               </tr>
			               <c:if test="${(empty requestScope.parent)}">
			               <tr>
			                   <th>唯一标识</th>
			                   <td>
			                   <input type="text" class="text" name="idName" value="${requestScope.selectitem.idName }"/>
			                   </td>
			               </tr>
			               </c:if>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${requestScope.selectitem.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
	</div>
</body>
</html>