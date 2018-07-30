/**
 * 树形控件
 * author 邓海超
 */
(function($) {
	$.fn.naviTree = function(options) {
		var defaults = {
			treeClick:null,
			basePath:""
		};
		var opts = $.extend({}, defaults, options);
		return this.each(function() {
			var tree = $(this);
			var type=tree.attr("type");
			var isAll=tree.attr("isAll");
			var pid=tree.attr("pid");
			var url=tree.attr("url");
			var checkbox=tree.attr("checkbox");
			tree.parent().append("<img class='loading' src='"+opts.basePath+"imgs/loading.gif'/>");
			tree.tree({
				url: opts.basePath+"/tree/jsonList.do?type="+type+"&isAll="+isAll+"&pid="+pid,
				lines:true,
				onBeforeExpand:function(node){
					tree.tree('options').url=opts.basePath+"/tree/jsonList.do?type="+type+"&isAll="+isAll+"&pid="+node.id;
				},
				cascadeCheck:false,
				checkbox:checkbox,
			    onClick: function(node){
			    	if(opts.treeClick){
			    		opts.treeClick(type,node);
			    	}else{
			    		window.open(url+node.id);
			    	}
			    },
			    onLoadSuccess:function(){
		    		tree.parent().find("img.loading").remove();
			    }
			});
		});
	};
})(jQuery);