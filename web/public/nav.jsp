<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String module=request.getParameter("module");
%>
<!-- header -->
	<div class="header">
		<div class="container">
			<nav class="navbar navbar-default">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
				  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				  </button>
					<div class="logo">
						<a class="navbar-brand" href="index.html">Furniture</a>
					</div>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
					<nav class="cl-effect-13" id="cl-effect-13">
						<ul class="nav navbar-nav">
							<li><a href="<%=basePath %>website/index.do" id="home" class="active">Home</a></li>
							<li><a id="aboutus"  href="<%=basePath %>website/aboutus.do">About Us</a></li>
							<li><a href="<%=basePath %>website/product/index.do" id="product" >Products</a></li>
							<li><a href="<%=basePath %>website/news/index.do" id="news" >News & Events</a></li>
							<!-- 
							<li role="presentation" id="home"  class="dropdown">
								<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
								  Services <span class="caret"></span>
								</a>
								<ul class="dropdown-menu">
								  <li><a href="services.html">Door Delivery</a></li>
								  <li><a href="services.html">Direct Delivery</a></li>
								</ul>
							</li>
							 -->
							<li><a id="contact"  href="<%=basePath %>website/mail/index.do">Mail Us</a></li>
						</ul>
					</nav>
				</div>
				<!-- /.navbar-collapse -->
			</nav>
		</div>
	</div>
<!-- header -->
<script type="text/javascript">
$(function(){
	$(".navbar-nav li a").removeClass("active");
	$(".navbar-nav li a[id='<%=module%>']").addClass("active");
});
</script>