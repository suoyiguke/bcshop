<%@page import="com.navi.utils.IPage"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
IPage pageBean=(IPage)request.getAttribute("pageBean");
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
<!-- animation-effect -->
<link href="<%=basePath%>css/animate.min.css" rel="stylesheet"> 
<script src="<%=basePath%>js/wow.min.js"></script>
<script>
 new WOW().init();
</script>
<!-- //animation-effect -->
<link href='<%=basePath%>css/Alex+Brush.css' rel='stylesheet' type='text/css'>
<link href='<%=basePath%>css/font.css' rel='stylesheet' type='text/css'>
</head>

<body>
	<jsp:include page="/public/nav.jsp" >
		<jsp:param value="news" name="module"/>
	</jsp:include>
	<!-- banner1 -->
	<div class="banner1">
		<div class="container">
		</div>
	</div>
<!-- //banner1 -->
<!-- events -->
	<div class="events">
		<div class="container">
			<h1 class="wow fadeInLeftBig" data-wow-duration="1000ms" data-wow-delay="300ms">Latest Events</h1>
			<div class="event-grids">
				<c:forEach items="${requestScope.pageBean.recordList }" var="s">
				<div class="col-md-4 event-grid wow flipInY" data-wow-duration="1000ms" data-wow-delay="300ms">
					<p class="dte">${s.publishdate }</p>
					<img style="width:350px;height:250px;" src="<%=basePath %>attach/showPicture.do?id=${s.img }" alt=" " class="img-responsive" />
					<div class="nobis">
						<a href="<%=basePath %>website/news/view.do?id=${s.id}">${s.objname }<span> maxime placeat facere</span></a>
					</div>
					<p class="quod">${s.objdesc }</p>
					<div class="more">
						<a href="<%=basePath %>website/news/view.do?id=${s.id}" class="hvr-curl-bottom-right">Read More</a>
					</div>
				</div>
				</c:forEach>
				<div class="clearfix"> </div>
				<form id="NaviForm" action="<%=basePath %>website/news/index.do" method="post">
				<%@include file="/public/page.jsp" %>
				</form>
			</div>
		</div>
	</div>
<!-- //events -->
<!-- //newsletter-bottom -->
<jsp:include page="/public/footer.jsp"></jsp:include>
<!-- for bootstrap working -->
	<script src="<%=basePath%>js/bootstrap.js"></script>
<!-- //for bootstrap working -->
</body>
</html>
