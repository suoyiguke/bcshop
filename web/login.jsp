<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <title>Navi-登录</title>
    <%@include file="/public/common.jsp" %>
    <style>
    </style>
</head>

<body>
    <div class="logo-wrap">
        <div class="login-form">
            <div class="login-box">
                <form id="form-login" action="j_spring_security_check" method="POST">
                    <h1>Navi LOGIN</h1>
                    <div class="form-group">
                        <input type="text" class="form-control" name="j_username" placeholder="账号">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" name="j_password" placeholder="密码">
                    </div>
                    <br>
                    <div>
                        <button type="submit" class="btn-primary btn-fluid">登录</button>
                    </div>
                    <div class="info">欢迎您，本服务由Navi提供</div>
                </form>
            </div>
        </div>
    </div>
</body>  
</html>  

