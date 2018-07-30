<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
	<%@include file="/public/common.jsp" %>
	<link  rel="stylesheet" href="<%=basePath %>css/fam-icons.css" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/easyui/1.3.4/themes/default/easyui.css"/>
   	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/easyui/1.3.4/css/icon.css"/>
   	<script type="text/javascript" src="<%=basePath%>js/easyui/1.3.4/jquery.easyui.min.js"></script>
   	<script type="text/javascript" src="<%=basePath%>js/easyui/easyui.tree.search.js"></script>
   	<style type="text/css">
   		#tree{
   			padding-top:5px;
   		}
   		#tree a:hover{
   			text-decoration:none;
   		}
   		.tree-node-match{
   			color:red;
   			font-weight:bold;
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
<body id="orgtree">
	<div id="left" class="resizable">
  		<i onclick="reLoadTreeData()" title="刷新" style="cursor:pointer;position:relative;left:-15px;top:6px;float:right;" class="fam-arrow-refresh"></i>
	  	<div style="padding:5px" class="left_content">
	  		<input type="text" id="searchText" name="searchText" value=""/>
	  		<button class="btn" onclick="searchText();">搜索(S)</button>
	  		<br>
	  		<a href="javascript:void(0)" onclick="expandAll()">展开</a>
	  		<a href="javascript:void(0)"  onclick="collapseAll()">收缩</a>
	  		
		  	<ul id="tree" class="left_content">
		  	</ul>
	  	</div>
    </div>
    <div id="right" class="resizable">
    	<iframe frameborder="0" src="" width="100%"></iframe>
    </div>
  	<script type="text/javascript">
		$(function(){
			reLoadTreeData();
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
		function removeNode(id){
			var node=$('#tree').tree("find",id);
			$('#tree').tree("remove",node.target);
		}
		function selectParent(id){
			var node=$('#tree').tree("find",id);
			$('#tree').tree("select",$('#tree').tree("getParent",node.target).target)
		}
		function addNode(pid,node){
			var selected=$('#tree').tree("find",pid);
			$('#tree').tree("append",{
				parent: selected.target,
				data: [node]
			});
			$('#tree').tree("select",$('#tree').tree("find",node.id).target)
		}
		function expandAll(){
			 $('#tree').tree("expandAll");
		}
		function collapseAll(){
			 $('#tree').tree("collapseAll");
		}
        function reLoadTreeData(){
        	$('#tree').tree({   
		      checkbox: false,   
		      url: '<%=basePath%>org/list.do?type=org',   
		      lines:true, 
		      animate:true,
		      onBeforeExpand:function(node,param){
		    	  if(node.type){
		          	 $('#tree').tree('options').url = "<%=basePath%>org/list.do?pid=" + node.id+"&type="+node.type;
		    	  }else{
		    		 $('#tree').tree('options').url = "<%=basePath%>org/list.do?pid=" + node.id+"&type="+node.attributes['type'];
		    	  }
	      	  },onClick:function(node){
          	  	var frame=$("iframe");
                frame.attr("src","<%=basePath%>"+node.type+"/editUI.do?id="+node.id);
		      },onLoadSuccess:function(node,data){
			     var t = $(this);
		   		 if(data){
				    $(data).each(function(index,d){
						if(this.state == 'closed'){
						    t.tree('expandAll');
						}
				     });
				 }
			    }
			});
        }
        function searchText(){
        	var searchText=$("#searchText").val();
        	if(searchText==""){
        		alert("请输入搜索的内容!");
        		return;
        	}
        	$('#tree').tree("search",searchText);
        }
	</script>
</body>
</html>
