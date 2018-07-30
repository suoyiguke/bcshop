<%@ page language="java" import="java.util.*"	contentType="text/html; charset=UTF-8"%>
<script src="<%=basePath %>js/navi/navi-pagination.js" type="text/javascript"></script>
<div style="text-align:center;margin-top:20px;">
<ul class="pagination pagination-lg">
	<%if(pageBean.getCurrentPage()==1){ %>
	<li class="disabled">
	<a href="javascript:void(0)"><i class="fa fa-angle-left">&laquo;</i></a>
	</li>
	<%}else{%>
	<li>
	<a href="javascript:prePage();"><i class="fa fa-angle-left">&laquo;</i></a>
	</li>
	<% } %>
	<%
    	for(int i=pageBean.getBeginPageIndex();i<=pageBean.getEndPageIndex();i++){ 
    		if(i==pageBean.getCurrentPage()){
    	%>
				<li class="active"><a href="javascript:void(0)"><%=i %></a></li>
	<%		}else{ %>
				<li><a href="javascript:goPage('<%=i %>')"><%=i %></a></li>
	<%		}
  		}
  	%>
  	
  	<%if(pageBean.getCurrentPage()==pageBean.getPageCount()){ %>
	<li class="disabled">
	<a href="javascript:void(0)"><i class="fa fa-angle-right">&raquo;</i></a>
	</li>
	<%}else{%>
	<li>
	<a href="javascript:nextPage();"><i class="fa fa-angle-right">&raquo;</i></a>
	</li>
	<% } %>
</ul>
	<input type="hidden" id="currentPage" name="currentPage" value="<%=pageBean.getCurrentPage() %>"/>
	<input type="hidden" id="pageSize" name="pageSize" value="<%=pageBean.getPageSize() %>"/>
</div>
