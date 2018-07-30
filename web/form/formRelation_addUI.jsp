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
    <script type="text/javascript" src="<%=basePath %>js/jqValidate/jquery.metadata.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jqValidate/jquery.validate.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-validate.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-validatePlugin.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- Bootstrap framework -->
	<script type="text/javascript">
		$(function(){
    		//$("form").validate();
    		if(${!(empty requestScope.formRelation)}==true){
    			var id="${requestScope.formRelation.entityFormId}";
    			$.post("<%=basePath%>data/getById.do",{id:id,tableName:"formInfo"},function(data){
					if(data.success=="ok"){
						$("#entityFormDescription").val(data.object['objdesc']+"/"+data.object['objname']);
					}
				},"json");
    		}
    		$(".popWin").naviLayer();
    		$(".getFieldNameById").naviGetFieldNameById({idKey:"idKey"});
    	});
    	function formSubmit(){
    		var naviForm=$("#NaviAddForm");
			var url=naviForm.attr("action");
			$.post(url,naviForm.serialize(),function(data){
				if(data.isOk==1){
					var obj=window.parent;
					obj.naviLayer.close();
					obj.location.reload();
				}
			},"json");
    	}
    	function addOrEdit(){
			if(${(empty requestScope.formRelation)}){
				$.post("<%=basePath%>formRelation/exist.do",{virtualityFormId:$("#virtualityFormId").val(),entityFormId:$("#entityFormId").val()},function(data){
					if(data=="ok"){
						formSubmit();
					}else{
						if(confirm("您选取的表单和现在的表单已存在关联关系，你确定要继续添加吗？")){
							formSubmit();
						}
					}
				});
			}else{
				formSubmit();
			}
		}
	</script>
  </head>
  <body style="background:#fff;">
  	<div id="wrap">
  		<div class="nav">
  			系统设置> 表单关系${(empty requestScope.form) ?"添加":"修改"}
  		</div>
  		<div class="toolbar">
  			<button class="btn" onclick="addOrEdit();">提交(S)</button>
  			<button class="btn" onclick="closePanel()">取消(C)</button>
  		</div>
  		<div class="tab">
  			<ul>
  				<li class="first active"><a href="javascript:void(0);">表单关系${(empty requestScope.formRelation) ?"添加":"修改"}</a></li>
  			</ul>
  			<div class="tabContent">
		  		<form id="NaviAddForm" name="NaviAddForm" action="<%=basePath %>formRelation/${(empty requestScope.formRelation) ?"add":"edit" }.do" method="post">
			       	<table class="addTable">
			           <tbody>
			           		<tr>
			                   <th>关联表单</th>
			                   <td>
			                   <input type="hidden" id="id" name="id" value="${requestScope.formRelation.id}"/>
			                   <input type="hidden" id="virtualityFormId" name="virtualityFormId" value="${(empty requestScope.formRelation)?requestScope.virtualityFormId:requestScope.formRelation.virtualityFormId}"/>
			                   <input type="hidden" class="text" name="entityFormId" id="entityFormId" value="${requestScope.formRelation.entityFormId }"/>
			                    <input tableName="formInfo" fieldName="objname" idspan="entityFormId" namespan="entityFormDescription" url="<%=basePath %>form/selectList.do?isEntityForm=1"  idKey="${requestScope.formRelation.entityFormId  }" readOnly="readOnly" class="required popWin getFieldNameById" value="" type="text" id="entityFormDescription" name="entityFormDescription"/>
			                	<button idspan="entityFormId" namespan="entityFormDescription" url="<%=basePath %>form/selectList.do?isEntityForm=1" class="browser popWin" type="button">
			                	</button>
			                	<a onclick="clearValue('entityFormId','entityFormDescription');" href="javascript:void(0);">清除</a>
			                   </td>
			               </tr>
			                <tr>
			                   <th>关联表单作用</th>
			                   <td>
			                   	<input type="radio" name="isMainForm" ${requestScope.formRelation.isMainForm==1?'checked':'' } value="1"/>&nbsp;主表
			                   	<input type="radio" name="isMainForm" value="0" ${requestScope.formRelation.isMainForm!=1?'checked':'' }/>&nbsp;明细表
			                   </td>
			               </tr>
			                <tr>
			                   <th>顺序</th>
			                   <td>
			                   	<input type="text" name="position" value="${(empty requestScope.formRelation)?'':requestScope.formRelation.position }"/>
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
