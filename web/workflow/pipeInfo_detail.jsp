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
  				<li class="active first"><a url="<%=basePath %>pipeInfo/editUI.do?id=${requestScope.pipeInfo.id}" href="javascript:void(0);">流程信息</a></li>
  				<li><a url="<%=basePath %>nodeInfo/list.do?pipeId=${requestScope.pipeInfo.id}" href="javascript:void(0);">节点管理</a></li>
  				<li><a url="<%=basePath %>export/list.do?pipeId=${requestScope.pipeInfo.id}" href="javascript:void(0);">出口管理</a></li>
  				<li><a url="<%=basePath %>workflowChart/addUI.do?pipeId=${requestScope.pipeInfo.id}" href="javascript:void(0);">流程图设置</a></li>
  				<li><a url="<%=basePath %>formLayout/list.do?pipeId=${requestScope.pipeInfo.id}&formId=${requestScope.pipeInfo.formId}" href="javascript:void(0);">表单布局</a></li>
  			</ul>
  			<div class="tabContent noPadding">
  				<iframe src=""></iframe>
	      </div>
      	</div>
</div>
</body>
</html>