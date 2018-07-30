<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath %>">
    <title></title>
    <%@include file="/public/common.jsp" %>
    <link href="<%=basePath %>css/navi-dynamicTable.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
    </style>
    <script type="text/javascript" src="<%=basePath %>js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/datepicker/My97DatePicker/WdatePicker.js"></script>
    <!-- jquery.validate -->
    <script type="text/javascript" src="<%=basePath %>js/jqValidate/jquery.metadata.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jqValidate/jquery.validate.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-validate.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-validatePlugin.js"></script>
    <!-- kindeditor -->
    <link rel="stylesheet" href="<%=basePath%>js/kindeditor4.1.10/themes/default/default.css" />
	<link rel="stylesheet" href="<%=basePath%>js/kindeditor4.1.10/plugins/code/prettify.css" />
	<script src="<%=basePath%>js/kindeditor4.1.10/kindeditor-min.js"></script>
	<script src="<%=basePath%>js/kindeditor4.1.10/addRichEditor.js"></script>
	<script src="<%=basePath%>js/kindeditor4.1.10/lang/zh_CN.js"></script>
	<script src="<%=basePath%>js/kindeditor4.1.10/plugins/code/prettify.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/navi/navi-getFieldNameById.js"></script>
	
	<script type="text/javascript" src="<%=basePath %>js/layer/layer_forLowerJq.js"></script>
    <link  rel="stylesheet" href="<%=basePath %>js/layer/skin/layer.css" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>js/navi/navi-layer.js"></script>
     <script type="text/javascript" src="<%=basePath %>js/navi/navi-addOrEdit.js"></script>
	
    <script type="text/javascript">
    $(function(){
    	/**重新设置明细表的id*/
    	$(".layoutTable").each(function(){
    		var table=$(this);
    		var tableId=table.attr("id");
    		if(tableId.indexOf="detailTable_"!=-1){
    			var rows=$("tr",table);
	    		var names=getRowInputNameArr($("td",rows.eq(1)));
				resetRowsId(tableId,rows,names);
    		}
    	});
    	
    	
    	$(".rich_editor").each(function(){
    		var id=$(this).attr("id");
    		addRichEditor("<%=basePath %>",id);
    	});
    	$("form").validate({
    		submitHandler:formSubmit,
    		invalidHandler: function(form, validator) {  //不通过回调 
       			return false; 
          	} 
    		
    	});
    	$(".getFieldNameById").naviGetFieldNameById({idKey:"dataKey"});
    	$(".popWin").naviLayer({w:"800px",h:"450px",urlAttr:"popUrl"});
    	
    	
    });
    /*传递数据的json格式
    {
    layoutId: 4028d0814a4176c7014a41786a2c0000,
    tables: [
        {
            id: 402881e74a1011c5014a101b63e30000,
            tableType: mainTable,
            data: [
                {
                    createdate: 2014-12-09,
                    creator: 402881e7474e3f2401474e45a6360003,
                    creator_span: 赵云儿,
                    budgetDate: 2014-12-16
                }
            ]
        },
        {
            id: 402881e74a1011c5014a10204df50004,
            tableType: detailTable,
            data: [
                {
                    budgetProject: 402881e74a1028de014a102badc40002,
                    budgetProject_span: 买衣服,
                    money: 123,
                    consumer: 402881e7474e3f2401474e45a6360003,
                    consumer_span: 赵云儿,
                    createdate: 2014-12-15
                },
                {
                    budgetProject: 402881e74a1028de014a102badd30003,
                    budgetProject_span: 买油,
                    money: 234,
                    consumer: 402881eb499329340149933006f20004,
                    consumer_span: 唐政伟,
                    createdate: 2014-12-30
                }
            ]
        }
    ]
}
*/
	
    function formSubmit(){
    	var tables=$(".layoutTable");
    	var data="{\"layoutId\":\""+$("#formLayoutId").val()+"\",\"tables\":[";
    	tables.each(function(){
    		var table=$(this);
    		var tableIdInfo=table.attr("id").split("_");
    		var tableType=tableIdInfo[0];
    		var tableId=tableIdInfo[1];
    		var tableObj="{\"id\":\""+tableId+"\",\"tableType\":\""+tableType+"\",\"data\":[";
    		if(tableType=="mainTable"){
    			tableObj+="{";
    			$("input,textarea,select",table).each(function(){
	    			var input=$(this);
	    			var inputValue=input.val();
	    			inputValue=inputValue.replace(/\"/ig,"&quot;");
	    			if(inputValue.substr(inputValue.length-1,1)==","){
	    				inputValue=inputValue.substring(0,inputValue.length-1);
	    			}
	  				if(input.attr("name")&&input.attr("name").indexOf("checkList_")==-1&&input.attr("id").indexOf("checkAll_")==-1){
	  					tableObj+="\""+input.attr("name")+"\":\""+inputValue+"\",";
	  				}  			
	    		});
	    		if(tableObj.substr(tableObj.length-1,1)==","){
	    			tableObj=tableObj.substring(0,tableObj.length-1);
	    		}
	    		tableObj+="}";
    		}else if("detailTable"==tableType){
    			$("tr",table).not(":eq(0)").each(function(){
    				tableObj+="{";
	    			$("input,textarea,select",$(this)).each(function(){
		    			var input=$(this);
		    			var inputValue=input.val();
		    			inputValue=inputValue.replace(/\"/ig,"&quot;");
		    			if(inputValue.substr(inputValue.length-1,1)==","){
		    				inputValue=inputValue.substring(0,inputValue.length-1);
		    			}
		  				if(input.attr("name")&&input.attr("name").indexOf("checkList_")==-1&&input.attr("id").indexOf("checkAll_")==-1){
		  					tableObj+="\""+input.attr("name")+"\":\""+inputValue+"\",";
		  				}  			
		    		});
		    		if(tableObj.substr(tableObj.length-1,1)==","){
    					tableObj=tableObj.substring(0,tableObj.length-1);
    				}
		    		tableObj+="},";
    			});
    			if(tableObj.substr(tableObj.length-1,1)==","){
    				tableObj=tableObj.substring(0,tableObj.length-1);
    			}
    		}
    		tableObj+="]}";
    		data+=tableObj+",";
    	});
    	if(data.substr(data.length-1,1)==","){
    		data=data.substring(0,data.length-1);
    	}
    	data+="]}";
    	var url=$("#NaviForm").attr("action");
    	if(beforeSubmitHandler){
    		beforeSubmitHandler();
    	}
    	alert(data);
   		$.post(url,{data:data},function(result){
   			sysAlert(result.msg);
   			if(result.isOk==1){
   				location.href="<%=basePath%>formLayout/viewDataUI.do?id=${requestScope.formLayout.id }&formDataId="+result.id;
   			}
   		},"json");
    	//$("#NaviForm").submit();
    }
    function finishUpload(attachId,attachName,listenerId){
    	var ids=$("#"+listenerId).val();
    	ids+=attachId+",";
    	$("#"+listenerId).val(ids);
    	var fileInputName=$("#"+listenerId).attr("name");
    	$("#"+listenerId+"_upload_div").append("<p id='"+attachId+"_delete'><span>"+attachName+"</span><a href='javascript:deleteAttach(\""+attachId+"\",\""+fileInputName+"\",this)' class='delete'></a></p>");
    }
    
    function deleteAttach(attachId,fileInputName,el){
    	if(confirm("您确定要删除吗？")){
	    	$.post("<%=basePath%>attach/delete.do",{id:attachId},function(data){
	    		if(data=="ok"){
	    			var td=$(el).parents("td")[0];
	    			var ids=$("input[name='"+fileInputName+"']",td).val();
	    			ids=ids.replace(attachId+",","");
	    			$("input[name='"+fileInputName+"']",td).val(ids);
	    			$("p[id='"+attachId+"_delete']",td).css("display","none");
	    		}
	    	});
    	}
    }
    
    function disableSubmit(){
    	$(".toolbar .btn").attr("disabled",true);
    }
    function enableSubmit(){
    	$(".toolbar .btn").attr("disabled",false);
    }
	/**
	增加行
	*/
	function addRow(tableId){
		var table=$("#"+tableId);
		var rows=$("tr",table);
		var currentLen=rows.length;
		var rowHtml=$("<tr></tr>");
		if(currentLen>=2){
	    	var names=getRowInputNameArr($("td",rows.eq(1)));
	    	var tmpRow=rows.eq(1).clone();
	    	$("div.ke-container",tmpRow).each(function(){
	    		$(this).remove();
	    	});
			rowHtml.append(tmpRow.get(0).innerHTML);
			resetOneRowId(tableId,names, rowHtml, true,currentLen);
		}
		table.append(rowHtml);
		$("textarea.rich_editor",rowHtml).each(function(){
			$(this).css("display","block");
			addRichEditor("<%=basePath %>",$(this).attr("id"));
		});
		$("div.upload_div",rowHtml).each(function(){
			$(this).html("");
		});
		$(".popWin").naviLayer({w:"800px",h:"450px",urlAttr:"popUrl"});
	}
	/**
	获取行里的input的name
	*/
	function getRowInputNameArr(tds){
		var names=[];
		tds.each(function(){
			var children=$(this).children();
			children.each(function(){
				var obj=$(this);
				var tagName=obj.get(0).tagName;
				if(tagName=="INPUT"||tagName=="TEXTAREA"||tagName=="SELECT"){
					names.push(obj.attr("name"));
				}
			});
		});
		return names;
	}
	/**
	重置一行tr里的所有id
	*/
	function resetOneRowId(tableId,names,tr,cleanValue,index){
		var tableId=tableId.replace("detailTable_","");
		var attNameArr=["id","href","src","onchange","onclick","onfocus","onblur","blur","idspan","namespan"];
		var tds=$("td",tr);
		tds.each(function(){
			var children=$(this).children();
			children.each(function(){
				var obj=$(this);
				if(cleanValue){
					if(obj.val()){
						obj.val("");
					}
					if(obj.prop("checked")){
						obj.prop("checked",false);
					}
				}
				for(var i=0;i<names.length;i++){
					var reg=new RegExp("(\\w{32}_"+names[i]+"_)(\\d+)","ig");
					var regFirst=new RegExp("(\\w{32}_"+names[i]+")","ig");
					for(var j=0;j<attNameArr.length;j++){
						var attValue=obj.attr(attNameArr[j])?obj.attr(attNameArr[j]):"";
						if(attValue!=""){
							if(reg.test(attValue)){
								obj.attr(attNameArr[j],attValue.replace(reg,"$1"+index));
							}else if(regFirst.test(attValue)){
								obj.attr(attNameArr[j],attValue.replace(regFirst,"$1_1"));
							}
						}
					}
				}
			});
		});
	}
	/**
	重置所有行里元素的id
	*/
	function resetRowsId(tableId,trs,names){
		if(!names||names.length<=0){
			names=getRowInputNameArr($("td",trs.eq(1)));
		}
		trs.each(function(index){
			resetOneRowId(tableId,names,$(this),false,index);
		});
	}
	/**
	删除行
	*/
	function deleteRow(tableId,chkList){
		var trs=$("#"+tableId+" tr");
		var selectRow=$("#"+tableId+" input[name='"+chkList+"'][type='checkbox']:checked");
		if((trs.length-2)<selectRow.length){
			alert("对不起，不能删除所有的行！");
			return;
		}
		if(selectRow.length<=0){
			alert("请选择要删除的行!");
			return;
		}
		selectRow.each(function(){
			$(this).parents("tr").remove();
		});
		resetRowsId(tableId,$("#"+tableId+" tr"));
		
		$(".popWin").naviLayer({w:"800px",h:"450px",urlAttr:"popUrl"});
	}
	/**
	选取所有
	*/
	function selectAll(el,tableId,chkList){
		var obj=$(el);
		if(obj.prop("checked")){
			$("#"+tableId+" input[name='"+chkList+"'][type='checkbox']").prop("checked",true);
		}else{
			$("#"+tableId+" input[name='"+chkList+"'][type='checkbox']").prop("checked",false);
		}
	}
	/**
	复制行
	*/
	function copyRow(tableId,chkList){
		var table=$("#"+tableId);
		var trs=$("tr",table);
		var selectRow=$("#"+tableId+" input[name='"+chkList+"'][type='checkbox']:checked").parents("tr");
		if(selectRow.length<=0){
			alert("请选择要复制的行!");
			return;
		}
		var names=getRowInputNameArr($("td",trs.eq(1)));
		resetRowsId(tableId,trs,names);
		var trLen=trs.length;
		selectRow.each(function(){
			var oldRow=$(this);
			var tr=oldRow.clone();
			$("div.ke-container",tr).each(function(){
	    		$(this).remove();
	    	});
			$("input[type='checkbox'][name='"+chkList+"']",tr).attr("checked",false);
			table.append(tr);
			resetOneRowId(tableId,names,tr,false,trLen);
			$("input[type='hidden'][name='id']",tr).each(function(){
				$(this).val("");
			});
			/**附件*/
			$("input[type='hidden'][class='attachFile']",tr).each(function(){
				$(this).val("");
			});
			$("div.upload_div",tr).each(function(){
				$(this).html("");
			});
			$("textarea",tr).each(function(){
				var ta=$(this);
				var richText=$("textarea[name='"+ta.attr("name")+"']",oldRow).eq(0).val();
				ta.val(richText);
				if(ta.attr("class")&&ta.attr("class").indexOf("rich_editor")!=-1){
					ta.css("display","block");
					addRichEditor("<%=basePath %>",ta.attr("id"));
				}
			});
			trLen++;
		});
		$(".popWin").naviLayer({w:"800px",h:"450px",urlAttr:"popUrl"});
	}
    </script>
    <style type="text/css">
    	
    </style>
  </head>
 <body>
	<div id="warper">
		<div class="nav">
  			表单> ${requestScope.formLayout.objname}
  		</div>
		<form id="NaviForm" method="post" name="NaviForm" action="<%=basePath %>formData/saveFormData.do?formLayoutId=${requestScope.formLayout.id }&formDataId=${requestScope.formDataId }">
	  		<div class="toolbar">
	  			<button class="btn" type="submit" >保存(S)</button>
	  		</div>
	  		<div class="content">
				${requestScope.viewHtml }
			</div>
		</form>
	</div>	               
</body>
</html>