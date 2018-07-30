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
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-popWin.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-browse_select.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-dataService.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
	<script type="text/javascript">
		$(function(){
			$(".tabList").naviTableList();
			$("#checkAll").click(function(){
				var checked=$(this).attr("checked");
				$("input[type='checkbox'][name='chkList']").each(function(){
					if(checked){
						$(this).attr("checked",true);
						$(this).next("input[name='isSearch']").val("1");
					}else{
						$(this).attr("checked",false);
						$(this).next("input[name='isSearch']").val("0");
					}
				});
			});
			$("input[type='checkbox'][name='chkList']").each(function(){
				var ck=$(this);
				ck.click(function(){
					if(ck.attr("checked")){
						ck.next("input[name='isSearch']").val("1");
					}else{
						ck.next("input[name='isSearch']").val("0");
					}
				});
			});
		});
		
		function formSearch(){
			$("#objname").val($("#objnameTemp").val());
			$("#colName").val($("#colNameTemp").val());
			$("#NaviForm").submit();
		}
		function formSubmit(){
			$("#NaviEditForm").submit();
		}
		function changeSelect(id){
			var val=$("tr[id='"+id+"'] select[name='searchFieldType']").val();
			var url="selectitem/selectList.do";
			var flag=false;
			if(val=="select"){
				flag=true;
			}else if(val=="browser_select"){
				flag=true;
				url="refobj/selectList.do";
			}
			var html="<input type=\"hidden\"  id=\""+id+"_searchBrowserValue\" name=\"searchBrowserValue\" value=\"\"/>";
           	html+="<input readOnly=\"readOnly\" type=\"text\" onclick=\"popWin('<%=basePath %>"+url+"','"+id+"_searchBrowserValue','"+id+"_searchBrowserValueName')\" dataKey=\""+id+"_searchBrowserValueName\" id=\""+id+"_searchBrowserValueName\" value=\"\"name=\"searchBrowserValueName\"/>";
           	html+="<button type=\"button\" class=\"browser\" onclick=\"popWin('<%=basePath %>"+url+"','"+id+"_searchBrowserValue','"+id+"_searchBrowserValueName')\"></button>";
           	html+="<a onclick=\"clearValue('"+id+"_searchBrowserValue','"+id+"_searchBrowserValueName');\" href=\"javascript:void(0);\">清除</a>";
           	if(flag){
           		$("tr[id='"+id+"'] td.browserVal").html(html);
           	}
		}
		
	</script>
  </head>
 <body>
