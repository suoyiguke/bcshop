<%@page import="com.navi.utils.IPage"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	IPage pageBean=(IPage)request.getAttribute("pageBean");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
	<base href="<%=basePath%>" >
    <title></title>
    <%@include file="/public/common.jsp" %>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-browse_select.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
    <style type="text/css">
    	#warper{
    		width:60%;
    		float:left;
    		border:1px solid #99BBE8;
    	}
    	#centerWrap{
    		margin-top:100px;
    		width:10%;
    		float:left;
    		text-align:center;
    	}
    	#centerWrap ul li{
    		margin-top:25px;
    	}
    	#rightWrap{
    		width:25%;
    		float:left;
    		margin-left:1%;
    		border:1px solid #99BBE8;
    	}
    	.searchbar tr input[type="text"], div.tabContent tr input[type="password"] {
		  width: 80%;
		}
    </style>
    <script type="text/javascript">
    	function search(){
    		$("#NaviForm").submit();
    	}
    	var browserType="${requestScope.browserType}";
    	$(function(){
    		$(".tabList").naviTableList();
    		$(".getFieldNameById").naviGetFieldNameById({idKey:"dataKey"});
    		var ids="${requestScope.selectedIds}".split(",");
    		var names="";
    		$.ajax({
    			url:"<%=basePath %>data/getFieldNameById.do",
    			async:false,
    			dataType:"json",
    			data:{id:"${requestScope.selectedIds}",fieldName:"objname",tableName:"selectitem"},
    			type:"post",
    			success:function(data){
    				if(data.success=="ok"){
    					names=data.msg.split(",");
    					$("#selectedNames").val(data.msg);
    				}
    			}
    			
    		});
    		for(var i=0;i<ids.length;i++){
    			if(ids[i]!=""){
    				$("#selectedShow").append("<option value='"+ids[i]+"'>"+names[i]+"</option>");
    			}
    		}
 			
    	});
    	function search(){
    		$("#NaviForm").submit();
    	}
    	function selectObj(id,name){
    		var selVal=$.trim($("#selectedIds").val());
    		var selNames=$.trim($("#selectedNames").val());
    		if(browserType=="multi"){
	    		if(selVal.indexOf(id)==-1){
	    			$("#selectedShow").append("<option value='"+id+"'>"+name+"</option>");
	    			if(selVal==""||selVal.substr(selVal.length-1,selVal.length)==","){
		    			selVal+=id;
	    			}else{
	    				selVal+=","+id;
	    			}
	    			if(selNames==""||selNames.substr(selNames.length-1,selNames.length)==","){
		    			selNames+=name;
	    			}else{
	    				selNames+=","+name;
	    			}
		    		$("#selectedIds").val(selVal);
		    		$("#selectedNames").val(selNames);
	    		}
    		}else{
    			$("#selectedShow").find("option").remove();
    			$("#selectedShow").append("<option value='"+id+"'>"+name+"</option>");
    			$("#selectedIds").val(id);
	    		$("#selectedNames").val(name);
    		}
    	}
    	
    	function rmSel(){
    		$("#selectedShow").find("option:selected").each(function(){
    			var selVal=$("#selectedIds").val();
    			var selName=$("#selectedNames").val();
    			var tmpVal=$(this).val()+",";
    			var tmpName=$(this).text()+",";
    			selVal=selVal.replace(tmpVal,"").replace($(this).val(),"");
    			selName=selName.replace(tmpName,"").replace($(this).text(),"");
    			$("#selectedIds").val(selVal);
    			$("#selectedNames").val(selName);
    			$(this).remove();
    		});
    	}
    	function choose(){
   			var idVal=$("#selectedIds").val();
   			var nameVal=$("#selectedNames").val();
   			if(idVal.substr(idVal.length-1,idVal.length)==","){
   				idVal=idVal.substr(0,idVal.length-1);
   			}
   			if(nameVal.substr(nameVal.length-1,nameVal.length)==","){
   				nameVal=nameVal.substr(0,nameVal.length-1);
   			}
   			selectRefobj(idVal,nameVal);
    	}
    	function rmAll(){
    		$("#selectedShow").find("option").remove();
    		$("#selectedIds").val("");
    		$("#selectedNames").val("");
    	}
    </script>
  </head>
 <body>
 	<div id="warper" style="width:60%;float:left;border:1px solid #99BBE8;">
 		<div class="nav">
  			系统设置> 选择项选择>
  		</div>
  		<div class="toolbar" >
  			<button class="btn" type="button" onclick="choose();">选择(C)</button>
  			<button class="btn" type="button" onclick="clearSelect('${requestScope.inputId }','${requestScope.inputName }');">清除(C)</button>
  			<button class="btn" type="button" onclick="search();">搜索(S)</button>
  		</div>
  		<form id="NaviForm" name="NaviForm" action="<%=basePath %>selectitem/selectList.do" method="post">
  		<input type="hidden" id="selectedIds" name="selectedIds" value="${requestScope.selectedIds}"/>
		<input type="hidden" id="selectedNames" name="selectedNames" value="${requestScope.selectedNames}"/>
		<input type="hidden" name="inputId"  value="${requestScope.inputId }"/>
		<input type="hidden" name="inputName"  value="${requestScope.inputName }"/>
  		<div class="searchbar">
  			<table>
  				<tr>
  					<th>选择项名称</th>
  					<td>
  					<input type="text" name="objname"  id="objname" value="${requestScope.selectitem.objname }"/>
  					<input type="hidden" name="pid" value="${requestScope.selectitem.pid }" id="pid"/>
  					<input type="hidden" name="inputId" value="${requestScope.inputId }" id="inputId"/>
  					<input type="hidden" name="inputName" value="${requestScope.inputName }" id="inputName"/>
  					</td>
  					<th>选择项描述</th>
  					<td><input type="text" name="description" id="description" value="${requestScope.selectitem.objdesc }"/></td>
  				</tr>
  			</table>
  		</div>
  		<div>
  			<table class="tabList">
  				<tr>
  					<th>选择项名称</th>
  					<th>选择项描述</th>
  				</tr>
  				<c:forEach items="${requestScope.pageBean.recordList }" var="s" >
  				<tr style="cursor:pointer;" onclick="selectObj('${s.id }','${s.objname }');">
  					<td>${s.objname }</td>
  					<td>${s.objdesc }</td>
  				</tr>
  				</c:forEach>
  			</table>
  		</div>
  		<%@include file="/public/pagination.jsp" %>
  		</form>
	</div>
	
	<div id="centerWrap" style="width:10%;float:left;text-align:center;">
		<ul>
			<li><button class="btn" type="button" onclick="rmSel();">移除选中</button></li>
			<li><button class="btn" type="button" onclick="rmAll();">移除全部</button></li>
		</ul>
	</div>
	<div id="rightWrap" style="width:25%;float:left;margin-left:1%;border:1px solid #99BBE8;">
		<select multiple="multiple" id="selectedShow" style="width:100%;height:350px;">
		</select>
	</div>
</body>
</html>