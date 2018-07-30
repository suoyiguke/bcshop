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
    <base href="<%=basePath%>" >
    <title></title>
      <%@include file="/public/common.jsp" %>
        <link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-checkAll.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-batchDelete.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-delete.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/layer/layer.js"></script>
    <link  rel="stylesheet" href="<%=basePath %>js/layer/skin/layer.css" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-layer.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
	<script type="text/javascript">
		$(function(){
			//鼠标移动换色
			$(".tabList").naviTableList();
			//全选、反选
			$("#chkAll").naviCheckAll();
			$("#searchBtn").click(function(){
				$("#NaviForm").submit();
			});
			$("#addBtn").click(function(){
				var nodeId=$("#nodeList option:selected").val();
				if(nodeId==""){
					sysAlert("请选择一个节点作为开始节点吧!");
					return;
				}
				var nodeName=$("#nodeList option:selected").text();
				var trHtml=getAddRowHtml(nodeId, nodeName);
				$("table.tabList").append(trHtml);
			});
			$("#delBtn").click(function(){
				var chkList=$("input.chkList:checked");
				if(chkList.length>0){
					chkList.parents("tr").each(function(){
						var id=$(this).find("input[name='id']").val();
						if(id!=""){
							var delIds=$("#delIds");
							delIds.val(delIds.val()+id+",");
						}
						$(this).remove();
					});	
				}else{
					sysAlert("请先选择要删除的项!");
				}
				
			});
			$("#saveBtn").click(function(){
				var flag=true;
				$("#SaveForm select[name='toNodeId']").each(function(){
					var v=$(this).find("option:selected").val();
					if(v==""){
						flag=false;
					}
				});
				if(flag){
					$.post($("#SaveForm").attr("action"),$("#SaveForm").serialize(),function(data){
						if(data.isOk==1){
							sysAlert(data.msg);
							location.reload();
						}
					},"json");
				}else{
					sysAlert("目标节点不能为空哟!");
				}
			});
			//类型
			$("span.getFieldNameById").naviGetFieldNameById();
		});
		
		function getAddRowHtml(nodeId,nodeName){
			var trHtml="<tr><td><input type=\"hidden\" name=\"id\" value=\"\"/><input type=\"checkbox\" class=\"chkList\" />";
			trHtml+="<td><input type=\"hidden\" name=\"fromNodeId\" value=\""+nodeId+"\">"+nodeName+"</td>";
			trHtml+="<td>"+$("#toNodeList").html()+"</td>";
			trHtml+="<td><input name=\"position\" value=\"\"/></td>";
			trHtml+="</tr>";
			return trHtml;
		}
	</script>
  </head>
 <body>
 	<div id="naviPanel"></div>
	<div id="wraper">
		<div class="nav">
			系统设置> 出口列表
		</div>
		<div class="toolbar" >
			<select id="nodeList">
				<option value="">**********请选择当前节点**********</option>
				<c:forEach items="${requestScope.nodeList }" var="s">
					<option value="${s.id }">${s.objname }</option>
				</c:forEach>
			</select>
			<div id="toNodeList" style="display:none;">
				<select name="toNodeId">
					<option value="">***请选择目标节点***</option>
					<c:forEach items="${requestScope.nodeList }" var="s">
						<option value="${s.id }">${s.objname }</option>
					</c:forEach>
				</select>
			</div>
			<button class="btn" id="addBtn">添加出口(A)</button>
			<button class="btn" id="delBtn">删除出口(D)</button>
			<button class="btn" id="saveBtn">保存(S)</button>
		</div>
		<div>
			<form id="SaveForm" action="<%=basePath %>export/batchEdit.do" method="post">
			<input type="hidden" id="delIds" name="delIds" value=""/>
			<input type="hidden"  name="pipeId" value="${requestScope.export.pipeId }"/>
			<table  class="tabList">
				<colgroup>
					<col width="4%">
					<col width="">
					<col width="">
					<col width="">
					<col width="">
				</colgroup>
				<tr>
					<th><input type="checkbox" chkListCls="chkList" id="chkAll"/></th>
					<th>节点名称</th>
					<th>出口名称</th>
					<th>目标节点</th>
					<th>顺序</th>
				</tr>
				
				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
				<tr>
					<td>
						<input type="checkbox" class="chkList" id="${s.id }"/>
						<input type="hidden" name="id" value="${s.id }"/>
						<input type="hidden" name="fromNodeId" value="${s.fromNodeId }"/>
					</td>
					<td><span class="getFieldNameById" tableName="nodeInfo" fieldName="objname" id="${s.fromNodeId }"></span></td>
					<td><input name="objname" value="${s.objname }"/></td>
					<td>
						<select name="toNodeId">
							<option value="">***请选择目标节点***</option>
							<c:forEach items="${requestScope.nodeList }" var="c">
								<option <c:if test="${s.toNodeId==c.id }">selected</c:if> value="${c.id }">${c.objname }</option>
							</c:forEach>
						</select>
					</td>
					<td><input name="position" value="${s.position }"/></td>
				</tr>
				</c:forEach>
			</table>
			</form>
			<form id="NaviForm" action="<%=basePath %>export/list.do" method="post">
			<%@include file="/public/pagination.jsp" %>
		    </form>
		 </div>
	</div>
</body>
</html>