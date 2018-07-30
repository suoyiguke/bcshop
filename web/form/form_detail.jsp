<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title></title>
    <%@include file="/public/common.jsp" %>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-tabs.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#naviTabs").naviTabs({tabActive:0});
		});
	</script>
	
	<style type="text/css">
	div.tab .tabContent table{
		margin:3px 0 5px 5px;
	}
	</style>
  </head>
 <body>
<div id="warper">
		<div class="tab" id="naviTabs">
  			<ul>
  				<li class="active first"><a url="<%=basePath %>form/editUI.do?id=${requestScope.form.id}&selectItemId=${requestScope.selectItemId}" href="javascript:void(0);">表单信息</a></li>
  				<c:if test="${requestScope.form.isEntityForm==0}">
  				<li><a url="<%=basePath %>formRelation/list.do?virtualityFormId=${requestScope.form.id}" href="javascript:void(0);">表单关系</a></li>
  				</c:if>
  				<c:if test="${requestScope.form.isEntityForm==1}">
  				<li><a url="<%=basePath %>field/list.do?formId=${requestScope.form.id}" href="javascript:void(0);">字段管理</a></li>
  				</c:if>
  				<li><a url="<%=basePath %>formLayout/list.do?formId=${requestScope.form.id}" href="javascript:void(0);">表单布局</a></li>
  			</ul>
  			<div class="tabContent noPadding">
  				<iframe src=""></iframe>
	      </div>
      	</div>
</div>
</body>
</html>