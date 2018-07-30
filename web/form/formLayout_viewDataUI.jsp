<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath %>">
    <title></title>
    <%@include file="/public/common.jsp" %>
    <link href="<%=basePath %>css/navi-dynamicTable.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
    </style>
    <script type="text/javascript" src="<%=basePath %>js/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
	
    <script type="text/javascript">
    $(function(){
    	
    	$(".getFieldNameById").naviGetFieldNameById();
    	
    	$(".detailTable").naviTableList();
    	
    	$("#delBtn").click(function(){
    		if(confirm("您确定要删除吗？")){
	    		$.post("<%=basePath%>formData/delete.do",{formDataId:"${requestScope.formDataId}"},function(data){
	    			sysAlert(data.msg);
	    			if(data.isOk==1){
	    				window.close();
	    			}
	    		},"json");
    		}
    	});
    });
	/**
	选取所有
	*/
	function selectAll(el,tableId,chkList){
		var obj=$(el);
		if(obj.prop("checked")){
			$("#"+tableId+" input[name='"+chkList+"'][type='checkbox']").prop("checked",true);
		}else{
			$("#"+tableId+" input[name='"+chkList+"'][type='checkbox']").prop("checked",false);
		}
	}
    </script>
    <style type="text/css">
    	
    </style>
  </head>
 <body>
	<div id="warper">
		<div class="nav">
  			表单> ${requestScope.formLayout.objname}
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="location.href='<%=basePath %>formLayout/editDataUI.do?id=${requestScope.formLayout.id}&formDataId=${requestScope.formDataId}'" type="button">编辑(E)</button>
  			<button class="btn" id="delBtn" type="button">删除(D)</button>
  		</div>
  		<div class="content">
			${requestScope.viewHtml }
		</div>
	</div>	               
</body>
</html>