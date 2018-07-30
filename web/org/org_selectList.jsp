<%@page import="com.navi.orgnization.model.Org"%>
<%@page import="com.navi.utils.IPage"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	List<Org> rootChildren=(List<Org>)request.getAttribute("rootChildren");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
	<base href="<%=basePath%>" >
    <title></title>
    <%@include file="/public/common.jsp" %>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
    <style type="text/css">
    </style>
    <script type="text/javascript">
    	function search(){
    		var objname=$('#objname').val();
    		$("#childListFrame").attr("src","<%=basePath %>org/selectChildList.do?pid=${requestScope.root.id }&objname="+objname+"&inputId=${requestScope.inputId }&inputName=${requestScope.inputName }");
    	}
    	function clearSelect(inputId,inputName){
			window.opener.$("#"+inputId).val("");
			window.opener.$("#"+inputName).val("");
			window.close();
		}
    	$(function(){
    		$(".tabList").naviTableList();
    	});
    	function getChildList(id){
    		$("#childListFrame").attr("src","<%=basePath%>org/selectChildList.do?pid="+id+"&inputId=${requestScope.inputId }&inputName=${requestScope.inputName }");
    	}
    </script>
  </head>
 <body>
 	<div id="warper">
 		<div class="nav">
  			系统设置> 选择项列表>
  		</div>
  		<div class="toolbar" >
  			<button class="btn" onclick="search();">搜索(S)</button>
  			<button class="btn" onclick="clearSelect('${requestScope.inputId}','${requestScope.inputName }');">清除(C)</button>
  		</div>
  		<form id="NaviForm" name="NaviForm" action="<%=basePath %>selectitem/selectList.do" method="post">
  		<div class="searchbar">
  			<table>
  				<tr>
  					<th>组织名称</th>
  					<td><input type="text" name="objname"  id="objname" value="${requestScope.org.objname }"/></td>
  				</tr>
  			</table>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">${requestScope.root.objname }</a></li>
  			</ul>
			<table class="selectList">
				<%
					for(int i=0;i<rootChildren.size();i++){
						Org org=rootChildren.get(i);
						if(i%5==0){
							out.print("<tr>");
						}
						out.print("<td><a onclick=\"getChildList('"+org.getId()+"')\" href=\"javascript:void(0)\">"+org.getObjname()+"</a></td>");
						if((i!=0&&i%5==0)||(i==rootChildren.size()-1)){
							out.print("</tr>");
						}
					} 
				%>
			</table>
      	</div>
      	<iframe id="childListFrame" src="<%=basePath %>org/selectChildList.do?pid=${requestScope.root.id }&inputId=${requestScope.inputId }&inputName=${requestScope.inputName }">
      	</iframe>
  		</form>
	</div>
</body>
</html>