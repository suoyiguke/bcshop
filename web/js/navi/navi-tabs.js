/**
 * navi-tab切换
 * author dhc
 */
(function($) {
	$.fn.naviTabs = function(options) {
		var defaults = {
			contentFrame:$(this).find("iframe"),
			frameMinHeight:450,
			tabActive:0
		};
		var opts = $.extend({}, defaults, options);
		var naviTabDiv = $(this);
		var lis = $("ul li", naviTabDiv);
		//内部方法
		function setActive(index){
			lis.removeClass("active");
			$(lis[index]).addClass("active");
			opts.contentFrame.attr("src", $(lis[index]).find("a").attr("url"));
		};
		
		function resizeFrameHeight(frame,minFrameHeight){
			frame.height(0);
			var height = frame.contents().height() + 10;
			height=height < minFrameHeight ? minFrameHeight : height;
			frame.height(height);
			/*if($(window.parent.document).find("iframe").length>0){
				$(window.parent.document).find("iframe").height(height+50);
			}
			if($(window.parent.parent.document).find("iframe").length>0){
				$(window.parent.parent.document).find("iframe").height(height);
			}*/
		}
		
		return this.each(function() {
			var minFrameHeight=opts.frameMinHeight;
			var tabIndex=opts.tabActive>lis.length?lis.length:opts.tabActive;
			setActive(tabIndex);
			opts.contentFrame.load(function() {
				resizeFrameHeight($(this),minFrameHeight);
			});
			lis.each(function(index) {
				$(this).click(function() {
					lis.removeClass("active");
					$(this).addClass("active");
					opts.contentFrame.attr("src", $(this).find("a").attr("url"));
				});
			});
		});
	};
})(jQuery);