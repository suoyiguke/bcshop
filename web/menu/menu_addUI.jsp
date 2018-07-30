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
    
    <title>菜单管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
	<!-- Bootstrap framework -->
	<script type="text/javascript">
		function formSubmit(){
			$("#NaviForm").submit();
		}
		function checkChangeVal(el,valToChangeId){
			if($(el).prop("checked")){
				$("#"+valToChangeId).val(1);
			}else{
				$("#"+valToChangeId).val(0);
			}
		}
	</script>
	<%@include file="/public/common.jsp" %>
	<style type="text/css">
		.iconBtn{
			background: url('css/imgs/backX.gif') repeat-x;
			background-position: 0px -166px;
			border: 1px solid #8c9abb;
			padding:2px 5px;
		}
		
	</style>
  </head>
  <body style="background:#fff;">
  	<div id="wrap">
  		<div class="nav">
  			系统设置> 菜单${(empty requestScope.menu) ?"添加":"修改"}
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="formSubmit();">提交(S)</button>
  			<c:if test="${!empty requestScope.menu}">
  				<button class="btn" onclick="location.href='menu/addUI.do?pid=${requestScope.menu.id}'">新增(A)</button>
  			</c:if>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">菜单${(empty requestScope.menu) ?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviForm" name="NaviForm" action="<%=basePath %>menu/${(empty requestScope.menu) ?"add":"edit" }.do" method="post">
			       	<table class="addTable">
			           <tbody>
			               <tr>
			                   <th>名称</th>
			                   <td>
			                   <input type="text" class="text" name="objname" value="${requestScope.menu.objname }"/>
			                   <input type="hidden" class="text" name="id" value="${requestScope.menu.id }"/>
			                   </td>
			               </tr>
			                <tr>
			                   <th>url链接</th>
			                   <td><input type="text" class="text" name="url" value="${requestScope.menu.url }"/></td>
			               </tr>
			               <tr>
			                   <th>样式(class)</th>
			                   <td><input type="text" class="text" name="cls" value="${requestScope.menu.cls }"/></td>
			               </tr>
			               <tr>
			                   <th>父菜单</th>
			                   <td>
			                   	<input type="text" readonly="readonly" class="text" name="pidName" value="${requestScope.parent.objname}"/>
			                   	<input type="hidden" class="text" name="pid" value="${requestScope.parent.id }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>展开子菜单</th>
			                   <td>
			                   <input type="checkbox" class="text" onclick="checkChangeVal(this,'isExpand')" <c:if test="${(empty requestScope.menu)||(requestScope.menu.isExpand==1) }">checked="checked"</c:if>/>
			                   <input type="hidden" name="isExpand" id="isExpand" value="${requestScope.menu.isExpand }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${requestScope.menu.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
      </div>
  </body>
</html>
