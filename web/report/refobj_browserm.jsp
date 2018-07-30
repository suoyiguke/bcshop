<%@page import="com.navi.utils.StringUtils"%>
<%@page import="com.navi.report.model.SearchFieldType"%>
<%@page import="com.navi.utils.IPage"%>
<%@page import="com.navi.report.model.Refobj"%>
<%@page import="com.navi.report.model.ReportColumn"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	IPage pageBean=(IPage)request.getAttribute("pageBean");
	List<ReportColumn> showHeaderList=(List<ReportColumn>)request.getAttribute("showHeaderList");
	List<ReportColumn> searchFieldList=(List<ReportColumn>)request.getAttribute("searchFieldList");
	Map<String,String> searchMap=(Map<String,String>)request.getAttribute("searchMap");
	String inputId=(String)request.getAttribute("inputId");
	String inputName=(String)request.getAttribute("inputName");
	Refobj refObj=(Refobj)request.getAttribute("refObj");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
	<base href="<%=basePath%>" >
    <title></title>
    <%@include file="/public/common.jsp" %>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-browse_select.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/datepicker/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
    <style type="text/css">
    	#warper{
    		width:70%;
    		float:left;
    		border:1px solid #99BBE8;
    	}
    	#centerWrap{
    		margin-top:100px;
    		width:80px;
    		float:left;
    		text-align:center;
    	}
    	#centerWrap ul li{
    		margin-top:25px;
    	}
    	#rightWrap{
    		width:20%;
    		float:left;
    		margin-left:1%;
    		border:1px solid #99BBE8;
    	}
    </style>
    <script type="text/javascript">
    	$(function(){
    		$(".tabList").naviTableList();
    		$(".getFieldNameById").naviGetFieldNameById({idKey:"dataKey"});
    		var ids="${requestScope.selectedIds}".split(",");
    		var names="";
    		$.ajax({
    			url:"<%=basePath %>data/getFieldNameById.do",
    			async:false,
    			dataType:"json",
    			data:{id:"${requestScope.selectedIds}",fieldName:"${requestScope.refObj.showField}",tableName:"${requestScope.refObj.tabName}"},
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
 <body style="padding:10px;">
	<form id="NaviForm" name="NaviForm" action="<%=basePath %>refobj/browser.do" method="post">
	<input type="hidden" id="selectedIds" name="selectedIds" value="${requestScope.selectedIds}"/>
	<input type="hidden" id="selectedNames" name="selectedNames" value="${requestScope.selectedNames}"/>
	<input type="hidden" name="inputId"  value="${requestScope.inputId }"/>
	<input type="hidden" name="inputName"  value="${requestScope.inputName }"/>
 	<div id="warper">
  		<div class="toolbar" >
  			<button class="btn" type="button" onclick="choose();">选择(C)</button>
  			<button class="btn" type="button" onclick="clearSelect('${requestScope.inputId }','${requestScope.inputName }');">清除(C)</button>
  			<button class="btn" type="button" onclick="search();">搜索(S)</button>
  		</div>
  		<input type="hidden" name="id"  value="${requestScope.refObj.id }"/>
  		<div class="searchbar">
  			<table>
  				<%
					for(int i=0;i<searchFieldList.size();i++){ 
						ReportColumn rc=searchFieldList.get(i);
						if("id".equalsIgnoreCase(rc.getObjname())){
							continue;
						}
					%>
						<%if(i%3==0){ %>
							<tr>
						<%} %>
						<th><%=rc.getObjname() %></th>
						<td>
						<%if(SearchFieldType.TEXT.equals(rc.getSearchFieldType())){ 
						%>
							<input type="text" name="<%=rc.getColName() %>"  id="<%=rc.getColName() %>" value="<%=StringUtils.trim(searchMap.get(rc.getColName())) %>"/>
						<%}else if(SearchFieldType.DATE.equals(rc.getSearchFieldType())){ %>
							<input readonly="readonly" style="width:100px;"class="Wdate" type="text" value="<%=StringUtils.trim(searchMap.get(rc.getColName()+"_begin")) %>" onclick="WdatePicker({isShowWeek:true})" id="<%=rc.getColName() %>_begin" name="<%=rc.getColName() %>_begin">-
							<input readonly="readonly"  style="width:100px;" class="Wdate" type="text" value="<%=StringUtils.trim(searchMap.get(rc.getColName()+"_end")) %>"onclick="WdatePicker({isShowWeek:true})" id="<%=rc.getColName() %>_end" name="<%=rc.getColName() %>_end">
							<a onclick="clearValue('<%=rc.getColName() %>_begin','<%=rc.getColName() %>_end');" href="javascript:void(0);">清除</a>
						<%}else if(SearchFieldType.SELECTITEM.equals(rc.getSearchFieldType())){ %>
							<input type="hidden"  id="<%=rc.getColName() %>" name="<%=rc.getColName() %>" value="<%=StringUtils.trim(searchMap.get(rc.getColName()))%>"/>
		                	<input class="getFieldNameById" tableName="selectitem" fieldName="objname"  readOnly="readOnly" type="text" onclick="popWin('<%=basePath %>selectitem/selectList.do?pid=<%=rc.getSearchBrowserValue()  %>','<%=rc.getColName() %>','<%=rc.getColName() %>_name')" id="<%=rc.getColName() %>_name" dataKey="<%=StringUtils.trim(searchMap.get(rc.getColName())) %>" value="" name="<%=rc.getColName() %>_name"/>
		                	<button type="button" class="browser" onclick="popWin('<%=basePath %>selectitem/selectList.do?pid=<%=rc.getSearchBrowserValue()  %>','<%=rc.getColName() %>','<%=rc.getColName() %>_name')">
		                	</button>
	                		<a onclick="clearValue('<%=rc.getColName() %>','<%=rc.getColName() %>_name');" href="javascript:void(0);">清除</a>
						<%}else if(SearchFieldType.REFOBJ.equals(rc.getSearchFieldType())){ %>
							<input type="text" name="<%=rc.getColName() %>"  id="<%=rc.getColName() %>" value=""/>
						<%}else{%>
							<input type="text" name="<%=rc.getColName() %>"  id="<%=rc.getColName() %>" value="<%=StringUtils.trim(searchMap.get(rc.getColName())) %>"/>
						<%} %>
						</td>
						<%if(i!=0&&i%3==0){ %>
							</tr>
						<%} 
					}
					%>
  				
  			</table>
  		</div>
  		<div class="tab">
			<table class="tabList">
				<tr>
					<%for(ReportColumn c:showHeaderList){ %>
						<%if(!"id".equalsIgnoreCase(c.getObjname())){ %>
						<th><%=c.getObjname() %></th>
						<%} %>
					<%}%>
				</tr>
				<%
					List<Map<String,Object>> list=pageBean.getRecordList();
					for(int i=0;i<list.size();i++){
						Map<String,Object> map=list.get(i);
				 %>
				<tr style="cursor:pointer;" onclick="selectObj('<%=map.get(refObj.getIdField())%>','<%=map.get(refObj.getShowField())%>');">
					<%
					for(ReportColumn tf:showHeaderList){
						if("id".equalsIgnoreCase(tf.getColName())){
							continue;
						}
					%>
					<td><%=StringUtils.trim(map.get(tf.getColName())) %></td>
					<%
					}
					%>	
				</tr>
				<%	} %>
				
			</table>
      	</div>
      	<%@include file="/public/pagination.jsp" %>
	</div>
	<div id="centerWrap">
		<ul>
			<li><button class="btn" type="button" onclick="rmSel();">移除选中</button></li>
			<li><button class="btn" type="button" onclick="rmAll();">移除全部</button></li>
		</ul>
	</div>
	<div id="rightWrap">
		<select multiple="multiple" id="selectedShow" style="width:100%;height:350px;">
		</select>
	</div>
	</form>
</body>
</html>