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
    
    <title>My JSP 'Category_add.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@include file="/public/common.jsp" %>
	<link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-dataService.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/navi/navi-popWin.js"></script>
	<script type="text/javascript">
		function formSubmit(){
			$("#NaviForm").submit();
		}
		function deleteHumres(id){
			$.post("<%=basePath %>/humres/delete.do",{id:id},function(data){
				if(data=="ok"){
					alert("删除成功！");
					location.href="<%=basePath %>/humres/detail.do?type=humres&id=${requestScope.humres.id}";
				}else{
					alert("删除失败");
				}
			});
		}
		$(function(){
			$(".detailTable").naviTableList();
		});
		
		function reloadImage(attachId){
			alert(attachId);
		}
	</script>
	<style type="text/css">
	</style>
  </head>
  <body style="background:#fff;">
  	<div id="wrap">
  		<div class="nav">
  			系统设置 > 人员信息 > ${requestScope.humres.objname}
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="location.href='<%=basePath%>humres/editUI.do?id=${requestScope.humres.id}'">编辑(E)</button>
  			<button class="btn" onclick="deleteHumres('${requestScope.humres.id}')">删除(D)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">人员基本信息</a></li>
  			</ul>
  			<div class="tabContent">
			       	<table class="detailTable">
			           <tbody>
			           	   <tr>
			                   <td class="fieldName">编号</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.objno }</td>
			                   <td rowspan="5" class="fieldName">相片</td>
			                   <td rowspan="5" style="text-align:center">
			                   	<a onclick="popWin('<%=basePath%>attach/imageClippingUI.do?humresId=${requestScope.humres.id}','','')" href="javascript:void(0);">
			                   		<img width="110px" height="120px" src="<%=basePath %>attach/showPicture.do?id=${requestScope.humres.image}"/>
			                   	</a>
			                   </td>
			               </tr>
			               <tr>
			                   <td class="fieldName">姓名</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.objname }</td>
			               </tr>
			               <tr>
			                   <td class="fieldName">所属岗位</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.station.objname }</td>
			               </tr>
			               <tr>
			                   <td class="fieldName">所属部门</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.org.namePath }</td>
			               </tr>
			               <tr>
			                   <td class="fieldName">电话</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.tel }</td>
			               </tr>
			               <tr>
			                   <td class="fieldName">办公电话</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.workTel }</td>
			                   <td class="fieldName">性别</td>
			                   <td>
				                   <span dataKey="${(empty requestScope.humres) ? '':requestScope.humres.gender }">
					                   <script type="text/javascript">
					                   	ajaxDataRetrieve('select objname from selectitem where id=\'${requestScope.humres.gender}\'','span','${requestScope.humres.gender}');
					                   </script>
				                   </span>
			                   </td>
			               </tr>
			               <tr>
			                   <td class="fieldName">其他电话</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.otherTel }</td>
			                   <td class="fieldName">民族</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.race }</td>
			               </tr>
			               <tr>
			                   <td class="fieldName">电子邮件</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.email }</td>
			                   <td class="fieldName">籍贯</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.birthPlace }</td>
			               </tr>
			                <tr>
			                   <td class="fieldName">RTX账号</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.rtxNo }</td>
			                   <td class="fieldName">婚姻状况</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.maritalStatus }</td>
			               </tr>
			               <tr>
			                   <td class="fieldName">工作地点</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.maritalStatus }</td>
			                   <td class="fieldName">学历水平</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.degree }</td>
			               </tr>
			               <tr>
			                   <td class="fieldName">办公室</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.officeAddr }</td>
			                   <td class="fieldName">出生日期</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.birthday }</td>
			               </tr>
			                <tr>
			                   <td class="fieldName">职务</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.duty }</td>
			                   <td class="fieldName">身份证号码</td>
			                   <td>${(empty requestScope.humres) ? '':requestScope.humres.idNo }</td>
			               </tr>
			           </tbody>
			      	</table>
	      </div>
      	</div>
      </div>
  </body>
</html>
