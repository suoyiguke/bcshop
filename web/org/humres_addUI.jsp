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
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-popWin.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-treeDelete.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-dataService.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/datepicker/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
		function formSubmit(){
			var naviForm=$("#NaviForm");
			var url=naviForm.attr("action");
			var pid="${requestScope.station.id}";
			$.post(url,naviForm.serialize(),function(data){
				if(data.isOk==1){
					sysAlert("添加成功！");
					var node={id:data.id,text:data.msg,iconCls:"icon-user",type:"humres"};
					window.parent.addNode(pid,node);
				}
			},"json");
		}
		$(function(){
			$(".detailTable").naviTableList();
			$(".del").treeDelete({url:"<%=basePath %>humres/delete.do"});
		});
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
  			<button class="btn" type="button" onclick="formSubmit()">提交(S)</button>
  			<c:if test="${!empty(requestScope.humres) }">
  			<button class="btn del" id="${requestScope.humres.id }" type="button">删除(D)</button>
  			</c:if>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">人员基本信息</a></li>
  			</ul>
  			<div class="tabContent">
  			<form id="NaviForm" name="NaviForm" action="<%=basePath %>humres/${(empty requestScope.humres) ?"add":"edit" }.do" method="post">
			       	<table class="detailTable">
			           <tbody>
			           	   <tr>
			                   <td class="fieldName">编号</td>
			                   <td>
			                   <input type="hidden"  name="id" value="${(empty requestScope.humres) ? '':requestScope.humres.id }"/>
			                   <input type="text" id="objno" name="objno" value="${(empty requestScope.humres) ? '':requestScope.humres.objno }"/>
			                   </td>
			                   <td rowspan="5" class="fieldName">相片</td>
			                   <td rowspan="5" style="text-align:center">
			                  	<a onclick="popWin('<%=basePath%>attach/imageClippingUI.do?humresId=${requestScope.humres.id}','','')" href="javascript:void(0);">
			                   		<img width="90px" height="120px" src=""/>
			                   	</a>
			                   </td>
			               </tr>
			               <tr>
			                   <td class="fieldName">姓名</td>
			                   <td>
			                   	<input type="text" id="objname" name="objname" value="${(empty requestScope.humres) ? '':requestScope.humres.objname }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <td class="fieldName">所属岗位</td>
			                   <td>
			                   	<input type="hidden"  id="stationId" name="stationId" value="${requestScope.station.id}"/>
			                	<input readOnly="readOnly" type="text" id="stationName" name="stationName" value="${ requestScope.station.objname }"/>
			                	<button type="button" class="browser" style="cursor:pointer" onclick="popWin('<%=basePath %>station/treeSelect.do','station','stationName')">
			                	</button>
			                	<a onclick="clearValue('station','stationName');" href="javascript:void(0);">清除</a>
			                   </td>
			               </tr>
			               <tr>
			                   <td class="fieldName">电话</td>
			                   <td><input type="text" id="tel" name="tel" value="${(empty requestScope.humres) ? '':requestScope.humres.tel }"/></td>
			               </tr>
			               <tr>
			                   <td class="fieldName">办公电话</td>
			                   <td><input type="text" id="workTel" name="workTel" value="${(empty requestScope.humres) ? '':requestScope.humres.workTel }"/></td>
			               </tr>
			               <tr>
			                   <td class="fieldName">其他电话</td>
			                   <td><input type="text" id="otherTel" name="otherTel" value="${(empty requestScope.humres) ? '':requestScope.humres.otherTel }"/></td>
			                     <td class="fieldName">性别</td>
			                   <td>
				                   	<input type="hidden"  id="gender" name="gender" value="${(empty requestScope.humres) ? '':requestScope.humres.gender }"/>
				                	<input readOnly="readOnly" type="text" id="gender_name" value="" dataKey="gender_name" name="gender_name"/>
				                	<script type="text/javascript">
					                   	ajaxDataRetrieve('select objname from selectitem where id=\'${requestScope.humres.gender }\'','input','gender_name');
					                </script>
				                	<button type="button" class="browser" style="cursor:pointer" onclick="popWin('<%=basePath %>selectitem/selectList.do?type=gender','gender','gender_name')">
				                	</button>
			                   </td>
			               </tr>
			               <tr>
			                   <td class="fieldName">电子邮件</td>
			                   <td><input type="text" id="email" name="email" value="${(empty requestScope.humres) ? '':requestScope.humres.email }"/></td>
			                   <td class="fieldName">民族</td>
			                   <td><input type="text" id="race" name="race" value="${(empty requestScope.humres) ? '':requestScope.humres.race }"/></td>
			               </tr>
			                <tr>
			                   <td class="fieldName">RTX账号</td>
			                   <td><input type="text" id="rtxNo" name="rtxNo" value="${(empty requestScope.humres) ? '':requestScope.humres.rtxNo }"/></td>
			                   <td class="fieldName">籍贯</td>
			                   <td><input type="text" id="birthPlace" name="birthPlace" value="${(empty requestScope.humres) ? '':requestScope.humres.birthPlace }"/></td>
			               </tr>
			               <tr>
			                   <td class="fieldName">工作地点</td>
			                   <td><input type="text" id="workAddr" name="workAddr" value="${(empty requestScope.humres) ? '':requestScope.humres.workAddr }"/></td>
			                   <td class="fieldName">婚姻状况</td>
			                   <td><input type="text" id="maritalStatus" name="maritalStatus" value="${(empty requestScope.humres) ? '':requestScope.humres.maritalStatus }"/></td>
			               </tr>
			               <tr>
			                   <td class="fieldName">办公室</td>
			                   <td><input type="text" id="officeAddr" name="officeAddr" value="${(empty requestScope.humres) ? '':requestScope.humres.officeAddr }"/></td>
			                   <td class="fieldName">学历水平</td>
			                   <td><input type="text" id="degree" name="degree" value="${(empty requestScope.humres) ? '':requestScope.humres.degree }"/></td>
			               </tr>
			                <tr>
			                   <td class="fieldName">职务</td>
			                   <td><input type="text" id="duty" name="duty" value="${(empty requestScope.humres) ? '':requestScope.humres.duty }"/></td>
			                   <td class="fieldName">出生日期</td>
			                   <td><input class="Wdate" onclick="WdatePicker({isShowWeek:true})"type="text" id="birthday" name="birthday" value="${(empty requestScope.humres) ? '':requestScope.humres.birthday }"/></td>
			               </tr>
			               <tr>
			               	   <td class="fieldName">身份证号码</td>
			                   <td colspan="3"><input type="text" id="idNo" name="idNo" value="${(empty requestScope.humres) ? '':requestScope.humres.idNo }"/></td>
			               </tr>
			           </tbody>
			      	</table>
			      </form>
	      </div>
      	</div>
      </div>
  </body>
</html>
