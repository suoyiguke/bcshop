<%@page import="com.navi.orgnization.service.OrgService"%>
<%@page import="com.navi.web.BaseContext"%>
<%@page import="com.navi.orgnization.model.Humres"%>
<%@page import="com.navi.utils.StringUtils"%>
<%@page import="com.navi.orgnization.model.Org"%>
<%@page import="com.navi.utils.IPage"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	IPage pageBean=(IPage)request.getAttribute("pageBean");
	List<Org> list=(List<Org>)request.getAttribute("childList");
	String inputId=(String)request.getAttribute("inputId");
	String inputName=(String)request.getAttribute("inputName");
	OrgService orgService=BaseContext.getBean("orgService");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
	<base href="<%=basePath%>" >
    <title></title>
    <%@include file="/public/common.jsp" %>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
    
    <script type="text/javascript">
    $(function(){
		var parentFrame = $(window.parent.document).find("IFRAME");
		parentFrame.height($("body").height()+10);
		$(".tabList").naviTableList();
    });
    function singleSelect(inputId,inputName,idVal,nameVal){
		window.parent.opener.$("#"+inputId).val(idVal);
		window.parent.opener.$("#"+inputName).val(nameVal);
		window.parent.close();
	}
	function getChildList(id){
    		location.href="<%=basePath%>humres/selectChildList.do?orgId="+id+"&inputId=<%=inputId%>&inputName=<%=inputName%>";
    }
    </script>
    <style type="text/css">
    </style>
  </head>
 <body>
 	<div id="warper">
  		<div class="tab" ${(requestScope.isRoot || empty requestScope.parent)?"style='display:none'":"" }>
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">${requestScope.parent.namePath }</a></li>
  			</ul>
  			<button style="margin-left:15px;" class="btn" onclick="location.href='<%=basePath%>humres/selectChildList.do?orgId=${requestScope.parent.pid }&inputId=<%=inputId%>&inputName=<%=inputName%>'">返回上一级</button>
			<table class="selectList">
				<%
					if(list.size()<=0){
						out.print("<tr><td>此组织下没有下级组织了</td></tr>");
					}
					for(int i=0;i<list.size();i++){
						Org org=list.get(i);
						if(i%5==0){
							out.print("<tr>");
						}
						out.print("<td><a onclick=\"getChildList('"+org.getId()+"')\" href=\"javascript:void(0)\">"+org.getObjname()+"</a></td>");
						if((i!=0&&i%5==0)||(i==list.size()-1)){
							out.print("</tr>");
						}
					} 
				%>
			</table>
      	</div>
      	
      	<div>
      		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">人员列表</a></li>
  			</ul>
  			<table class="tabList">
  				<tr>
  					<th>姓名</th>
  					<th>所属组织</th>
  				</tr>
  				<%
  					List<Humres> humresList=pageBean.getRecordList();
  					for(int i=0;i<humresList.size();i++){
  						Humres h=humresList.get(i);
  						Org org=orgService.getById(h.getOrgId());
  				 %>
  				<tr style="cursor:pointer;" onclick="singleSelect('<%=inputId%>','<%=inputName%>','<%=h.getId()%>','<%=h.getObjname()%>');">
  					<td><%=h.getObjname() %></td>
  					<td><%=org.getNamePath() %></td>
  				</tr>
  				<% }%>
  			</table>
	  		<form id="NaviForm" name="NaviForm" action="<%=basePath %>humres/selectChildList.do?orgId=${requestScope.parent.id }&objname=${requestScope.humres.objname}&orgIdCheck=${requestScope.orgIdCheck }&inputId=<%=inputId%>&inputName=<%=inputName%>" method="post">
	      	<%@include file="/public/pagination.jsp" %>
	  		</form>
  		</div>
	</div>
	</div>
</body>
</html>