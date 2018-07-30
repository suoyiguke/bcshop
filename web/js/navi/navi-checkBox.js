/**
 * checkbox
 * 赋值
 * author 邓海超
 */
(function($) {
	$.fn.naviCheckBox= function(options) {
		var defaults = {
			checkedVal:'1',
			uncheckedVal:'0'
		};
		var opts = $.extend({}, defaults, options);
		return this.each(function() {
			var obj=$(this);
			obj.click(function(){
				var val=obj.prop("checked")?opts.checkedVal:opts.uncheckedVal;
				obj.next("input[type='hidden']").val(val);
			});
		});
	};
})(jQuery);