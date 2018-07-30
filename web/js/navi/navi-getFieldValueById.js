/**
 * 根据id获取对应字段的值
 * author 邓海超
 */

(function($) {
	$.fn.getFieldValueById = function(options) {
		var defaults = {
			idKey:"id",
			fieldNameKey:"fieldName",
			tableNameKey:"tableName",
			basePath:""
		};
		var opts = $.extend({}, defaults, options);
		return this.each(function() {
			var obj = $(this);
			if(obj.attr("isLoad")=="1"){
				return;
			}
			var id=obj.attr(opts.idKey);
			var fieldName=obj.attr(opts.fieldNameKey);
			var tableName=obj.attr(opts.tableNameKey);
			var sql=obj.attr("sql");
			$.post(opts.basePath+"data/getFieldValueById.do",{id:id,fieldName:fieldName,tableName:tableName,sql:sql},function(data){
				if(data.isOk=="1"){
					var tag=obj.get(0).tagName.toLowerCase();
					if(tag=="input"){
						obj.val(data.msg);
					}else if(tag=="img"){
						if(data.msg&&data.msg.length==32){
							obj.attr("src",opts.basePath+"attach/showPicture.do?id="+data.msg);
						}else{
							obj.attr("src",opts.basePath+"imgs/user.png");
						}
					}else{
						obj.html(data.msg);
					}
					obj.attr("isLoad","1");
				}else{
					alert(data.msg);
				}
			},"json");
		});
	};
})(jQuery);