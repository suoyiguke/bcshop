<%@ page language="java" import="java.util.*"	contentType="text/html; charset=UTF-8"%>
<script src="<%=basePath %>js/navi/navi-pagination.js" type="text/javascript"></script>
<div class="pagination">
		 <label title="首页" class="first <%if(pageBean.getCurrentPage()==1){out.print("first_disable");} %>"><a href="javascript:<%=pageBean.hasPrePage()?"goPage(1);":"void(0);" %>"></a></label>
         <label title="上一页" class="prev <%if(pageBean.getCurrentPage()==1){out.print("prev_disable");} %>"><a href="javascript:<%=pageBean.hasPrePage()?"prePage();":"void(0);" %>"></a></label>
         <%
         	for(int i=pageBean.getBeginPageIndex();i<=pageBean.getEndPageIndex();i++){ 
         		if(i==pageBean.getCurrentPage()){
         	%>
         	<label class="active"><a href="javascript:void(0);"><%=i %></a></label>
         	<%
         		}else{
         	%>
         	<label><a href="javascript:goPage('<%=i %>')"><%=i %></a></label>
         	<%
         		}
          } %>
         <label title="下一页" class="next <%if(pageBean.getCurrentPage()==pageBean.getPageCount()){out.print("next_disable");} %>"><a href="javascript:<%=pageBean.hasNextPage()?"nextPage();":"void(0);" %>"></a></label>
         <label title="尾页" class="last <%if(pageBean.getCurrentPage()==pageBean.getPageCount()){out.print("last_disable");} %>"><a href="javascript:<%=pageBean.hasNextPage()?"goPage("+pageBean.getPageCount()+");":"void(0);" %>"></a></label>
    <%=pageBean.getCurrentPage() %>/<%=pageBean.getPageCount() %>
    跳转
     <select onchange="javascript:goPage(this.value);">
       	<%for(int i=1;i<=pageBean.getPageCount();i++){ %>
           <option <%=pageBean.getCurrentPage()==i?"selected='selected'":"" %>value="<%=i %>"><%=i %></option>
        <%} %>
      </select>
	           每页显示记录
	     <select onchange="javascript:changePageSize(this.value);">
	     <option <%=pageBean.getPageSize()==1?"selected='selected'":"" %> value="1">1</option>
	         <option <%=pageBean.getPageSize()==10?"selected='selected'":"" %> value="10">10</option>
	         <option <%=pageBean.getPageSize()==15?"selected='selected'":"" %> value="15">15</option>
	         <option <%=pageBean.getPageSize()==20?"selected='selected'":"" %> value="20">20</option>
	         <option <%=pageBean.getPageSize()==25?"selected='selected'":"" %> value="25">25</option>
	         <option <%=pageBean.getPageSize()==50?"selected='selected'":"" %> value="50">50</option>
	     </select>
       共<%=pageBean.getRecordCount() %>条记录
	<input type="hidden" id="currentPage" name="currentPage" value="<%=pageBean.getCurrentPage() %>"/>
	<input type="hidden" id="pageSize" name="pageSize" value="<%=pageBean.getPageSize() %>"/>
</div>
