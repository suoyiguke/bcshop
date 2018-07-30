/**
 * 全选，反选插件
 * author 邓海超
 */
(function($) {
	$.fn.naviCheckAll = function(options) {
		var defaults = {
			beforeClick:null,
			afterClick:null
		};
		var opts = $.extend({}, defaults, options);
		
		function loopCheck(chkAll,chkList) {
			var flag = true;
			chkList.each(function() {
				flag = flag && $(this).prop("checked");
			});
			if (flag&&chkList.length>0) {
				chkAll.prop("checked", true);
			} else {
				chkAll.prop("checked",false);
			}
		}
		return this.each(function() {
			var chkAll = $(this);
			var chkListCls=chkAll.attr("chkListCls");
			var chkList=$("input[type='checkbox'][class='"+chkListCls+"']");
			loopCheck(chkAll,chkList);
			chkList.click(function() {
				loopCheck(chkAll,chkList);
			});
			chkAll.click(function() {
				var ckList=$("input[type='checkbox'][class='"+chkListCls+"']");
				var isChecked = chkAll.prop("checked");
				if(opts.beforeClick!=null){
					(opts.beforeClick)(chkAll,ckList);
				}
				if (isChecked) {
					ckList.prop("checked", true);
					chkAll.prop("checked",true);
				} else {
					ckList.prop("checked",false);
					chkAll.prop("checked",false);
				}
				if(opts.afterClick!=null){
					(opts.afterClick)(chkAll,ckList);
				}
			});
		});
	};
})(jQuery);