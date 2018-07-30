<%@page import="com.navi.utils.IPage"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<title>Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- Custom Theme files -->
<link href="<%=basePath%>css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="<%=basePath%>css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- js -->
<script src="<%=basePath%>js/jquery-1.11.1.min.js"></script>
<!-- //js -->
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=pZqwnQSxMZocW0lHqaDAwmgG0G0bgAMc"></script>
<!-- animation-effect -->
<link href="<%=basePath%>css/animate.min.css" rel="stylesheet"> 
<script src="<%=basePath%>js/wow.min.js"></script>
<script src="<%=basePath%>js/jquery.jsonp.js"></script>
<script>
 new WOW().init();
</script>
<!-- //animation-effect -->
<link href='<%=basePath%>css/Alex+Brush.css' rel='stylesheet' type='text/css'>
<link href='<%=basePath%>css/font.css' rel='stylesheet' type='text/css'>
</head>

<body>
	<jsp:include page="/public/nav.jsp" >
		<jsp:param value="aboutus" name="module"/>
	</jsp:include>
	<!-- banner1 -->
	<div class="banner1">
		<div class="container">
		</div>
	</div>
<!-- //banner1 -->
<!-- contact -->
	<div style="width:80%;margin:0 auto;margin-bottom:50px;">
	<p style="line-height:30px;">${news.content }</p>
	</div>
<!-- //contact -->
<!-- //newsletter-bottom -->
<jsp:include page="/public/footer.jsp"></jsp:include>
<!-- for bootstrap working -->
	<script src="<%=basePath%>js/bootstrap.js"></script>
<!-- //for bootstrap working -->
<script type="text/javascript">
$(function(){
	$("#addBtn").click(function(){
		$.post($("#NaviForm").attr("action"),$("#NaviForm").serialize(),function(data){
			if(data.isOk==1){
				alert("感谢您的宝贵留言！");
				location.reload();
			}
		},"json");
	});
	
	
	$.jsonp({
	  	url:"http://api.map.baidu.com/geoconv/v1/?coords=${coords}&from=1&to=5&ak=pZqwnQSxMZocW0lHqaDAwmgG0G0bgAMc&callback=?",
	  	success:function(data){
	        if(data.result){
	        		var y=data.result[0].y;
	        		var x=data.result[0].x;
	        		var map = new BMap.Map("allMap");
	        		var geolocation = new BMap.Geolocation();
	      			var point = new BMap.Point(x, y);
	      			map.centerAndZoom(point, 15);      			
	      			map.enableScrollWheelZoom(true); 
	      			var marker = new BMap.Marker(point);        // 创建标注    
	      			map.addOverlay(marker);  
	        }        
    	}
    });
});
</script>
</body>
</html>
