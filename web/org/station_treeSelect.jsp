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
	<!-- Bootstrap framework -->
	<%@include file="/public/common.jsp" %>
	<link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/easyui/themes/default/easyui.css"/>
   	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/easyui/themes/icon.css"/>
   	<script type="text/javascript" src="<%=basePath%>js/easyui/jquery.easyui.min.js"></script>
   	<script type="text/javascript" src="<%=basePath%>js/navi/navi-browse_select.js"></script>	
   	<style type="text/css">
   		#tree a:hover{
   			text-decoration:none;
   		}
   	</style>
  </head>
  <body style="background:#fff;">
  	<div >
  		<i onclick="reLoadTreeData()" title="刷新" style="cursor:pointer;position:relative;left:-15px;top:6px;float:right;" class="fam-arrow-refresh"></i>
	  	<div style="padding:5px" class="left_content">
		  	<ul id="tree" class="left_content">
		  	</ul>
	  	</div>
    </div>
  	<script type="text/javascript">
		$(function(){
			var inputId="${requestScope.inputId}";
			var inputName="${requestScope.inputName}";
			var orgId="${requestScope.orgId}";
			var url="<%=basePath%>station/treeJson.do";
			if(orgId!=""){
				url='<%=basePath%>station/treeJson.do?orgId='+orgId;
			}
			$('#tree').tree({   
		      checkbox: false,   
		      url: url,   
		      lines:true, 
		      animate:true,
		      formatter:function(node){
		         var s = node.text;
		         return '<a href="javascript:void(0);" onclick="singleSelect(\''+inputId+'\',\''+inputName+'\',\''+node.id+'\',\''+s+'\')">'+s+'</a>';
		      }
			});
		});
		$(function(){ 
			//iframe自适应高度
			var mainFrame=$("iframe");
		    mainFrame.load(function(){ 
			      $(this).height(0); //用于每次刷新时控制IFRAME高度初始化 
			      var height = $(this).contents().height() + 50; 
			      $(this).height( height < 450 ? 450 : height ); 
		    }); 
		});
        function reLoadTreeData(){
        	var t = $('#tree').tree();
        }
	</script>
  </body>
</html>
