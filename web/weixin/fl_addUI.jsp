<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
    
    <%@include file="/public/common.jsp" %>
	<script type="text/javascript" src="/js/navi/navi-addOrEdit.js"></script>
	<script type="text/javascript" src="/js/navi/navi-upload.js"></script>

	<script type="text/javascript">

   var  closePanel= function () {
       parent.location.reload();//完成刷新
    }
	</script>
  </head>
 <body>
	<div id="wrap">
		<div class="nav">
  			微信小程序管理> 商品分类${(empty requestScope.category)?"添加":"修改"}>
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="addOrEdit();">提交(S)</button>
  			<button class="btn" onclick="closePanel()">退出并刷新数据(C)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">商品分类${(empty category)?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviAddForm" name="NaviAddForm" action="/weixinmanager/${(empty category) ?"addItemFl":"editItemFl" }.do" method="post">
			       	<table>
			           <tbody class="addTable">
			               <tr>
			                   <th>分类名称</th>
			                   <td>
            			       <input type="hidden" class="text" name="id" value="${category.id }"/>
			                   <input type="text" class="text" name="objname" value="${category.objname }"/>
			                   </td>
			               </tr>
			               <tr>
			                   <th>分类说明</th>
			                   <td>
			                   	<textarea class="text" name="objdesc">${category.objdesc }</textarea>
			                   </td>
			               </tr>
			               <tr>
			               <th>上传分类图片</th>
			               <td>
			               		<input type="hidden" value="${category.img }" id="img" name="img">
			               		<div id="imgUploadFrame" class="<c:if test="${!empty(category.img) }">hide</c:if>">
			               		<iframe  src="/public/fileUpload.jsp?listenerId=img&type=img&limitNum=1" style="height:22px;" width="100%"></iframe>
			               		</div>
			               		<div id="img_upload_div" class="upload_div">
			               		<c:if test="${!empty(category.img) }">
			               			<p id='${category.img }'>
			               				<img width="25px" height="25px" src="/attach/showPicture.do?id=${category.img }" />
			               				<a href='javascript:deleteAttach("${category.img }","img",this)' class='delete'></a>
			               			</p>
			               		</c:if>
			               		</div>
			               </td>
			               </tr>
  						    <tr>
  						   		<th>是否发布</th>
  						   		<td>
  						   			<input type="radio" name="isActive" value="1" <c:if test="${empty(category)||category.isActive==1 }"> checked="checked" </c:if>  />是
  						   			<input type="radio" name="isActive" value="0" <c:if test="${category.isActive==0 }"> checked="checked" </c:if>  />否
  						   		</td>
  						   </tr>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${category.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
	</div>
</body>
</html>