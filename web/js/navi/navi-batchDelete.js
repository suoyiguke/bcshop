/**
 * 批量删除
 * author 邓海超
 */
(function($) {
	$.fn.naviBatchDelete = function(options) {
		var defaults = {
			url:"",
			chkListCls:"chkList",
			afterDelFn:function(data){
				if(data.isOk==1){
					sysAlert(data.msg);
					location.reload();
				}else{
					sysAlert(data.msg);
				}
			}
		};
		var opts = $.extend({}, defaults, options);
		return this.each(function() {
			var delBtn = $(this);
			delBtn.click(function(){
				if(opts.url==""){
					sysAlert("没有配置批量删除服务器地址！");
					return;
				}
				var chkList=$("input[type='checkbox'][class='"+opts.chkListCls+"']");
				var ids="";
				chkList.each(function(){
					if($(this).prop("checked")){
						ids+=$(this).attr("id")+",";
					}
				});
				if(ids==""){
					sysAlert("请选择要删除的项");
					return;
				}
				if(ids.indexOf(",")!=-1){
					ids=ids.substring(0,ids.lastIndexOf(","));
				}
				if(confirm("您确定要删除?")){
					$.post(opts.url,{ids:ids},function(data){
						opts.afterDelFn(data);
					},"json");
				}
			});
		});
	};
})(jQuery);