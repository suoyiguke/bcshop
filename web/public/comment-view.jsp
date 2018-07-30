<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Comment</title>
    <script src="<%=basePath %>js/jquery/jquery-1.9.0.min.js"></script>
    <script src="<%=basePath %>js/kindeditor4.1.10/kindeditor-min.js"></script>
	<script src="<%=basePath %>js/kindeditor4.1.10/addRichEditor.js"></script>
	<script src="<%=basePath %>js/kindeditor4.1.10/lang/zh_CN.js"></script>
	<script src="<%=basePath %>js/kindeditor4.1.10/plugins/code/prettify.js"></script>
	<script src="<%=basePath %>js/navi/navi-getFieldValueById.js"></script>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>css/global.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>css/navi-common.css">

	<style type="text/css">

	</style>
	<script type="text/javascript">
	$(function(){
		$("textarea.rich_editor").each(function(){
	   		var id=$(this).attr("id");
	   		var height=$(this).attr("editorH");
	   		var width=$(this).width();
	   		height=height?height:"270px";
	   		$(this).html("");
	   		addRichEditor("<%=basePath %>",id,width,height);
	   	});
		
		$(window.parent.document).find("#commentFrame").load(function () {
		    var main = $(window.parent.document).find("#commentFrame");
		    var thisheight = $(document).height()+250;
		    main.height(thisheight);
		});
		
		$("#addBtn").click(function(){
			$.post($("#addForm").attr("action"),$("#addForm").serialize(),function(data){
				if(data.isOk==1){
					location.reload();
				}
			},"json");
		});
		$(".addBtn").click(function(){
			var naviForm=$(this).parent("form");
			var url=naviForm.attr("action");
			$.post(url,naviForm.serialize(),function(data){
				if(data.isOK==1){
					location.reload();
				}
			},"json");
		});
		$(".reply-topic").click(function(){
			var id=$(this).attr("id");
			var editor_div=$("#editor_div_"+id);
			editor_div.find("input[name='pid']").val(id);
			editor_div.find("input[name='toUserId']").val($(this).attr("toUserId"));
			var oldClickId=editor_div.find("input[name='clickId']").val();
			editor_div.find("input[name='clickId']").val($(this).attr("clickId"));
			if(editor_div.hasClass("hide")){
				$(".editor_div").addClass("hide");
				editor_div.removeClass("hide");
			}
			var toUserName=$(this).parent().find("span.getFieldNameById[id='"+$(this).attr("toUserId")+"']").html();
			editor_div.find("div.showInfo").html("您正在回复"+toUserName);
			var t=editor_div.offset().top;
			$(window).scrollTop(t-200);
			var editor=getEditor("content_"+id);
			editor.focus();
		});
		$(".del-topic").click(function(){
			var id=$(this).attr("id");
			$.post("<%=basePath%>comment/delete.do",{id:id},function(data){
				if(data.isOk=='ok'){
					window.location.reload();
					location.href="<%=basePath%>comment/view.do?creator={creator}";
				}else{
					alert("删除失败！");
				}				
			},"json");
		})
		
		$(".getFieldValueById").getFieldValueById({"basePath":"<%=basePath%>"});
	});
	</script>
  </head>
  <style>
 .ke-statusbar{border-top:none !important;}
  .ke-container-simple .ke-statusbar{border-top:none !important;}
  .list{margin-left:10px;margin-right:20px;}
  .bar_title{
  	font-size:16px;
  	border-bottom:1px solid #eee;
  	color:#45bdf5;
  	margin:20px 0;
  	padding-bottom:5px;
  }
  .btn-common {
    padding: 5px 25px;
    background: #45bdf5;
    border: none;
    color: #fff;
    margin-top:10px;
  }
  </style>
  <body class="bg_white" style="width:98%;margin:0 auto;">
  <c:if test="${user!=creator }">
	<div class="pb20">	
		<div class="bar_title mb20">Reply</div>
		<form id="addForm" name="addForm" action="<%=basePath%>comment/add.do" method="post">
			<textarea style="width:98%" name="content" class="rich_editor"  editorH="80px" id="editor_${requestScope.comment.objId }"></textarea>
			<input type="hidden" name="objId" value="${requestScope.comment.objId }"/>
			<input type="hidden" name="type" value="${requestScope.comment.type }"/>
			<input type="button" class="btn-common" id="addBtn" value="Submit"/>
		</form>
	</div>
	</c:if>
	<div class="bar_title">Comment List</div>
	<div class="pl10" style="padding-bottom:40px;">
			<div class="list">
			<c:choose>
			<c:when test="${requestScope.pageBean.recordList==''||requestScope.pageBean.recordList==null||empty requestScope.pageBean.recordList }">
			<div style="height:100px;top:500px;left:40%;text-align: center;">
			<font size="5" color="#A8A8A8">亲，还没有人回复哦~</font>
			</div>
			</c:when>
			<c:otherwise>
			<c:forEach var="s" varStatus="st" items="${requestScope.pageBean.recordList }">
				<div class="list-item pt10 pb10" <c:if test="${st.index!=0 }"> style="border-top:1px dashed #eee;" </c:if>>
					<div class="roundImg">
						<img class="getFieldValueById" id="${s.creator }" tableName="humres" fieldName="image"/>
						<div class="cover"></div>
						<div class="pl15 mt10">floor ${st.index+1 }</div>
					</div>
					<div class="fl pl10" style="width:90%">
						<div>
							<span class="getFieldNameById" id="${s.creator }">${s.creatorName }</span> published on : ${s.createtime }
							&nbsp;&nbsp;
							<a href="javascript:void(0);" toUserId="${s.creator }" id="${s.id }" title="回复" class="reply-topic"></a>
							<c:if test="${user eq creator  }">
							<a href="javascript:void(0);"  id="${s.id }" title="删除" class="del-topic"></a> 
							</c:if>
						</div> 
						<div class="pt10 pl10 mb20" >
							${s.content }
						</div>
					</div>
					<div class="clear"></div>
					<div class="mt10" style="background:#f7f8fa;margin-left:70px;">
						<c:forEach var="c" varStatus="ct" items="${s.childList }">
								<div class="list-item mt20 pt10 pl10">
									<div class="roundImg">
										<img class="getFieldValueById" id="${c.creator }" tableName="humres" fieldName="image"/>
										<div class="cover"></div>
									</div>
									<div class="fl pl10" style="width:90%">
										<div>
											<span class="getFieldNameById" id="${c.creator }">${c.creatorName }</span> ${c.createtime }
											&nbsp;&nbsp;
											<a href="javascript:void(0);"  clickId="${c.id }"  id="${c.id }" toUserId="${c.creator }" title="回复" class="reply-topic"></a>
											<c:if test="${user eq creator  }">
											<a href="javascript:void(0);"  id="${c.id }" title="删除" class="del-topic"></a>
											</c:if>
										</div> 
										<div class="pt10 pl10">
											${c.content }
										</div>
									</div>
									<div class="clear"></div>
									
									<div class="mt10" style="margin-left:40px;">
										<c:forEach var="k" varStatus="kt" items="${c.childList }">
											<div class="list-item">
												<div class="roundImg">
													<img class="getFieldValueById" id="${k.creator }" tableName="humres" fieldName="image"/>
													<div class="cover"></div>
												</div>
												<div class="fl pl10" style="width:90%">
													<div>
														<span class="getFieldNameById name-topic"  id="${k.creator }">${k.creatorName }</span> 回复 <span class="getFieldNameById name-topic"  id="${k.toUserId }">${k.toUserName }</span> ${k.createtime }
														&nbsp;&nbsp;
														<a href="javascript:void(0);" clickId="${k.id }" id="${c.id }" toUserId="${k.creator }" title="回复" class="reply-topic"></a>
														<c:if test="${user eq creator  }">
														<a href="javascript:void(0);"  id="${k.id }" title="删除" class="del-topic"></a> 
														</c:if>
													</div> 
													<div class="pt10 pl10">
														${k.content }
													</div>
												</div>
												<div class="clear"></div>
											</div>
										</c:forEach>
									</div>
								</div>
								
								<div class="pt10 hide editor_div" id="editor_div_${c.id }">
									<div class="showInfo" style="color:red"></div>
									<form action="<%=basePath%>comment/add.do">
										<textarea id="content_${c.id }" style="width:98%" name="content" class="rich_editor"></textarea>
										<input type="hidden" name="objId" value="${requestScope.comment.objId }" />
										<input type="hidden" name="type" value="${requestScope.comment.type}" />
										<input type="hidden" name="clickId" value="" />
										<input type="hidden" name="pid" value="" />
										<input type="hidden" name="toUserId" value="" />
										<input type="button"  class="btn addBtn btn-add mt10 mb10" value="回复"/>
									</form>
								</div>
						</c:forEach>
					</div>
					<div class="pt10 hide editor_div" id="editor_div_${s.id }">
						<div class="showInfo" style="color:red"></div>
						<form action="<%=basePath%>comment/add.do">
							<textarea id="content_${s.id }" style="width:98%" name="content" class="rich_editor"></textarea>
							<input type="hidden" name="objId" value="${requestScope.comment.objId }" />
							<input type="hidden" name="type" value="${requestScope.comment.type}" />
							<input type="hidden" name="pid" value="" />
							<input type="button"  class="btn addBtn btn-add mt10 mb10" value="回复"/>
						</form>
					</div>
				</div>
				</c:forEach>
			</c:otherwise>
			</c:choose>
			</div>
			<%--
			<form name="VelcroForm" id="VelcroForm" action="" method="post">
			<input type="hidden" id="${comment.objId }">
			<input type="hidden" name="objId" value="${requestScope.comment.objId }" />
			<input type="hidden" name="type" value="${requestScope.comment.type}" />
			<%@ include file="/kms/public/pagination.jsp"%>
			</form>
			 --%>
		</div>
  </body>
</html>
