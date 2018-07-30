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
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-checkBox.js"></script>
	<script type="text/javascript">
		//checkbox
		$("input[name='chkList']").naviCheckBox();
	</script>
  </head>
 <body>
	<div id="wrap">
		<div class="nav">
  			系统设置> 报表字段${(empty requestScope.reportColumn)?"添加":"修改"}>
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="addOrEdit();">提交(S)</button>
  			<button class="btn" onclick="closePanel()">取消(C)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">报表字段${(empty requestScope.reportColumn)?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviAddForm" name="NaviAddForm" action="<%=basePath %>reportColumn/${(empty requestScope.reportColumn) ?"add":"edit" }.do" method="post">
			       	<table class="addTable">
			           <tbody >
			               <tr>
			                   <th>字段显示名称</th>
			                   <td>
			                   <input type="text" class="text" name="objname" value="${(empty requestScope.reportColumn) ? '':requestScope.reportColumn.objname }"/>
			                   </td>
			                   <th>字段名称</th>
			                   <td>
			                   <input type="hidden" name="reportTableId" value="${(empty requestScope.reportTableId) ? '':requestScope.reportTableId }"/>
			                   <input type="hidden" name="id" value="${(empty requestScope.reportColumn) ? '':requestScope.reportColumn.id }"/>
			                   <input type="text" class="text" name="colName" ${(empty requestScope.reportColumn) ? '':'readonly' } value="${(empty requestScope.reportColumn) ? '':requestScope.reportColumn.colName }"/>
			                   </td>
			               </tr>
			                <tr>
			                   <th>关联表</th>
			                   <td>
			                   <input type="text" class="text" name="refTable" value="${(empty requestScope.reportColumn) ? '':requestScope.reportColumn.refTable }"/>
			                   </td>
			                   <th>关联表显示名称</th>
			                   <td>
			                   <input type="text" class="text" name="refTableCol" value="${(empty requestScope.reportColumn) ? '':requestScope.reportColumn.refTableCol }"/>
			                   </td>
			               </tr>
			                <tr>
			                   <th>显示顺序</th>
			                   <td>
			                   <input type="text" class="text" name="position" value="${requestScope.reportColumn.position }"/>
			                   </td>
			                    <th>显示列宽</th>
			                   <td><input type="text" class="text" name="widthPercent" value="${requestScope.reportColumn.widthPercent }"/></td>
			               </tr>
			               <tr>
			                   <th>是否汇总</th>
			                   <td>
		                   		<input type="checkbox" <c:if test="${requestScope.reportColumn.isCount==1 }">checked="checked"</c:if> name="chkList"/>
			                   	<input type="hidden" name="isCount" value="${requestScope.reportColumn.isCount }"/>
			                   </td>
			                   <th>是否排序</th>
			                   <td>
			                   <input type="checkbox" <c:if test="${requestScope.reportColumn.isSort==1 }">checked="checked"</c:if> name="chkList"/>
			                   <input type="hidden" name="isSort" value="${requestScope.reportColumn.isSort }"/>
			                   </td>
			               </tr>
			               <tr>
			               	   <th>是否显示</th>
			                   <td>
			                   <input type="checkbox" <c:if test="${requestScope.reportColumn.isShow==1 }">checked="checked"</c:if> name="chkList"/>
			                   <input type="hidden" name="isShow" value="${requestScope.reportColumn.isShow }"/>
			                   </td>
			                   <th>链接地址</th>
			                   <td><input type="text" class="text" name="url" value="${(empty requestScope.reportColumn) ? '':requestScope.reportColumn.url }"/></td>
			               </tr>
			               <tr>
			               	   <th>是否搜索</th>
			                   <td>
		                   		<input type="checkbox" <c:if test="${requestScope.reportColumn.isSearch==1 }">checked="checked"</c:if> name="chkList"/>
			                   	<input type="hidden" name="isSearch" value="${requestScope.reportColumn.isSearch }"/>
			                   </td>
			                   <th>展示类型</th>
			                   <td>
			  						<select name="searchFieldType" onchange="changeSelect('${s.id }')">
			  							<option value="text" ${(s.searchFieldType=="text")?"selected":"" }>文本框</option>
			  							<option value="date" ${(s.searchFieldType=="date")?"selected":"" }>日期控件</option>
			  							<option value="selectitem" ${(s.searchFieldType=="selectitem")?"selected":"" }>选择项</option>
			  							<option value="refobj" ${(s.searchFieldType=="refobj")?"selected":"" }>关联选择</option>
			  						</select>
			  					</td>
			               </tr>
			               <tr>
			               	   <th>搜索顺序</th>
			                   <td>
			                   	<input type="text" name="position" value="${requestScope.reportColumn.position }"/>
			                   </td>
			                   <th>搜索项值</th>
			                   <td>
			                   	<c:choose>
		  							<c:when test="${(s.searchFieldType=='select')}">
		  								<input type="hidden"  name="searchBrowserValue" value="${s.searchBrowserValue }" id="${s.id}_searchBrowserValue" />
					                	<input readOnly="readOnly" type="text" value="" onclick="popWin('<%=basePath %>selectitem/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')" id="${s.id}_searchBrowserValueName" dataKey="${s.id}_searchBrowserValueName" name="searchBrowserValueName"/>
					                	<button class="browser" type="button" onclick="popWin('<%=basePath %>selectitem/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')">
					                	</button>
					                	<a onclick="clearValue('${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName');" href="javascript:void(0);">清除</a>
		  							</c:when>
		  							<c:when test="${(s.searchFieldType=='browser_select')}">
		  								<input type="hidden"  name="searchBrowserValue" value="${s.searchBrowserValue }" id="${s.id}_searchBrowserValue" />
					                	<input readOnly="readOnly" type="text" value="" onclick="popWin('<%=basePath %>refobj/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')" id="${s.id}_searchBrowserValueName" dataKey="${s.id}_searchBrowserValueName" name="searchBrowserValueName"/>
					                	<button class="browser" type="button" onclick="popWin('<%=basePath %>refobj/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')">
					                	</button>
					                	<a onclick="clearValue('${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName');" href="javascript:void(0);">清除</a>
		  							</c:when>
		  							<c:otherwise>
		  								<input type="text" name="searchBrowserValue" id="searchBrowserValue" value="${s.searchBrowserValue }"/>
		  							</c:otherwise>
		  						</c:choose>
			  				   </td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
	</div>
</body>
</html>