<div id="wraper">
	<div class="nav">
  			系统设置> 搜索设置 >
  		</div>
  		<div class="toolbar" >
  			<button class="btn" onclick="formSubmit();">保存(S)</button>
  			<button class="btn" onclick="formSearch();">搜索(S)</button>
  			<button class="btn" onclick="location.href='<%=basePath%>reportTable/detail.do?id=${requestScope.reportColumn.reportTable.id}'">返回(B)</button>
  		</div>
  		<div class="searchbar">
  			<table>
  				<tr>
  					<th>字段描述</th>
  					<td><input type="text" name="objnameTemp" id="objnameTemp" value="${requestScope.reportColumn.objname}"/></td>
  					<th>字段名称</th>
  					<td>
  					<input type="text" name="colNameTemp" id="colNameTemp" value="${requestScope.reportColumn.colName}"/>
  					</td>
  				</tr>
  			</table>
  		</div>
  		<div>
  			<form id="NaviEditForm" name="NaviEditForm" action="<%=basePath %>reportColumn/batchEdit.do" method="post">
  			 <input type="hidden" name="reportTableId" value="${requestScope.reportColumn.reportTable.id}"/>
  			 <input type="hidden" name="type" value="searchColumn"/>
  			<table class="tabList">
  				<colgroup>
  					<col width="5%">
  					<col width="12%">
  					<col width="10%">
  					<col width="20%">
  					<col width="10%">
  					<col width="">
  				</colgroup>
  				<tr>
  					<th><input type="checkbox" value="1" id="checkAll"/>搜索</th>
  					<th>显示名称</th>
  					<th>字段名称</th>
  					<th>展示类型</th>
  					<th>搜索顺序</th>
  					<th>Browser值</th>
  				</tr>
  				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
  				<tr id="${s.id }">
  					<td>
	  					<input type="checkbox"  <c:if test="${s.isSearch==1 }">checked="checked"</c:if> name="chkList"/>
	  					<input type="hidden" name="isSearch" value="${s.isSearch }"/>
  					</td>
  					<td>
  					<input type="hidden" name="id" value="${s.id }"/>
  					${s.objname }
  					</td>
  					<td>${s.colName }</td>
  					<td>
  						<select id="${s.id }_searchFieldType" name="searchFieldType" onchange="changeSelect('${s.id }')">
  							<option value="common" ${(s.searchFieldType=="common")?"selected":"" }>普通文本框</option>
  							<option value="date" ${(s.searchFieldType=="date")?"selected":"" }>日期控件</option>
  							<option value="select" ${(s.searchFieldType=="select")?"selected":"" }>选择项</option>
  							<option value="browser_select" ${(s.searchFieldType=="browser_select")?"selected":"" }>弹出窗选择</option>
  						</select>
  					</td>
  					<td>
  					<input type="text"  size="8"name="searchPosition" value="${s.searchPosition }"/>
  					</td>
  					<td class="browserVal">
  						<c:if test="${(s.searchFieldType=='common')||(s.searchFieldType=='date')}">
  						<input type="text" name="searchBrowserValue" id="searchBrowserValue" value="${s.searchBrowserValue }"/>
  						</c:if>
  						<c:if test="${(s.searchFieldType=='select')}">
  						<script type="text/javascript">
						ajaxDataRetrieve('select objname from selectitem where id=\'${s.searchBrowserValue}\'','input','${s.id}_searchBrowserValueName');
						</script>
  						<input type="hidden"  name="searchBrowserValue" value="${s.searchBrowserValue }" id="${s.id}_searchBrowserValue" />
	                	<input readOnly="readOnly" type="text" value="" onclick="popWin('<%=basePath %>selectitem/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')" id="${s.id}_searchBrowserValueName" dataKey="${s.id}_searchBrowserValueName" name="searchBrowserValueName"/>
	                	<button class="browser" type="button" onclick="popWin('<%=basePath %>selectitem/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')">
	                	</button>
	                	<a onclick="clearValue('${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName');" href="javascript:void(0);">清除</a>
  						</c:if>
  						<c:if test="${(s.searchFieldType=='browser_select')}">
						<script type="text/javascript">
						ajaxDataRetrieve('select objname from refobj where id=\'${s.searchBrowserValue}\'','input','${s.id}_searchBrowserValueName');
						</script>
  						<input type="hidden"  name="searchBrowserValue" value="${s.searchBrowserValue }" id="${s.id}_searchBrowserValue" />
	                	<input readOnly="readOnly" type="text" value="" onclick="popWin('<%=basePath %>refobj/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')" id="${s.id}_searchBrowserValueName" dataKey="${s.id}_searchBrowserValueName" name="searchBrowserValueName"/>
	                	<button class="browser" type="button" onclick="popWin('<%=basePath %>refobj/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')">
	                	</button>
	                	<a onclick="clearValue('${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName');" href="javascript:void(0);">清除</a>
  						</c:if>
  					</td>
  				</tr>
  				</c:forEach>
  			</table>
  			</form>
  			<form id="NaviForm" name="NaviForm" action="<%=basePath %>reportColumn/searchSetting.do" method="post">
	  			<input type="hidden" name="objname" value="" id="objname"/>
	  			<input type="hidden" name="colName" value="" id="colName"/>
	  			<input type="hidden" name="reportTableId" value="${requestScope.reportColumn.reportTable.id}"/>
	  			<%@include file="/public/pagination.jsp" %>
	  	  	</form>
  	  </div>
	</div>
</body>
</html>