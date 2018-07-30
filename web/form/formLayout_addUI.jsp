<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath %>">
    <title></title>
    <%@include file="/public/common.jsp" %>
    <script type="text/javascript" src="<%=basePath %>js/tinymce/tinymce.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/tinymce/langs/zh_CN.js"></script>
    <script type="text/javascript">
    $(function(){
    	tinymce.init({
    		selector:'#layoutInfo',
    		object_resizing : "table,input,img,textarea",
    		theme: "modern",
		    height: 480,
		    //resize: "both",
		    content_css:"<%=basePath %>css/navi-dynamicTable.css",
		    trim_span_elements:false,
		    verify_html:false,
		    code_dialog_width:$("body").width()-100,
		    code_dialog_height:$("body").height()-150,
			plugin_preview_width:$("body").width()-100,
			plugin_preview_height:$("body").height()-150,
		    plugins: [
		         "advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker",
		         "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
		         "save table contextmenu directionality emoticons template paste textcolor"
   			],
   			contextmenu: "link image inserttable | cell row column deletetable",
   			toolbar: "bold  italic underline strikethrough subscript superscript  | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect | copy paste cut  print | bullist numlist outdent indent | moveforward movebackward | link image media charmap | forecolor backcolor emoticons | table | insertUpRow insertDownRow  deleteRow | insertLeftCol insertRightCol deleteCol | mergeCells | searchreplace fullscreen preview code",
   			style_formats: [
		        {title: 'Bold text', inline: 'b'},
		        {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
		        {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
		        {title: 'Example 1', inline: 'span', classes: 'example1'},
		        {title: 'Example 2', inline: 'span', classes: 'example2'},
		        {title: 'Table styles'},
		        {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
		    ],
		    setup:function(editor) {
				editor.addButton('insertUpRow', {
					text: '上插行',
					//icon: true,
					//style:'background:url(\'<%=basePath%>css/imgs/tinymce-icons.gif\') no-repeat;background-position:-740px -20px',
					tooltip:'向上插入一行',
					//image:'',
					onclick: function() {
						editor.execCommand("mceTableInsertRowBefore");
					}
				});
				editor.addButton('insertDownRow', {
					text:'下插行',
					tooltip: '向下插入一行',
					icon: false,
					onclick: function() {
						editor.execCommand("mceTableInsertRowAfter");
					}
				});
				editor.addButton('insertRightCol', {
					text:'右插列',
					tooltip: '向右插入一列',
					icon: false,
					onclick: function() {
						editor.execCommand("mceTableInsertColAfter");
					}
				});
				editor.addButton('insertLeftCol', {
					text:'左插列',
					tooltip: '向左插入一列',
					icon: false,
					onclick: function() {
						editor.execCommand("mceTableInsertColBefore");
					}
				});
				editor.addButton('deleteRow', {
					text:'删除行',
					tooltip: '删除行',
					icon: false,
					onclick: function() {
						editor.execCommand("mceTableDeleteRow");
					}
				});
				editor.addButton('deleteCol', {
					text:'删除列',
					tooltip: '删除列',
					icon: false,
					onclick: function() {
						editor.execCommand("mceTableDeleteCol");
					}
				});
				/*
				editor.addButton('splitCells', {
					text:'拆分单元格',
					tooltip: '拆分单元格',
					icon: false,
					onclick: function() {
						editor.execCommand("mceTableSplitCells",true);
					}
				});
				*/
				editor.addButton('mergeCells', {
					text:'合并单元格',
					tooltip: '合并单元格',
					icon: false,
					onclick: function() {
						editor.execCommand("mceTableMergeCells",true);
					}
				});
			}
    	});
    	
    	
    	
    	$("#tables li").each(function(){
    		var li=$(this);
    		li.click(function(){
	    		$("#columns li").show();
	    		var id=li.attr("id");
	    		$("#columns li[tableInfo!='"+id+"']").hide();
    		});
    	});
    	
    	$("#columns li").each(function(){
    		var li=$(this);
    		li.click(function(){
	    		var id=li.attr("id");
	    		var reg=new RegExp("<[i|I][n|N][p|P][u|U][t|T][^>].*"+id+"[^>]*>","ig");
	    		if(!reg.test(tinymce.activeEditor.getContent())){
		    		var text=li.html();
		    		var content="<input id=\"$"+id+"$\" name=\"$"+id+"$\" type=\"text\" value=\""+text+"\" />";
		    		executeCommand("layoutInfo","mceInsertContent",false,content);
	    		}else{
	    			alert("已经添加了此字段，请勿重复添加！");
	    		}
    		});
    	});
    	
    });
    	
    	
    	function saveOrEdit(){
    		$("#objname").val($("#objnameTemp").val());
    		$("#position").val($("#positionTemp").val());
    		$("#typeId").val($("#typeIdTemp").val());
    		$("#NaviForm").submit();
    	}
    	function searchColumn(){
    		var text=$("#searchColumnObjname").val();
    		$("#columns li").show();
    		$("#columns li").each(function(){
    			var t=$(this).html();
    			if(t.indexOf(text)==-1){
    				$(this).hide();
    			}
    		});
    	}
    	function executeCommand(selector,command,ui,value){
    		tinymce.get(selector).execCommand(command,ui,value);
    	}
    </script>
	<style type="text/css">
		div.left{
			width:80%;
			float:left;
		}
		div.right{
			width:18%;
			float:left;
			margin-left:10px;
		}
		select.selMul{
			width:100%;
		}
		ul{
			width:100%;
			border:1px solid #8c9abb;
			margin-top:10px;
			overflow:auto;
			height:350px;
		}
		ul li{
			line-height:20px;
			padding-left:5px;
			cursor:pointer;
		}
		ul li:hover{
			background:#eee;
		}
	</style>
  </head>
 <body>
<div id="wrapper" class="wrapper" style="padding-top:15px;">
	  <form id="NaviForm" action="<%=basePath%>formLayout/${(empty requestScope.formLayout.id)?"add":"edit"}.do" method="post">
	  	   <input type="hidden" name="id" value="${requestScope.formLayout.id }"/>
	  	   <input  type="hidden" name="formId" value="${requestScope.form.id }"/>
	  	   <input  type="hidden" name="pipeId" value="${requestScope.formLayout.pipeId }"/>
	  	   <input  type="hidden" name="nodeId" value="${requestScope.formLayout.nodeId}"/>
	  	   <input  type="hidden" name="formLayoutType" value="${requestScope.formLayout.formLayoutType }"/>
	  	   <input type="hidden" id="objname"name="objname" value=""/>
	  	   <input type="hidden" id="position"name="position" value=""/>
	  	   <input type="hidden" id="typeId"name="typeId" value=""/>
	       <div class="left">
		       	<textarea name="layoutInfo" id="layoutInfo">
		       	${requestScope.formLayout.layoutInfo }
		       	</textarea>
	       </div>
       </form>
       <div class="right">
       	<div style="border:1px solid #8c9abb;padding:5px;">
	       	<p style="text-align:center;font-weight:600;">关联表单</p>
	       	<ul id="tables" style="height:75px;">
	       		<c:forEach items="${requestScope.formList }" var="t">
	       			<li id="${t.id }">${t.objname }</li>
	       		</c:forEach>
	       	</ul>
	       	<ul id="columns">
	       		<c:forEach items="${requestScope.fieldList }" var="c">
	       			<li tableInfo="${c.formId }" id="${c.id }" title="${c.formObjname}(${c.formTabName})->${c.objname }(${c.colName})">${c.objname }</li>
	       		</c:forEach>
	       	</ul>
	       	<div style="margin:5px;">
	        	字段名称<input type="text" value="" size="20" id="searchColumnObjname" name="searchColumnObjname"/>
	        	<p style="margin-top:5px;text-align:center">
		         	<button class="btn" onclick="searchColumn()">查询(S)</button>
	        	</p>
	       	</div>
	    </div>
       	<div style="margin-top:15px;">
       		<p>布局名称<input type="text" id="objnameTemp" name="objnameTemp" size="20" value="${requestScope.formLayout.objname }"/></p>
       		<p style="margin-top:5px;">布局分类
       			<select name="typeIdTemp" id="typeIdTemp">
					<option value="">==请选择分类==</option>
					<c:forEach items="${requestScope.typeList }" var="s">
						<option value="${s.id }" <c:if test="${s.id==requestScope.formLayout.typeId }">selected="selected"</c:if>>${s.objname }</option>
					</c:forEach>
				</select>
       		</p>
       		<p style="margin-top:5px;">布局顺序<input type="text" id="positionTemp" name="positionTemp" size="20" value="${requestScope.formLayout.position }"/></p>
       		<p style="margin-top:5px;text-align:center">
       			<button class="btn" style="margin-right:10px;"onclick="saveOrEdit()">保存(S)</button>
       			<button class="btn" onclick="window.close();">退出(E)</button>
       		</p>
       	</div>
      </div>
</div>
</body>
</html>