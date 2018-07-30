function disableSubmit() {
	$(".toolbar .btn").attr("disabled", true);
}
function enableSubmit() {
	$(".toolbar .btn").attr("disabled", false);
}
function finishUpload(attachId,attachName,listenerId,limitNum){
	if(limitNum==1){
		$("#"+listenerId).val(attachId);
		$("#"+listenerId+"UploadFrame").hide();
	}else{
		var ids=$("#"+listenerId).val();
		ids+=attachId+",";
		$("#"+listenerId).val(ids);
		if(ids.split(",").length>limitNum){
			$("#"+listenerId+"UploadFrame").hide();
		}
	}
	$("#"+listenerId+"_upload_div").append("<p id='"+attachId+"_delete'><span>"+attachName+"</span><a href='javascript:deleteAttach(\""+attachId+"\",\""+listenerId+"\",this)' class='delete'></a></p>");
}

function deleteAttach(attachId,listenerId,el){
	if(confirm("您确定要删除吗？")){
    	$.post("/attach/delete.do",{id:attachId},function(data){
    		if(data=="ok"){
    			var td=$(el).parents("td")[0];
    			var ids=$("input[name='"+listenerId+"']",td).val();
    			ids=ids.replace(attachId+",","");
    			ids=ids.replace(attachId,"");
    			$("input[name='"+listenerId+"']",td).val(ids);
    			$("p[id='"+attachId+"_delete']",td).css("display","none");
				$("#"+listenerId+"UploadFrame").show();
    		}
    	});
	}
}