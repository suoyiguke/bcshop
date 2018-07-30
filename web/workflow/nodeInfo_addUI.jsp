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
  			系统设置> 节点${(empty requestScope.nodeInfo.id)?"添加":"修改"}>
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="addOrEdit();">提交(S)</button>
  			<button class="btn" onclick="closePanel()">取消(C)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">节点${(empty requestScope.nodeInfo.id)?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviAddForm" name="NaviAddForm" action="<%=basePath %>nodeInfo/${(empty requestScope.nodeInfo.id) ?"add":"edit" }.do" method="post">
			       	<table>
			           <tbody class="addTable">
			               <tr>
			                   <th>节点名称</th>
			                   <td>
            			       <input type="hidden" class="text" name="id" value="${requestScope.nodeInfo.id }"/>
            			       <input type="hidden" class="text" name="pipeId" value="${requestScope.nodeInfo.pipeId }"/>
			                   <input type="text" class="text" name="objname" value="${requestScope.nodeInfo.objname }"/>
			                   </td>
			               </tr>
			               <tr>
				               	<th>节点类型</th>
		  						<td>
		  						<select name="nodeType" id="nodeType">
		  							<option value="">==请选择节点类型==</option>
		  							<option <c:if test="${0==requestScope.nodeInfo.nodeType }">selected="selected"</c:if> value="0">开始节点</option>
		  							<option <c:if test="${1==requestScope.nodeInfo.nodeType }">selected="selected"</c:if> value="1">活动节点</option>
		  							<option <c:if test="${2==requestScope.nodeInfo.nodeType }">selected="selected"</c:if> value="2">结束节点</option>
		  						</select>
	  							</td>
  						   </tr>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${requestScope.nodeInfo.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
	</div>
</body>
</html>