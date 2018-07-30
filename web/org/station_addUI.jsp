<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>岗位</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@include file="/public/common.jsp" %>
	<link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-popWin.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-treeDelete.js"></script>
	<script type="text/javascript">
		function formSubmit(){
			var naviForm=$("#NaviForm");
			var url=naviForm.attr("action");
			var pid="${requestScope.org.id }";
			$.post(url,naviForm.serialize(),function(data){
				if(data.isOk==1){
					sysAlert("添加成功！");
					var node={id:data.id,text:data.msg,iconCls:"icon-station",type:"station"};
					window.parent.addNode(pid,node);
				}
			},"json");
		}
		$(function(){
			$(".detailTable").naviTableList();
			$(".del").treeDelete({url:"<%=basePath %>station/delete.do"});
		});
	</script>
	
	<link  rel="stylesheet" href="<%=basePath %>css/navi-tabs.css" type="text/css"/>
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
  			系统设置 > 岗位信息  > ${requestScope.station.objname}
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="formSubmit();">提交(S)</button>
  			<c:if test="${!empty(requestScope.station) }">
  			<button class="btn del" id="${requestScope.station.id }" type="button">删除(D)</button>
  			<button class="btn" onclick="location.href='<%=basePath %>humres/addUI.do?stationId=${requestScope.station.id }'">新增人员(N)</button>
  			</c:if>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">岗位${(empty requestScope.station) ?"添加":"修改" }</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviForm" name="NaviForm" action="<%=basePath %>station/${(empty requestScope.station) ?"add":"edit" }.do" method="post">
			       	<table class="addTable">
			           <tbody>
			           	   <tr>
			                   <th>编号</th>
			                   <td>
			                   <input type="hidden"  name="id" value="${(empty requestScope.station) ? '':requestScope.station.id }"/>
			                   <input type="text" class="text" name="objno" value="${(empty requestScope.station) ? '':requestScope.station.objno }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>名称</th>
			                   <td>
			                   <input type="text" class="text" name="objname" value="${(empty requestScope.station) ? '':requestScope.station.objname }"/>
			                   <input type="hidden" class="text" name="id" value="${(empty requestScope.station) ? '':requestScope.station.id }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>所属组织</th>
			                   <td>
			                   		<input type="hidden"  id="orgId" name="orgId" value="${requestScope.org.id }"/>
				                	<input readOnly="readOnly" type="text" id="orgName" value="${requestScope.org.namePath}"name="orgName"/>
				                	<button type="button" class="browser" style="cursor:pointer" onclick="popWin('<%=basePath %>org/selectList.do','orgId','orgName')">
				                	</button>
				                	<a onclick="clearValue('orgId','orgName');" href="javascript:void(0);">清除</a>
			                   </td>
			               </tr>
			               <tr>
			                   <th>上级岗位</th>
			                   <td>
			                  	<input type="hidden"  id="pid" name="pid" value="${(empty requestScope.station) ? '':requestScope.parent.id }"/>
			                	<input readOnly="readOnly" type="text" id="pidName" name="pidName" value="${(empty requestScope.station) ? '':requestScope.parent.objname }"/>
			                	<button type="button" class="browser" style="cursor:pointer" onclick="popWin('<%=basePath %>station/treeSelect.do','pid','pidName')">
			                	</button>
			                	<a onclick="clearValue('pid','pidName');" href="javascript:void(0);">清除</a>
			                   </td>
			               </tr>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${(empty requestScope.station) ? '':requestScope.station.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
      </div>
  </body>
</html>