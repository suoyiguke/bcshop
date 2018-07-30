<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
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
	<jsp:include page="/public/nav.jsp">
		<jsp:param value="home" name="module"/>
	</jsp:include>
<!-- banner -->
	<div class="banner">
		<div class="container">
			<div class="banner-info">
				<h1 class="animated fadeInLeftBig" data-wow-duration="1000ms" data-wow-delay="300ms">Meiri Furniture Shixing Company.<span>Excepteur sint occaecat cupidatat non proident</span></h1>
				<div class="banner-info1 animated wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
					<ul id="flexiselDemo1">			
						<c:forEach items="${requestScope.lbList }" var="s">
						<li>
							<div class="banner-info1-grid">
								<img src="<%=basePath%>attach/showPicture.do?id=${s.img}" alt=" " class="img-responsive" />
								<h3>${s.objname }</h3>
								<p>${s.objdesc }</p>
							</div>
						</li>
						</c:forEach>
					</ul>
						<script type="text/javascript">
							$(window).load(function() {
								$("#flexiselDemo1").flexisel({
									visibleItems: 3,
									animationSpeed: 1000,
									autoPlay: true,
									autoPlaySpeed: 3000,    		
									pauseOnHover: true,
									enableResponsiveBreakpoints: true,
									responsiveBreakpoints: { 
										portrait: { 
											changePoint:480,
											visibleItems: 1
										}, 
										landscape: { 
											changePoint:640,
											visibleItems:2
										},
										tablet: { 
											changePoint:768,
											visibleItems: 2
										}
									}
								});
								
							});
					</script>
					<script type="text/javascript" src="<%=basePath%>js/jquery.flexisel.js"></script>
					<div class="more wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
						<a href="<%=basePath %>website/product/index.do" class="hvr-curl-bottom-right">Read More</a>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- //banner -->
<!-- banner-bottom -->
	<div class="banner-bottom">
		<div class="container">
			<div class="banner-bottom-grids">
				<div class="col-md-5 banner-bottom-grid wow fadeInRightBig" data-wow-duration="1000ms" data-wow-delay="300ms">
					<h2>${twList[0].objname }</h2>
					<p>${twList[0].objdesc }</p>
					<div class="more">
						<a href="<%=basePath %>website/product/view.do?id=${twList[0].id }" class="hvr-curl-bottom-right">Read More</a>
					</div>
				</div>
				<div class="col-md-7 banner-bottom-grid wow flipInY" data-wow-duration="1000ms" data-wow-delay="300ms">
					<div class="banner-bottom-grid1">
						<img src="<%=basePath%>attach/showPicture.do?id=${twList[0].img}" width="500px" height="333px" alt=" " class="img-responsive" />
						<div class="banner-bottom-grid-pos">
							<div class="progress">
							  <div class="progress-bar" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width: 30%;">
								<span class="sr-only">30% Complete</span>
							  </div>
							</div>
							<div class="progress progress1">
							  <div class="progress-bar" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%;">
								<span class="sr-only">20% Complete</span>
							  </div>
							</div>
							<div class="progress progress2">
							  <div class="progress-bar" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width: 30%;">
								<span class="sr-only">30% Complete</span>
							  </div>
							</div>
						</div>
					</div>
				</div>
				<div class="clearfix"> </div>
			</div>
			<div class="banner-bottom-grids">
				<div class="col-md-6 banner-bottom-grid-1 wow flipInY" data-wow-duration="1000ms" data-wow-delay="300ms">
					<div class="banner-bottom-grid-11">
						<img src="<%=basePath%>attach/showPicture.do?id=${twList[1].img }" width="300px" height="451px"  alt=" " class="img-responsive" />
						<div class="banner-bottom-grid-11-pos">
							<p>${twList[1].objdesc }</p>
							<div class="more m1">
								<a href="<%=basePath %>website/product/view.do?id=${twList[1].id }" class="hvr-curl-bottom-right">Read More</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-6 banner-bottom-grid-1 wow fadeInLeftBig" data-wow-duration="1500ms" data-wow-delay="100ms">
					<h3>${twList[1].objname }</h3>
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>
<!-- //banner-bottom -->
<!-- newsletter -->
	<div class="newsletter">
		<div class="container">
			<div class="newsletter-info">
				<h3 class="wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">Newsletter</h3>
				<p class="wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">But who has any right to find fault with a man who chooses to enjoy 
					a pleasure that has no annoying consequences</p>
				<form class="wow fadeInLeftBig" data-wow-duration="1000ms" data-wow-delay="300ms">
					<input type="mail" value="Enter Your Email" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Enter Your Email';}" required="">
					<input type="submit" value="Send">
				</form>
			</div>
		</div>
	</div>
<!-- //newsletter -->
<!-- newsletter-bottom -->
	<div class="newsletter-bottom">
		<div class="container">
			<div class="newsletter-bottom-grids">
				<div class="col-md-6 newsletter-bottom-grid wow fadeInLeftBig" data-wow-duration="1000ms" data-wow-delay="300ms">
					<h3>${twList[2].objname }</h3>
					<p>${twList[2].objdesc}</p>
					<div class="more">
						<a href="<%=basePath %>website/product/view.do?id=${twList[2].id }" class="hvr-curl-bottom-right">Read More</a>
					</div>
				</div>
				<div class="col-md-6 newsletter-bottom-grid wow flipInY" data-wow-duration="1000ms" data-wow-delay="300ms">
					<img src="<%=basePath%>attach/showPicture.do?id=${twList[2].img }" alt=" " width="300px" height="265px" class="img-responsive" />
				</div>
				<div class="clearfix"> </div>
			</div>
			<div class="newsletter-bottom-grids">
				<div class="col-md-6 newsletter-bottom-grid wow flipInY" data-wow-duration="1000ms" data-wow-delay="300ms">
					<img src="<%=basePath%>attach/showPicture.do?id=${twList[3].img }" alt=" "  width="400px" height="358px" class="img-responsive" />
				</div>
				<div class="col-md-6 newsletter-bottom-grid  wow fadeInLeftBig" data-wow-duration="1000ms" data-wow-delay="300ms">
					<h3>${twList[3].objname }</h3>
					<p>${twList[3].objdesc }</p>
					<div class="more">
						<a href="<%=basePath %>website/product/view.do?id=${twList[3].id }" class="hvr-curl-bottom-right">Read More</a>
					</div>
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>
<!-- //newsletter-bottom -->
<jsp:include page="/public/footer.jsp"></jsp:include>
<!-- for bootstrap working -->
	<script src="<%=basePath%>js/bootstrap.js"></script>
<!-- //for bootstrap working -->
</body>
</html>
