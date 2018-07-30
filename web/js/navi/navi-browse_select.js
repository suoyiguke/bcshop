/**
 * 子窗口给父窗口赋值
 * @param idVal 父窗口显示id的值
 * @param nameVal 父窗口显示name的值
 */
function selectRefobj(idVal,nameVal){
	window.parent.naviLayer.call(idVal,nameVal);
}
/**
 * 清除选中的值
 */
function clearSelect(){
	window.parent.naviLayer.clear();
}