<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.navi.orgnization.model.Org"%>
<%@page import="com.navi.utils.IPage"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	IPage pageBean=(IPage)request.getAttribute("pageBean");
	List<Org> list=(List<Org>)request.getAttribute("childList");
	
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
    		location.href="<%=basePath%>org/selectChildList.do?pid="+id+"&inputId=${requestScope.inputId }&inputName=${requestScope.inputName }";
    }
    </script>
    <style type="text/css">
    </style>
  </head>
 <body>
 	<div id="warper">
  		<div class="tab" ${requestScope.isRoot?"style='display:none'":"" }>
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">${requestScope.parent.namePath }</a></li>
  			</ul>
  			<button style="margin-left:15px;" class="btn" onclick="location.href='<%=basePath%>org/selectChildList.do?pid=${requestScope.parent.pid }&inputId=${requestScope.inputId }&inputName=${requestScope.inputName }'">返回上一级</button>
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
  				<li class="first active"><a href="javascript:void(0);">组织列表</a></li>
  			</ul>
  			<table class="tabList">
  				<tr>
  					<th>组织名称</th>
  				</tr>
  				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
  				<tr style="cursor:pointer;" onclick="singleSelect('${requestScope.inputId }','${requestScope.inputName }','${s.id }','${s.namePath }');">
  					<td>${s.namePath }</td>
  				</tr>
  				</c:forEach>
  			</table>
	  		<form id="NaviForm" name="NaviForm" action="<%=basePath %>org/selectChildList.do?pid=${requestScope.parent.id }&objname=${requestScope.org.objname}&inputId=${requestScope.inputId }&inputName=${requestScope.inputName }" method="post">
	      	<%@include file="/public/pagination.jsp" %>
	  		</form>
  		</div>
	</div>
	</div>
</body>
</html>