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
    <base href="<%=basePath%>">
    <title></title>
    <%@include file="/public/common.jsp" %>
    <link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-tableList.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-checkAll.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-checkBox.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-batchDelete.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-delete.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/layer/layer.js"></script>
    <link  rel="stylesheet" href="<%=basePath %>js/layer/skin/layer.css" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-layer.js"></script>
	<script type="text/javascript">
		$(function(){
			$(".tabList").naviTableList();
			$(".chkAll").naviCheckAll({
				afterClick:function(chkAll,chkList){
					var val=chkAll.prop("checked")?'1':'0';
					chkList.each(function(){
						$(this).next().val(val);
					});
				}
			});
			//批量删除
			$("#delBtn").naviBatchDelete({url:"<%=basePath %>reportColumn/delete.do"});
			//单个删除
			$(".fam-cross").naviDelete({url:"<%=basePath %>reportColumn/delete.do"});
			//批量保存
			$("#batchSaveBtn").click(function(){
				var f=$("#NaviBatchEditForm");
				var url=f.attr("action");
				$.post(url,f.serialize(),function(data){
					sysAlert(data.msg);
					if(data.isOk==1){
						location.reload();
					}
				},"json");
			});
			//搜索
			$("#searchBtn").click(function(){
				$("#NaviForm input[name='objname']").val($("#objnameTemp").val());
				$("#NaviForm input[name='colName']").val($("#colNameTemp").val());
				$("#NaviForm").submit();
			});
			//提交
			$("#editBtn").click(function(){
				var naviForm=$("#NaviEditForm");
				var url=naviForm.attr("action");
				$.post(url,naviForm.serialize(),function(data){
					alert(data.msg);
					if(data.success=="ok"){
						location.reload();
					}
				},"json");
			});
			//checkbox
			$("input[name='chkList']").naviCheckBox();
			
			$(".naviEdit").naviLayer();
			
			$("#generateRefobj").click(function(){
				var id="${requestScope.reportTable.id}";
				$.post("<%=basePath %>refobj/addFromReportTable.do",{reportTableId:id},function(data){
					if("ok"==data){
						alert("生成成功！");
					}else{
						alert("系统发生错误！");
					}
				});
			});
			$("select[name='searchFieldType']").change(function(){
				var id=$(this).attr("id");
				var selVal=$(this).val();
				var html="";
				if("refobj"==selVal||"selectitem"==selVal){
					var url="<%=basePath %>selectitem/selectList.do";
					if("refobj"==selVal){
						url="<%=basePath %>refobj/selectList.do";
					}
					var input1="<input type=\"hidden\"  name=\"searchBrowserValue\" value=\"\" id=\""+id+"_searchBrowserValue\" />";
                	var input2="<input style=\"width:70%;\" readOnly=\"readOnly\" type=\"text\" value=\"\" onclick=\"popWin('"+url+"','"+id+"_searchBrowserValue','"+id+"_searchBrowserValueName')\" id=\""+id+"_searchBrowserValueName\" name=\"searchBrowserValueName\"/>";
                	var btn="<button class=\"browser\" type=\"button\" onclick=\"popWin('"+url+"','"+id+"_searchBrowserValue','"+id+"_searchBrowserValueName')\"></button>";
                	var a="<a onclick=\"clearValue('"+id+"_searchBrowserValue','"+id+"_searchBrowserValueName');\" href=\"javascript:void(0);\">清除</a>";
                	html=input1+input2+btn+a;
				}else{
					html="<input type=\"text\"  value=\"\" name=\"searchBrowserValue\"/>";
				}
				$("td#searchBrowserValue_"+id).html(html);
			});
			
			$(".getFieldNameById").naviGetFieldNameById({idKey:"dataKey"});
		});
		
	</script>
	
	<style type="text/css">
	div.tab .tabContent table{
		margin:3px 0 5px 5px;
	}
	</style>
  </head>
 <body>
 <div id="naviPanel"></div>
