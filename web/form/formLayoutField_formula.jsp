<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
	<base href="<%=basePath%>" >
    <title></title>
    <%@include file="/public/common.jsp" %>
    <style type="text/css">
    </style>
    <script type="text/javascript">
    	$(function(){
    		$("ul li button.justAppend").click(function(){
    			$("#content").append(" "+$(this).attr("id")+" ");
    		});
    		$("ul li button.append").click(function(){
    			$("#content").append(" "+$(this).attr("id")+"(\" \")"+" ");
    		});
    		$("#tables li").click(function(){
    			$("#cols li").show();
	    		var id=$(this).attr("id");
	    		$("#cols li[tableInfo!='"+id+"']").hide();
    		});
    		
    		$("#cols li").click(function(){
    			$("#content").append(" $"+$(this).attr("id")+"$ ");
    		});
    		
    	});
    </script>
    <style type="text/css">
    	ul{
    		width:22%;
    		float:left;
    		margin-left:5px;
    		height:300px;
    	}
    	ul.form{
    		border:1px solid #9ab6cd;
    		overflow: auto;
    	}
    	ul.small{
    		width:12%;
    	}
    	ul li{
    		height:25px;
    		line-height:25px;
    	}
    	ul.form li{
    		height:22px;
    		line-height:22px;
    	}
    	ul.form li:hover{
    		background:#eee;
    	}
    	ul.small li{
    		margin-top:10px;
    	}
    </style>
  </head>
 <body>
 	<div id="warper">
 		<div class="nav">
  			系统设置> 布局字段规则设置 > ${requestScope.formLayout.objname} > ${requestScope.field.objdesc}
  		</div>
  		<div class="toolbar" >
  			<button class="btn" onclick="addOrEdit();" id="saveBtn">保存(S)</button>
  			<button class="btn" onclick="closePanel('naviPanel',true)">取消(C)</button>
  		</div>
  		<form id="NaviAddForm" name="NaviAddForm" action="<%=basePath%>formLayoutField/saveFormula.do" method="post">
  		<div style="margin:5px;">
  			<textarea id="content" name="formula" style="width:95%;height:100px;">${requestScope.formLayoutField.formula}</textarea>
  			<input type="hidden" name="id" value="${requestScope.formLayoutField.id}"/>
  		</div>
  		</form>
  		<div>
  			<ul id="tables" class="form">
  				<c:forEach items="${requestScope.formList }" var="t">
	       			<li id="${t.id }">${t.objdesc }</li>
	       		</c:forEach>
  			</ul>
  			<ul id="cols" class="form">
  				<c:forEach items="${requestScope.fieldList }" var="c">
	       			<li tableInfo="${c.formId }" id="${c.id }" title="${c.formObjdesc}(${c.formObjname})->${c.objdesc }(${c.objname})">${c.objdesc }</li>
	       		</c:forEach>
  			</ul>
  			<ul  class="small" style="margin-left:40px;">
  				<li><button class="btn justAppend" title="等于"  id="EQ">=</button></li>
  				<li><button class="btn justAppend" title="小于" id="LT"><</button></li>
  				<li><button class="btn justAppend" title="大于"  id="GT">></button></li>
  				<li><button class="btn append" title="求和"  id="SUM">SUM</button></li>
  				<li><button class="btn append" title="SQL语句"  id="SQL">SQL</button></li>
  			</ul>
  			<ul  class="small">
  				<li><button class="btn justAppend" title="不等于" class="justAppend" id="NEQ">!=</button></li>
  				<li><button class="btn justAppend" title="小于等于" class="justAppend" id="LE"><=</button></li>
  				<li><button class="btn justAppend" title="大于等于" class="justAppend" id="GE">>=</button></li>
  				<li><button class="btn append" title="金额转换" class="append" id="RMB">RMB</button></li>
  				<li><button class="btn append" title="最大值" class="append" id="MAX">MAX</button></li>
  			</ul>
  			<ul class="small">
  				<li><button class="btn justAppend"  class="justAppend" id="$currentDate$">当前日期</button></li>
  				<li><button class="btn justAppend"  class="justAppend" id="$currentDatetime$">当前日期时间</button></li>
  				<li><button class="btn justAppend"  class="justAppend" id="$currentUser$">当前用户</button></li>
  				<li><button class="btn justAppend"  class="justAppend" id="$currentOrg$">当前部门</button></li>
  				<li><button class="btn justAppend"  class="justAppend" id="$currentStation$">当前岗位</button></li>
  				<li><button class="btn append"  class="append" id="param">获取参数</button></li>
  			</ul>
  		</div>
	</div>
</body>
</html>