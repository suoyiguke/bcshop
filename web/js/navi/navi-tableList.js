/**
 * navi-tableList
 * 自定义表格列表隔行换色，以及鼠标进入有背景色
 * author dhc
 */
(function($) {
	$.fn.naviTableList = function(options) {
		var defaults = {
		};
		var opts = $.extend({}, defaults, options);
		return this.each(function() {
			var tabList=$(this);
			tabList.find("tr:even").addClass("hover");
			tabList.find("tr").mouseover(function(){
    			$(this).addClass("on");
    		}).mouseout(function(){
    			$(this).removeClass("on");
    		});
		});
	};
})(jQuery);