<div id="warper">
		<div class="nav">
  			系统设置 > 报表详情 > ${requestScope.reportTable.objname }
  		</div>
  		<div class="toolbar">
  			<button class="btn" id="editBtn">提交(S)</button>
  			<button class="btn" onclick="window.parent.addTab('${requestScope.reportTable.tabName }-报表预览','/reportTable/jqgridView.do?id=${requestScope.reportTable.id}')">预览(V)</button>
  			<button class="btn" id="generateRefobj">生成关联选择项(G)</button>
  			<button class="btn" onclick="location.href='<%=basePath%>reportTable/list.do'">返回(B)</button>
  		</div>
		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">报表${(empty requestScope.reportTable)?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviEditForm" name="NaviEditForm" action="<%=basePath%>reportTable/edit.do" method="post">
			       	<table>
			           <tbody class="addTable">
			           		<tr>
			                   <th>报表名称</th>
			                   <td>
			                   <input type="hidden"  name="id" value="${requestScope.reportTable.id }"/>
			                   <input type="text"  class="text" name="objname" value="${requestScope.reportTable.objname }"/>
			                   </td>
			               </tr>
			               <c:if test="${!(empty requestScope.reportTable.formId)}">
			                <tr>
			                   <th>关联表单</th>
			                   <td>
			                   <input type="hidden" name="formId" id="formId" value="${requestScope.reportTable.formId }"/>
			                   <input type="text" tableName="formInfo" fieldName="objname" dataKey="${requestScope.reportTable.formId }" class="getFieldNameById" readonly="readonly" value=""/>
			                   </td>
			               </tr>
			               </c:if>
			               <tr>
			                   <th>数据库表名</th>
			                   <td>
			                   <input type="text" class="text" name="tabName" <c:if test="${!(empty requestScope.reportTable)}">readonly="readonly"</c:if> value="${requestScope.reportTable.tabName }"/>
			                   </td>
			               </tr>
			               <tr>
				               	<th>分类</th>
		  						<td>
		  						<select name="typeId" id="typeId">
		  							<option value="">==请选择分类==</option>
		  							<c:forEach items="${requestScope.typeList }" var="s">
		  								<option value="${s.id }" <c:if test="${s.id==requestScope.reportTable.typeId }">selected="selected"</c:if>>${s.objname }</option>
		  							</c:forEach>
		  						</select>
	  							</td>
  							</tr>
			               <tr>
			                   <th>顺序</th>
			                   <td><input type="text" class="text" name="position" value="${requestScope.reportTable.position }"/></td>
			               </tr>
			           </tbody>
			      	</table>
		      	</form>
	      </div>
      	</div>
      	
      <div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">报表字段信息</a></li>
  			</ul>
  			<button  class="btn" style="margin-left:10px;" id="batchSaveBtn">保存(S)</button>
  			<button  class="btn naviEdit" w="800" h="350" t="20" style="cursor:pointer" title="报表字段新增"  url="<%=basePath %>reportColumn/addUI.do?reportTableId=${requestScope.reportTable.id}">新增字段</button>
  			<button  class="btn" id="delBtn">批量删除</button>
  			显示名称:<input name="objname" id="objnameTemp" type="text" style="width:120px;" value="${requestScope.reportColumn.objname }">
  			字段名称:<input name="colName" id="colNameTemp" type="text" style="width:120px;" value="${requestScope.reportColumn.colName }">
  			<button style="margin-left:15px;" id="searchBtn" class="btn">搜索</button>
  			<form id="NaviBatchEditForm" name="NaviBatchEditForm" action="<%=basePath %>reportColumn/batchUpdate.do" method="post">
  			<input type="hidden" name="type" value="reportColumn"/>
  			<input type="hidden" name="reportTableId" value="${requestScope.reportTable.id}"/>
  			<table class="tabList">
  				<colgroup>
  					<col width="4%"><!-- 全选 -->
  					<col width="5%"><!-- 显示 -->
  					<col width="5%"><!-- 冻结 -->
  					<col width="8%"><!-- 显示名称 -->
  					<col width="8%"><!-- 字段名称 -->
  					<col width="5%"><!-- 显示顺序 -->
  					<col width="5%"><!-- 排序 -->
  					<col width="3%"><!-- 汇总 -->
  					<col width="5%"><!-- 有连接 -->
  					<col width="5%"><!-- 显示列宽 -->
  					<col width="5%"><!--  搜索 -->
  					<col width="8%"><!-- 展示类型-->
					<col width="5%"><!-- 搜索顺序 -->
					<col width="18%"><!-- 搜索项值 -->
  					<col width="5%"><!-- 操作-->
  				</colgroup>
  				<tr>
  					<th><input type="checkbox" chkListCls="chkList"  class="chkAll"/>全选</th>
  					<th><input type="checkbox" chkListCls="showChkList" class="chkAll"/>显示</th>
  					<th><input type="checkbox" chkListCls="frozenChkList" class="chkAll"/>冻结</th>
  					<th>显示名称</th>
  					<th>字段名称</th>
  					<th>显示顺序</th>
  					<th><input type="checkbox" chkListCls="sortChkList" class="chkAll"/>排序</th>
  					<th>汇总</th>
  					<th>有连接</th>
  					<th>显示列宽</th>
  					<th><input type="checkbox" chkListCls="searchChkList" class="chkAll"/>搜索</th>
  					<th>展示类型</th>
  					<th>搜索顺序</th>
  					<th>搜索项值</th>
  					<th>操作</th>
  				</tr>
  				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
  				<tr id="${s.id }">
  					<td>
	  					<input type="hidden" name="reportTableId" value="${requestScope.reportTable.id}"/>
	  					<input type="checkbox" class="chkList" id="${s.id }" name="chkList"/>
  					</td>
  					<td>
	  					<input type="checkbox"  class="showChkList" <c:if test="${s.isShow==1 }">checked="checked"</c:if> name="chkList"/>
	  					<input type="hidden" name="isShow" value="${s.isShow }"/>
  					</td>
  					<td>
	  					<input type="checkbox"  class="frozenChkList" <c:if test="${s.isFrozen==1 }">checked="checked"</c:if> name="chkList"/>
	  					<input type="hidden" name="isFrozen" value="${s.isFrozen }"/>
  					</td>
  					<td>
  					<input type="hidden" name="id" value="${s.id }"/>
  					<input type="text" style="width:90%;"  name="objname" value="${s.objname }"/>
  					</td>
  					<td>
  						<a class="naviEdit"  w="800" h="350" t="20" style="cursor:pointer" title="报表字段修改"  href="javascript:void(0);" url="<%=basePath %>reportColumn/editUI.do?id=${s.id }">${s.colName }</a>
  						<input type="hidden" name="colName" value="${s.colName }"/>
  					</td>
  					<td>
  						<input type="text" size="8"name="position" value="${s.position }"/>
  					</td>
  					<td>
  						<input type="checkbox" class="sortChkList" <c:if test="${s.isSort==1 }">checked="checked"</c:if> name="chkList"/>
	  					<input type="hidden" name="isSort" value="${s.isSort }"/>
	  				</td>
  					<td>
						<input type="checkbox"  <c:if test="${s.isCount==1 }">checked="checked"</c:if> name="chkList"/>
	  					<input type="hidden" name="isCount" value="${s.isCount }"/>  					
  					</td>
  					<td>${empty(s.url)?'无':'有' }</td>
  					<td>
  						<input type="text" size="8"name="widthPercent" value="${s.widthPercent }"/>
  					</td>
  					<td>
	  					<input type="checkbox"  class="searchChkList" <c:if test="${s.isSearch==1 }">checked="checked"</c:if> name="chkList"/>
	  					<input type="hidden" name="isSearch" value="${s.isSearch }"/>
  					</td>
  					<td>
  						<select style="width:95%" name="searchFieldType" id="${s.id }">
  							<option value="text" ${(s.searchFieldType=="text")?"selected":"" }>文本框</option>
  							<option value="date" ${(s.searchFieldType=="date")?"selected":"" }>日期控件</option>
  							<option value="selectitem" ${(s.searchFieldType=="selectitem")?"selected":"" }>选择项</option>
  							<option value="refobj" ${(s.searchFieldType=="refobj")?"selected":"" }>关联选择</option>
  						</select>
  					</td>
  					<td>
  						<input type="text" size="8"name="searchPosition" value="${s.searchPosition }"/>
  					</td>
  					<td id="searchBrowserValue_${s.id }" >
  						<c:choose>
  							<c:when test="${(s.searchFieldType=='selectitem')}">
  								<input type="hidden"  name="searchBrowserValue" value="${s.searchBrowserValue }" id="${s.id}_searchBrowserValue" />
			                	<input readOnly="readOnly" dataKey="${s.searchBrowserValue }"  style="width:70%" tableName="selectitem" fieldName="objname" class="getFieldNameById" value="" type="text"  onclick="popWin('<%=basePath %>selectitem/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')" id="${s.id}_searchBrowserValueName" />
			                	<button class="browser" type="button" onclick="popWin('<%=basePath %>selectitem/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')">
			                	</button>
			                	<a onclick="clearValue('${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName');" href="javascript:void(0);">清除</a>
  							</c:when>
  							<c:when test="${(s.searchFieldType=='refobj')}">
  								<input type="hidden"  name="searchBrowserValue" value="${s.searchBrowserValue }" id="${s.id}_searchBrowserValue" />
			                	<input readOnly="readOnly" dataKey="${s.searchBrowserValue }" style="width:70%" tableName="refobj" fieldName="objname" class="getFieldNameById" type="text" value="" onclick="popWin('<%=basePath %>refobj/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')" id="${s.id}_searchBrowserValueName" />
			                	<button class="browser" type="button" onclick="popWin('<%=basePath %>refobj/selectList.do','${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName')">
			                	</button>
			                	<a onclick="clearValue('${s.id}_searchBrowserValue','${s.id}_searchBrowserValueName');" href="javascript:void(0);">清除</a>
  							</c:when>
  							<c:otherwise>
  								<input type="text"  value="${s.searchBrowserValue }" name="searchBrowserValue"/>
  							</c:otherwise>
  						</c:choose>
  					</td>
  					<td>
  						&nbsp;
  						<i class="fam-cross" id="${s.id }" style="cursor:pointer" title="删除"></i>
  					</td>
  				</tr>
  				</c:forEach>
  			</table>
  			</form>
  	  </div>
  	  	<form id="NaviForm" name="NaviForm" action="<%=basePath %>reportTable/detail.do" method="post">
  			<input type="hidden" name="objname" value="" />
  			<input type="hidden" name="colName" value="" />
  			<input type="hidden" name="id" value="${requestScope.reportTable.id}"/>
  			<%@include file="/public/pagination.jsp" %>
  	  	</form>
</div>
</body>
</html>