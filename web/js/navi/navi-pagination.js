/**
 * 上一页
 */
function prePage(){
	var currentPage = $("#currentPage");
	var oValue = currentPage.val();
	oValue = oValue*1 - 1;
	currentPage.val(oValue);
	var form =$("#NaviForm");
    form.submit();
}
/**
 * 更改每页显示条数
 * @param pageSize
 */
function changePageSize(pageSize){
	var size = $("#pageSize");
	var oValue = pageSize*1;
	size.val(oValue);
	var form =$("#NaviForm");
    form.submit();
}
/**
 * 下一页
 */
function nextPage(){
	var currentPage = $("#currentPage");
	var oValue = currentPage.val();
	oValue = oValue*1 + 1;
	currentPage.val(oValue);
	var form =$("#NaviForm");
    form.submit();
}
/**
 * 跳转到pageNum页
 * @param pageNum
 */
function goPage(pageNum){
	$("#currentPage").val(pageNum);
	var form = $("#NaviForm");
	form.submit();
}