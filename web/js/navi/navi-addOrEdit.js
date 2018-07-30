/**
 * 新增或者编辑
 */
function addOrEdit(){
	var naviForm=$("#NaviAddForm");
	var url=naviForm.attr("action");
	$.post(url,naviForm.serialize(),function(data){
        sysAlert('更新数据成功！');
		if(data.isOk==1){

            var obj=window.parent;
			obj.naviLayer.close();
			obj.location.reload();
		}
	},"json");
}
/**
 * 关闭弹出层
 */
function closePanel(){
	window.parent.naviLayer.close();
}
/**
 * 清空值
 * @param idspan
 * @param namespan
 */
function clearValue(idspan,namespan){
	$("#"+idspan).val('');
	$("#"+namespan).val('');
}