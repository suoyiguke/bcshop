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
    
    <title>分类树</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- Bootstrap framework -->
	<%@include file="/public/common.jsp" %>
	<link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/easyui/1.3.4/themes/default/easyui.css"/>
   	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/easyui/1.3.4/themes/icon.css"/>
   	<script type="text/javascript" src="<%=basePath%>js/easyui/1.3.4/jquery.easyui.min.js"></script>	
   	
   	<style type="text/css">
   		#tree a:hover{
   			text-decoration:none;
   		}
   		div#left{
   			border-right:1px solid #ccc;
   			float:left;
   			width:24%;
   			height:100%;
   		}
   		div#right{
   			float:left;
   			height:100%;
   			min-height:450px;
   			width:75.9%;
   			background:#fff;
   		}
   	</style>
  </head>
  <body style="background:#fff;">
  	<div id="left" class="resizable">
  		<i onclick="reLoadTreeData()" title="刷新" style="cursor:pointer;position:relative;left:-15px;top:6px;float:right;" class="fam-arrow-refresh"></i>
	  	<div style="padding:5px" class="left_content">
		  	<ul id="tree" class="left_content">
		  	</ul>
	  	</div>
	  	<div id="mm" class="easyui-menu" class="left_content">
	        <div onclick="appendMenu()" data-options="iconCls:'icon-add'">新增子分类</div>
	        <div onclick="removeMenu()" data-options="iconCls:'icon-remove'">删除分类</div>
	        <div class="menu-sep"></div>
	        <div onclick="expand()">展开</div>
	        <div onclick="collapse()">合并</div>
	    </div>
    </div>
    <div id="right" class="resizable">
    	<iframe frameborder="0" src="" width="100%"></iframe>
    </div>
  	<script type="text/javascript">
		$(function(){
			$('#tree').tree({   
		      checkbox: false,   
		      url: '<%=basePath%>tree/jsonList.do?type=Category&isAll=1',   
		      lines:true, 
		      animate:true,
		      onContextMenu: function(e,node){
                    e.preventDefault();
                    $(this).tree('select',node.target);
                    $('#mm').menu('show',{
                        left: e.pageX,
                        top: e.pageY
                    });
              },
              onClick:function(node){
            	  var frame=$("iframe");
                  frame.attr("src","<%=basePath%>category/editUI.do?id="+node.id);
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
		function appendMenu(){
            var t = $('#tree');
            var node = t.tree('getSelected');
            var frame=$("iframe");
            frame.attr("src","<%=basePath%>category/addUI.do?pid="+node.id);
        }
        function removeMenu(){
        	var t = $('#tree');
            var node = t.tree('getSelected');
            $.post("<%=basePath%>category/delete.do",{id:node.id},function(data){
            	if(data.isOk==1){
            		reLoadTreeData();
            	}else{
            		alert(data.msg);
            	}
            },"json");
        }
        function reLoadTreeData(){
        	var t = $('#tree').tree();
        }
	</script>
  </body>
</html>
