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
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-popWin.js"></script>
    <style type="text/css">
    </style>
    <script type="text/javascript">
    	function search(){
    		var objname=$('#objname').val();
    		var orgId=$('#orgId').val();
    		var orgIdCheck="0";
    		if($("#orgId_checkbox").attr("checked")){
    			orgIdCheck="1";
    		}
    		$("#childListFrame").attr("src","<%=basePath %>humres/selectChildList.do?orgId="+orgId+"&orgIdCheck="+orgIdCheck+"&objname="+objname+"&inputId=${requestScope.inputId }&inputName=${requestScope.inputName }");
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
    		$("#childListFrame").attr("src","<%=basePath%>humres/selectChildList.do?orgId="+id+"&inputId=${requestScope.inputId }&inputName=${requestScope.inputName }");
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
  					<th>姓名</th>
  					<td><input type="text" name="objname"  id="objname" value=""/></td>
  					<th>组织</th>
  					<td>
  					 <input type="hidden"  id="orgId" name="orgId" value="${requestScope.root.id }"/>
                	<input readOnly="readOnly" type="text" id="orgName" value="${requestScope.root.objname }"name="orgName"/>
                	<button type="button" class="browser" style="cursor:pointer" onclick="popWin('<%=basePath %>org/selectList.do','orgId','orgName')">
                	</button>
                	<input type="checkbox" value="1" checked="checked" name="orgId_checkbox" id="orgId_checkbox"/>
                	<a onclick="clearValue('orgId','orgName');" href="javascript:void(0);">清除</a>
  					</td>
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
      	<iframe id="childListFrame" src="<%=basePath %>humres/selectChildList.do?orgId=${requestScope.root.id }&inputId=${requestScope.inputId }&inputName=${requestScope.inputName }">
      	</iframe>
  		</form>
	</div>
</body>
</html>