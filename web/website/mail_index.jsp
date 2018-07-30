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
		<jsp:param value="contact" name="module"/>
	</jsp:include>
	<!-- banner1 -->
	<div class="banner1">
		<div class="container">
		</div>
	</div>
<!-- //banner1 -->
<!-- contact -->
	<div class="contact">
		<div class="container">
			<h1 class="animated fadeInLeftBig" data-wow-duration="1000ms" data-wow-delay="300ms">How To Find Us</h1>
			<div class="contact-bottom wow fadeInLeft" data-wow-duration="1000ms" data-wow-delay="300ms">
				 <div id="allMap" style="width: 100%;height: 500px;"></div>
			</div>
			<div class="col-md-4 contact-left wow fadeInLeftBig" data-wow-duration="1000ms" data-wow-delay="300ms">
				<h4>Address</h4>
				<h2>${address }</h2>
				<ul>
					<li>Name :${name }</li>
					<li>Free Phone :${tel1 }</li>
					<li>Telephone :${tel2 }</li>
					<li><a href="mailto:${email }">${email }</a></li>
					<li>WetChat :navi_haichao</li>
					<li><img width="180px" height="180px" src="<%=basePath%>images/wechat.jpg"/></li>
				</ul>
			</div>
			<div class="col-md-8 contact-left wow fadeInRight" data-wow-duration="1000ms" data-wow-delay="300ms">
				<h4>Contact Form</h4>
				<form id="NaviForm" action="<%=basePath%>website/mail/add.do" method="post">
					<input type="text"  name="objname" value="Title" id="Title" onfocus="if(this.value=='Title'){this.value = ''};" onblur="if (this.value == '') {this.value = 'Title';}" required="true">
					<input type="text" name="username" value="Name" id="Name"  onfocus="if(this.value=='Name'){this.value = '';}" onblur="if (this.value == '') {this.value = 'Name';}" required="true">
					<input type="email" name="email" value="Email"  id="Email"onfocus="if(this.value=='Email'){this.value = '';}" onblur="if (this.value == '') {this.value = 'Email';}" required="true">
					<input type="text" name="tel" value="Telephone" id="Telephone" onfocus="if(this.value=='Telephone'){this.value = '';}" onblur="if (this.value == '') {this.value = 'Telephone';}" required="true">
					<textarea type="text"  name="objdesc" id="Message" onfocus="if(this.value=='Message'){this.value = '';}" onblur="if (this.value == '') {this.value = 'Message';}" required="true">Message</textarea>
					<input type="button" id="addBtn" value="Submit" >
					<input type="reset" value="Clear" >
				</form>
			</div>
			<div class="clearfix"> </div>
		</div>
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
		var validate=true;
		$("#NaviForm input").each(function(){
			if($(this).val()==""||$(this).val()==$(this).attr("id")){
				$(this).css({"border":"1px solid red"});
				validate=false;
			}
		});
		$("#NaviForm textarea").each(function(){
			if($(this).val()==""||$(this).val()==$(this).attr("id")){
				$(this).css({"border":"1px solid red"});
				validate=false;
			}
		});
		if(!validate){
			return;
		}
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
