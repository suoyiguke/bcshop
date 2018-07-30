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
	<link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
	<!-- Bootstrap framework -->
	<script type="text/javascript">
	</script>
	<%@include file="/public/common.jsp" %>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
	<style type="text/css">
		.addTable th {
			width: 15%;
		}
	</style>
  </head>
  <body style="background:#fff;">
  	<div id="wrap">
  		<div class="nav">
  			系统设置> 关联选择项${(empty requestScope.refobj) ?"添加":"修改"}>
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="addOrEdit();">提交(S)</button>
  			<button class="btn" onclick="closePanel()">取消(C)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">关联选择项${(empty requestScope.refobj) ?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviAddForm" name="NaviAddForm" action="<%=basePath %>refobj/${(empty requestScope.refobj) ?"add":"edit" }.do" method="post">
			       	<table class="addTable">
			           <tbody>
			               <tr>
			                   <th>名称</th>
			                   <td>
			                   <input type="text" class="text" name="objname" value="${requestScope.refobj.objname }"/>
			                   <input type="hidden" class="text" name="id" value="${requestScope.refobj.id }"/>
			                   <input type="hidden" class="text" name="reportTableId" value="${requestScope.refobj.reportTableId }"/>
			                   </td>
			               </tr>
			                <tr>
			                   <th>唯一标识</th>
			                   <td>
			                   <input type="text" class="text" name="idName" value="${requestScope.refobj.idName }"/>
			                   </td>
			               </tr>
			                <tr>
			                   <th>关联url链接</th>
			                   <td><input type="text" class="text" name="refUrl" value="${requestScope.refobj.refUrl }"/></td>
			               </tr>
			               <tr>
			                   <th>关联表名称</th>
			                   <td>
			                   	<input type="text"  class="text" name="tabName" value="${requestScope.refobj.tabName }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>关联表主字段</th>
			                   <td>
			                   <input type="text"  class="text" name="idField" value="${requestScope.refobj.idField }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>显示字段</th>
			                   <td>
			                   <input type="text"  class="text" name="showField" value="${requestScope.refobj.showField }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>显示url</th>
			                   <td>
			                   <input type="text"  class="text" name="showUrl" value="${requestScope.refobj.showUrl }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>过滤条件</th>
			                   <td><input type="text" class="text" name="filterCondition" value="${requestScope.refobj.filterCondition }"/></td>
			               </tr>
			               <tr>
			                   <th>是否多选</th>
			                   <td>
			                  	<input type="checkbox" ${(requestScope.refobj.multiSelect==1)?"checked":"" } value="${requestScope.refobj.multiSelect}"onclick="if(this.checked){this.value='1';}else{this.value='0'};" name="multiSelect"/>
			                   </td>
			               </tr>
			               <tr>
				               	<th>分类</th>
		  						<td>
		  						<select name="typeId" id="typeId">
		  							<option value="">==请选择分类==</option>
		  							<c:forEach items="${requestScope.itemTypeList }" var="s">
		  								<option value="${s.id }" <c:if test="${s.id==requestScope.refobj.typeId }">selected="selected"</c:if>>${s.objname }</option>
		  							</c:forEach>
		  						</select>
	  							</td>
  							</tr>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${requestScope.refobj.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
      </div>
  </body>
</html>
