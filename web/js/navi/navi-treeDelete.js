/**
 * 删除
 * author 邓海超
 */
(function($) {
	$.fn.treeDelete = function(options) {
		var defaults = {
			url:"",
			afterDelFn:function(data){
				 sysAlert(data.msg);
				if(data.isOk==1){
					if(data.url){
						window.parent.selectParent(data.id);
						window.parent.removeNode(data.id);
						location.href=webPath+data.url;
					}else{
						location.reload();
					}
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
				if(confirm("您确定要删除?")){
					var ids=$(this).attr("id");
					$.post(opts.url,{ids:ids},function(data){
						opts.afterDelFn(data);
					},"json");
				}
			});
		});
	};
})(jQuery);