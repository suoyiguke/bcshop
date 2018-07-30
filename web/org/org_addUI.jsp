<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'Category_add.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link  rel="stylesheet" href="<%=path %>/css/fam-icons.css" type="text/css"/>
	<%@include file="/public/common.jsp" %>
	<script type="text/javascript" src="<%=path %>/js/navi/navi-delete.js"></script>
	<script type="text/javascript" src="<%=path %>/js/navi/navi-treeDelete.js"></script>
	<script type="text/javascript">
		function formSubmit(){
			var naviForm=$("#NaviForm");
			var url=naviForm.attr("action");
			var pid="${requestScope.org.id}";
			$.post(url,naviForm.serialize(),function(data){
				if(data.isOk==1){
					sysAlert("添加成功！");
					var node={id:data.id,text:data.msg,iconCls:"icon-folder",type:"org"};
					window.parent.addNode(pid,node);
				}
			},"json");
		}
		$(function(){
			$(".del").treeDelete({url:"<%=path %>/org/delete.do?id=${requestScope.org.id }"});
		});
	</script>
	
	<style type="text/css">
		.iconBtn{
			background: url('css/imgs/backX.gif') repeat-x;
			background-position: 0px -166px;
			border: 1px solid #8c9abb;
			padding:2px 5px;
		}
		
	</style>
  </head>
  <body style="background:#fff;">
  	<div id="wrap">
  		<div class="nav">
  			系统设置 > 组织单元 > ${requestScope.org.objname}
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="formSubmit();">提交(S)</button>
  			<c:if test="${!empty(requestScope.org) }">
  			<button class="btn del" >删除(D)</button>
  			<button class="btn" onclick="location.href='<%=path %>/org/addUI.do?pid=${requestScope.org.id }'">新增组织(ON)</button>
  			<button class="btn" onclick="location.href='<%=path %>/station/addUI.do?orgId=${requestScope.org.id }'">新增岗位(SN)</button>
  			</c:if>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">组织单元${(empty requestScope.org) ?"新增":"修改" }</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviForm" name="NaviForm" action="<%=path %>/org/${(empty requestScope.org) ?"add":"edit" }.do" method="post">
			       	<table class="addTable">
			           <tbody>
			           	   <tr>
			                   <th>编号</th>
			                   <td>
			                   <input type="hidden"  name="id" value="${(empty requestScope.org) ? '':requestScope.org.id }"/>
			                   <input type="text" class="text" name="objno" value="${(empty requestScope.org) ? '':requestScope.org.objno }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>名称</th>
			                   <td>
			                   <input type="text" class="text" name="objname" value="${(empty requestScope.org) ? '':requestScope.org.objname }"/>
			                   <input type="hidden" class="text" name="id" value="${(empty requestScope.org) ? '':requestScope.org.id }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>上级组织</th>
			                   <td>
			                   		<input type="hidden"  id="pid" name="pid" value="${requestScope.parent.id }"/>
				                	<input readOnly="readOnly" type="text" id="pidName" value="${requestScope.parent.namePath }"name="pidName"/>
				                	<button type="button" class="browser" style="cursor:pointer" onclick="popWin('<%=path %>/org/selectList.do','pid','pidName')">
				                	</button>
				                	<a onclick="clearValue('pid','pidName');" href="javascript:void(0);">清除</a>
			                   </td>
			               </tr>
			               <tr>
			                   <th>上级管理岗位</th>
			                   <td>
			                  	<input type="hidden"  id="parentStationId" name="parentStationId" value="${empty requestScope.parentStation?'': requestScope.parentStation.id}"/>
			                	<input readOnly="readOnly" type="text" id="parentStationName" value="${empty requestScope.parentStation?'': requestScope.parentStation.objname}"name="parentStationName"/>
			                	<button type="button" class="browser" style="cursor:pointer" onclick="popWin('<%=path %>/station/treeSelect.do','parentStationId','parentStationName')">
			                	</button>
			                	<a onclick="clearValue('parentStationId','parentStationName');" href="javascript:void(0);">清除</a>
			                   </td>
			               </tr>
			               <tr>
			                   <th>组织负责岗位</th>
			                   <td>
			                    <input type="hidden"  id="manageStationId" name="manageStationId" value="${empty requestScope.manageStation?'': requestScope.manageStation.id}"/>
			                	<input readOnly="readOnly" type="text" id="manageStationName" value="${empty requestScope.manageStation?'': requestScope.manageStation.objname}"name="manageStationName"/>
			                	<button type="button" class="browser" style="cursor:pointer" onclick="popWin('<%=path %>/station/treeSelect.do?orgId=${(empty requestScope.org)?'':requestScope.org.id }','manageStationId','manageStationName')">
			                	</button>
			                	<a onclick="clearValue('manageStationId','manageStationName');" href="javascript:void(0);">清除</a>
			               </tr>
			                <tr>
			                   <th>组织负责人</th>
			                   <td>
			                    <input type="hidden"  id="managerId" name="managerId" value="${empty requestScope.manager?'': requestScope.manager.id}"/>
			                	<input readOnly="readOnly" type="text" id="managerName" value="${empty requestScope.manager?'': requestScope.manager.objname}"name="managerName"/>
			                	<button type="button" class="browser" style="cursor:pointer" onclick="popWin('<%=path %>/humres/selectList.do','managerId','managerName')">
			                	</button>
			                	<a onclick="clearValue('managerId','managerName');" href="javascript:void(0);">清除</a>
			               </tr>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${(empty requestScope.org) ? '':requestScope.org.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
      </div>
  </body>
</html>