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
	<style type="text/css">
	</style>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-upload.js"></script>
	 <!-- kindeditor -->
    <link rel="stylesheet" href="<%=basePath%>js/kindeditor4.1.10/themes/default/default.css" />
	<link rel="stylesheet" href="<%=basePath%>js/kindeditor4.1.10/plugins/code/prettify.css" />
	<script src="<%=basePath%>js/kindeditor4.1.10/kindeditor-min.js"></script>
	<script src="<%=basePath%>js/kindeditor4.1.10/addRichEditor.js"></script>
	<script src="<%=basePath%>js/kindeditor4.1.10/lang/zh_CN.js"></script>
	<script src="<%=basePath%>js/kindeditor4.1.10/plugins/code/prettify.js"></script>
	
	<script type="text/javascript" src="<%=basePath %>js/datepicker/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
		$(function(){
			$(".rich_editor").each(function(){
	    		var id=$(this).attr("id");
	    		addRichEditor("<%=basePath %>",id);
	    	});
		});
	</script>
  </head>
 <body>
	<div id="wrap">
		<div class="nav">
  			系统设置> 新闻${(empty requestScope.news)?"添加":"修改"}>
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="addOrEdit();">提交(S)</button>
  			<button class="btn" onclick="closePanel()">取消(C)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">新闻${(empty requestScope.news)?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviAddForm" name="NaviAddForm" action="<%=basePath %>website/news/${(empty requestScope.news) ?"add":"edit" }.do" method="post">
			       	<table>
			           <tbody class="addTable">
			               <tr>
			                   <th>新闻名称</th>
			                   <td>
            			       <input type="hidden" class="text" name="id" value="${requestScope.news.id }"/>
			                   <input type="text" class="text" name="objname" value="${requestScope.news.objname }"/>
			                   </td>
			               </tr>
			                <tr>
			                   <th>发布日期</th>
			                   <td>
			                   <input readonly="readonly" class="Wdate "  name="publishdate" type="text" onclick="WdatePicker({isShowWeek:true})" value="${requestScope.news.publishdate }">
			                   </td>
			               </tr>
			               <tr>
			                   <th>新闻摘要</th>
			                   <td>
			                   	<textarea class="text" name="objdesc">${requestScope.news.objdesc }</textarea>
			                   </td>
			               </tr>
			               <th>新闻封面</th>
			               <td>
			               		<input type="hidden" value="${news.img }" id="img" name="img">
			               		<div id="imgUploadFrame" <c:if test="${!empty(news.img) }">style='display:none;'</c:if>>
			               		<iframe  src="<%=basePath %>public/fileUpload.jsp?listenerId=img&type=img&limitNum=1" style="height:22px;" width="100%"></iframe>
			               		</div>
			               		<div id="img_upload_div" class="upload_div">
			               		<c:if test="${!empty(news.img) }">
			               			<p id='${news.img }_delete'>
			               				<img width="25px" height="25px" src="<%=basePath %>attach/showPicture.do?id=${news.img }" />
			               				<a href='javascript:deleteAttach("${news.img }","img",this)' class='delete'></a>
			               			</p>
			               		</c:if>
			               		</div>
			               </td>
			               <tr>
				               	<th>分类</th>
		  						<td>
		  						<select name="typeId" id="typeId">
		  							<option value="">==请选择分类==</option>
		  							<c:forEach items="${requestScope.typeList }" var="s">
		  								<option <c:if test="${s.id==requestScope.news.typeId }">selected="selected"</c:if> value="${s.id }">${s.objname }</option>
		  							</c:forEach>
		  						</select>
	  							</td>
  						   </tr>
  						   <tr>
  						   		<th>是否发布</th>
  						   		<td>
  						   			<input type="radio" name="isActive" value="1" <c:if test="${empty(news)||news.isActive==1 }"> checked="checked" </c:if>  />是
  						   			<input type="radio" name="isActive" value="0" <c:if test="${news.isActive==0 }"> checked="checked" </c:if>  />否
  						   		</td>
  						   </tr>
  						   <tr>
			                   <th>新闻描述</th>
			                   <td>
			                   		<textarea class="text rich_editor" id="content" name="content">${requestScope.news.content }</textarea>
			                   </td>
			               </tr>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${requestScope.news.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
	</div>
</body>
</html>