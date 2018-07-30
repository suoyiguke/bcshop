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
    <base href="<%=basePath%>">
    <%@include file="/public/common.jsp" %>
    <script type="text/javascript" src="<%=basePath %>js/layer/layer.js"></script>
    <link  rel="stylesheet" href="<%=basePath %>js/layer/skin/layer.css" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-layer.js"></script>
	<style type="text/css">
	.tabNameTr{
		display:none;
	}
	</style>
	<script type="text/javascript">
		function formSubmit(){
			$("#NaviForm").submit();
		}
		$(function(){
			$(".popWin").naviLayer();
			$("#isFromFormInfo").change(function(){
				$("tr.hd").hide();
				if($(this).val()==0){
					$("tr.tabNameTr").show();
				}else{
					$("tr.formIdTr").show();
				}
			});
		});
	</script>
  </head>
 <body>
	<div id="wrap">
		<div class="nav">
  			系统设置> 报表${(empty requestScope.reportTable)?"添加":"修改"}>
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="formSubmit();">提交(S)</button>
  			<button class="btn" onclick="history.go(-1);">删除(D)</button>
  			<button class="btn" onclick="location.href='<%=basePath %>reportTable/list.do?reportTableId=${requestScope.reportTableId }'">返回(B)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">报表${(empty requestScope.reportTable)?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviForm" name="NaviForm" action="<%=basePath %>reportTable/${(empty requestScope.reportTable) ?"add":"edit" }.do" method="post">
			       	<table>
			           <tbody class="addTable">
			           		<tr>
			                   <th>报表名称</th>
			                   <td>
			                   <input type="text" class="text" name="objname" value="${(empty requestScope.reportTable) ? '':requestScope.reportTable.objname }"/>
			                   </td>
			               </tr>
			               <tr>
			               		<th>报表来源</th>
			               		<td>
			               			<select id="isFromFormInfo" name="isFromFormInfo">
			               				<option value="1">系统表单</option>
			               				<option value="0">数据库表/视图</option>
			               			</select>
			               		</td>
			               </tr>
			               <tr class="hd formIdTr">
			                   <th>选取表单</th>
			                   <td>
			                   <input  type="hidden" id="formId" name="formId" value="${requestScope.reportTable.formId }"/>
			                   <input idspan="formId" id="formName" namespan="formName" url="<%=basePath %>form/selectList.do" type="text" class="text popWin" value=""/>
			                    <button type="button" idspan="formId"  namespan="formName" url="<%=basePath %>form/selectList.do" class="browser popWin">
			                	</button>
			                   </td>
			               </tr>
			               <tr class="hd tabNameTr">
			                   <th>数据库表名</th>
			                   <td>
			                   <input type="text" class="text" name="tabName" value="${requestScope.reportTable.tabName }"/>
			                   </td>
			               </tr>
			               <tr >
				               	<th>分类</th>
		  						<td>
		  						<select name="typeId" id="typeId">
		  							<option value="">==请选择分类==</option>
		  							<c:forEach items="${requestScope.typeList }" var="s">
		  								<option value="${s.id }" <c:if test="${s.id==requestScope.reportTable.typeId }">selected="selected"</c:if>>${s.objname }</option>
		  							</c:forEach>
		  						</select>
	  							</td>
  						  </tr>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${requestScope.reportTable.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
	</div>
</body>
</html>