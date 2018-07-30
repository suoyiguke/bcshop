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
    <%@include file="/public/common.jsp" %>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/layer/layer.js"></script>
    <link  rel="stylesheet" href="<%=basePath %>js/layer/skin/layer.css" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-layer.js"></script>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- Bootstrap framework -->
	<script type="text/javascript">
	$(function(){
		$("#fieldType").change(function(){
				var sel=$(this);
				var selText=sel.find("option:selected").val();
				$("#fieldRegexTr").hide();
				$("#lengthTr").hide();
				$("#selectValueTr").hide();
				$("#refValueTr").hide();
				if("text_simple"==selText){
					$("#lengthTr").show();
					$("#lengthTr th").html("字段长度");
					$("#fieldRegexTr").show();
				}
				if("double"==selText){
					$("#lengthTr").show();
					$("#lengthTr th").html("小数点位数");
				}
				if("selectitem"==selText||"selectitem_multi"==selText){
					$("#selectValueTr").show();
				}
				if("refobj"==selText||"refobj_multi"==selText){
					$("#refValueTr").show();
				}
		});
		$(".getFieldNameById").naviGetFieldNameById({idKey:"dataKey"});
		$(".popWin").naviLayer();
	});
		
	</script>
  </head>
  <body style="background:#fff;">
  	<div id="wrap">
  		<div class="nav">
  			系统设置> 字段${(empty requestScope.field) ?"添加":"修改"}
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="addOrEdit();">提交(S)</button>
  			<button class="btn" onclick="closePanel()">取消(C)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">字段${(empty requestScope.field) ?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviAddForm" name="NaviAddForm" action="<%=basePath %>field/${(empty requestScope.field) ?"add":"edit" }.do" method="post">
			       	<table class="addTable">
			           <tbody>
			           		<tr>
			                   <th>字段描述</th>
			                   <td>
			                   <input type="text" class="text" name="objname" value="${requestScope.field.objname }"/>
			                   <input type="hidden" class="text" name="id" value="${requestScope.field.id }"/>
			                   <input type="hidden" name="formId" value="${empty(requestScope.field)?formId:requestScope.field.formId }">
			                   </td>
			               </tr>
			               <tr>
			                   <th>数据库字段名</th>
			                   <td>
			                   <input type="text" class="text" name="colName"  ${(empty requestScope.field) ? '':'readonly' } value="${requestScope.field.colName }"/>
			                   </td>
			               </tr>
			                <tr>
			                   <th>字段类型</th>
			                   <td>
			                   	<select name="fieldType" id="fieldType" ${(empty requestScope.field) ? '':'disabled' }>
			                   		<option <c:if test="${(requestScope.field.fieldType)=='text_simple' }">selected</c:if> value="text_simple">单行文本</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='int' }">selected</c:if> value="int">整数</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='double' }">selected</c:if> value="double">浮点</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='date' }">selected</c:if> value="date">日期</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='textarea' }">selected</c:if> value="textarea">多行文本</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='selectitem' }">selected</c:if> value="selectitem">选择项</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='selectitem_multi' }">selected</c:if> value="selectitem_multi">选择项多选</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='refobj' }">selected</c:if> value="refobj">关联对象</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='refobj_multi' }">selected</c:if> value="refobj_multi">关联对象多选</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='file' }">selected</c:if> value="file">附件</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='picture' }">selected</c:if> value="picture">图片</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='datetime' }">selected</c:if> value="datetime">日期时间</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='time' }">selected</c:if> value="time">时间</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='rich_text' }">selected</c:if> value="rich_text">富文本</option>
		  							<option <c:if test="${(requestScope.field.fieldType)=='checkbox' }">selected</c:if> value="checkbox">CheckBox</option>
		  						</select>
			                   </td>
			               </tr>
			               <tr>
				               	<th>分类</th>
		  						<td>
		  						<select name="typeId" id="typeId">
		  							<option value="">==请选择分类==</option>
		  							<c:forEach items="${requestScope.typeList }" var="s">
		  								<option value="${s.id }" <c:if test="${s.id==requestScope.field.typeId }">selected="selected"</c:if>>${s.objname }</option>
		  							</c:forEach>
		  						</select>
	  							</td>
  						  </tr>
  						  <tr id="selectValueTr" style="<c:if test="${(requestScope.field.fieldType)!='selectitem' }">display:none</c:if>">
  								<th>选择项</th>
  								<td>
  								<input type="hidden"  id="selectValue" name="selectValue" value="${requestScope.field.attrValue }"/>
			                	<input readOnly="readOnly" type="text" idspan="selectValue"  namespan="selectName" url="<%=basePath %>selectitem/selectList.do"  class="getFieldNameById popWin" tableName="selectitem" fieldName="objname" dataKey="${requestScope.field.attrValue }"  id="selectName" name="selectName"/>
			                	<button type="button" idspan="selectValue"  namespan="selectName" url="<%=basePath %>selectitem/selectList.do" class="browser popWin">
			                	</button>
			                	<a onclick="clearValue('selectValue','selectName');" href="javascript:void(0);">清除</a>
  								</td>
  							</tr>
  							<tr id="refValueTr" style="<c:if test="${(requestScope.field.fieldType)!='refobj' }">display:none</c:if>">
  								<th>关联对象</th>
  								<td>
  								<input type="hidden"  name="refValue" value="${requestScope.field.attrValue }" id="refValue" />
			                	<input readOnly="readOnly" class="getFieldNameById popWin" tableName="refobj" fieldName="objname" dataKey="${requestScope.field.attrValue }"  idspan="refValue"  namespan="refName" url="<%=basePath %>refobj/selectList.do" type="text" id="refName" name="refName"/>
			                	<button class="browser popWin" idspan="refValue"  namespan="refName" url="<%=basePath %>refobj/selectList.do" type="button">
			                	</button>
			                	<a onclick="clearValue('refValue','refName');" href="javascript:void(0);">清除</a>
  								</td>
  							</tr>
  							<c:if test="${(empty requestScope.field)||requestScope.field.fieldType=='text_simple'||requestScope.field.fieldType=='double' }">
  							<tr id="lengthTr">
  								<th>
  									<c:choose >
  										<c:when test="${(requestScope.field.fieldType)=='double' }">小数点位数</c:when>
  										<c:otherwise>字段长度</c:otherwise>
  									</c:choose>
  								</th>
  								<td><input type="text" class="text" value="${requestScope.field.len }" name="len"/></td>
  							</tr>
  							</c:if>
  							<c:if test="${(empty requestScope.field)||(requestScope.field.fieldType=='text_simple')}">
  							<tr id="fieldRegexTr">
			                   <th>字段验证</th>
			                   <td>
			                   		<select name="regex">
			                   			<option value="">==请选择==</option>
			                   			<option value="isInt">整数</option>
			                   			<option value="number">数字</option>
			                   			<option value="isTel">联系方式</option>
			                   			<option value="email">邮件</option>
			                   			<option value="isPhone">固话</option>
			                   			<option value="isMobile">手机</option>
			                   			<option value="isQq">qq</option>
			                   			<option value="isZipCode">邮政编码</option>
			                   			<option value="isPwd">密码</option>
			                   			<option value="isIdCardNo">身份证</option>
			                   			<option value="ip">IP地址</option>
			                   		</select>
			                   </td>
			               </tr>
			               </c:if>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${requestScope.field.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
      </div>
  </body>
</html>
