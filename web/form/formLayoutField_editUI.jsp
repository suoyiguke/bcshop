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
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-checkAll.js"></script>
    <link  rel="stylesheet" href="<%=basePath %>js/jsPanel/jquery-ui.min.css" type="text/css"/>
    <link  rel="stylesheet" href="<%=basePath %>js/jsPanel/jquery.jspanel.css" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>js/jsPanel/mobile-detect.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jsPanel/jquery-ui.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jsPanel/jquery.jspanel.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-panel.js"></script>
    <style type="text/css">
    </style>
    <script type="text/javascript">
    	$(function(){
    		$(".tabList").naviTableList();
    		$(".chkAll").naviCheckAll({
    			beforeClick:function(){$("input[type='checkbox']").prop("checked",false);}
    		});
    		
    		//保存
			$("#saveBtn").click(function(){
				var f=$("#NaviEditForm");
				var url=f.attr("action");
				$.post(url,f.serialize(),function(data){
					if(data.success=="ok"){
						alert(data.msg);
						location.reload();
					}else{
						alert(data.msg);
					}
				},"json");
			});
			
			//搜索
			$("#searchBtn").click(function(){
				$("#NaviForm input[type='hidden'][name='objname']").val(
    				$(".searchbar input[type='text'][name='objname']").val()
    			);
	    		$("#NaviForm input[type='hidden'][name='colName']").val(
	    			$(".searchbar input[type='text'][name='colName']").val()
	    		);
	    		$("#NaviForm").submit();
			});
			
			$("input.formula").naviPanel();
    	});
    	function checkProperty(id,el){
    		$(".chkAll").prop("checked",false);
    		$(el).parents("tr").find("td input[type='checkbox']").prop("checked",false);
    		$(el).prop("checked",true);
    	}
    </script>
  </head>
 <body>
 	<div id="naviPanel"></div>
 	<div id="warper">
 		<div class="nav">
  			系统设置> 布局字段设置 > ${requestScope.formLayout.objname }
  		</div>
  		<div class="toolbar" >
  			<button class="btn" id="searchBtn">搜索(S)</button>
  			<button class="btn" id="saveBtn">保存(S)</button>
  		</div>
  		<div class="searchbar">
  			<table>
  				<tr>
  					<th>字段名称</th>
  					<td><input type="text" name="colName"  id="colName" value="${requestScope.field.colName }"/></td>
  					<th>字段描述</th>
  					<td><input type="text" name="objname" id="objname" value="${requestScope.field.objname }"/></td>
  				</tr>
  			</table>
  		</div>
  		<div>
	  		<form id="NaviEditForm" name="NaviEditForm" action="<%=basePath %>formLayoutField/batchUpdate.do" method="post">
  			<table class="tabList">
  				<colgroup>
  					<col width="12%">
  					<col width="15%">
  					<col width="5%">
  					<col width="5%">
  					<col width="5%">
  					<col width="5%">
  					<col width="8%">
  					<col width="18%">
  					<col>
  				</colgroup>
  				<tr>
  					<th>字段名称</th>
  					<th>字段描述</th>
  					<th><input type="checkbox" class="chkAll" chkListCls="hideChkList" id="hide"/>隐藏</th>
  					<th><input type="checkbox" class="chkAll" chkListCls="readonlyChkList" id="readonly"/>只读</th>
  					<th><input type="checkbox" class="chkAll" chkListCls="showChkList" id="show"/>显示</th>
  					<th><input type="checkbox" class="chkAll" chkListCls="editableChkList" id="editable"/>可编辑</th>
  					<th><input type="checkbox" class="chkAll" chkListCls="must_enterChkList" id="must_enter"/>必须输入</th>
  					<th>默认值</th>
  					<th>公式</th>
  				</tr>
  				<c:forEach items="${requestScope.pageBean.recordList }" var="s" >
  				<input type="hidden" value="${s.id }" name="id" />
  				<tr title="${s.formTabName }->${s.fieldColName }">
  					<td>${s.fieldColName }</td>
  					<td>${s.formObjname }->${s.fieldObjname}</td>
  					<td><input type="checkbox" name="formLayoutFieldType" value="hidden" onclick="checkProperty('${s.id}',this)" ${(s.formLayoutFieldType=="hidden")?"checked='checked'":"" } class="hideChkList" /></td>
  					<td><input type="checkbox" name="formLayoutFieldType" value="readonly" onclick="checkProperty('${s.id}',this)" ${(s.formLayoutFieldType=="readonly")?"checked='checked'":"" } class="readonlyChkList"/></td>
  					<td><input type="checkbox" name="formLayoutFieldType" value="show" onclick="checkProperty('${s.id}',this)" ${(s.formLayoutFieldType=="show")?"checked='checked'":"" } class="showChkList" /></td>
  					<td><input type="checkbox" name="formLayoutFieldType" value="editable" onclick="checkProperty('${s.id}',this)" ${(s.formLayoutFieldType=="editable")?"checked='checked'":"" } class="editableChkList" /></td>
  					<td><input type="checkbox" name="formLayoutFieldType" value="must_enter" onclick="checkProperty('${s.id}',this)" ${(s.formLayoutFieldType=="must_enter")?"checked='checked'":"" } class="must_enterChkList" /></td>
  					<td><input type="text" value="${s.defaultValue }" style="width:80%" name="defaultValue" id="defaultValue"/></td>
  					<td><input type="text" value="${s.formula }" style="width:80%" w="1000" h="500" t="20" url="<%=basePath %>formLayoutField/formula.do?formLayoutId=${requestScope.formLayout.id }&id=${s.id }" title="规则设置" class="formula" name="formula"/></td>
  				</tr>
  				
  				</c:forEach>
  			</table>
  			</form>
  		</div>
  		<form id="NaviForm" name="NaviForm" action="<%=basePath %>formLayoutField/editUI.do" method="post">
	  		<input type="hidden" name="objname"  value="${requestScope.field.objname }"/>
	  		<input type="hidden" name="colName"  value="${requestScope.field.colName }"/>
	  		<input type="hidden" name="formLayoutId" value="${requestScope.formLayout.id }"/>
	  		<%@include file="/public/pagination.jsp" %>
  		</form>
	</div>
</body>
</html>