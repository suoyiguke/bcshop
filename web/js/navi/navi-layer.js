/**
 * 弹出层
 * author 邓海超
 */
var naviLayer = {
	idspan : '',
	namespan: '',
	doAfterCall:function(id,name){},
	close : function() {
		this.idspan = '';
		this.namespan = '';
		layer.closeAll();
	},
	clear : function() {
		var spanid = '#' + this.idspan;
		var valueid = '#' + this.namespan;
		$(valueid).val('');
		if (this.isneed == "1") {
			if ($(spanid).is('input')) {
				$(spanid).val("");
				$(spanid).attr("class", "iptRed");
			} else {
				$(spanid).html("<span class='icoM iMNnu'></span>");
			}
		} else {
			if ($(spanid).is('input')) {
				$(spanid).val("");
				$(spanid).attr("class", "");
			} else {
				$(spanid).html("");
			}
		}
		this.close();
	},
	open : function(setting) {
		this.idspan = setting.idspan;
		this.namespan = setting.namespan;
		this.doAfterCall=setting.doAfterCall;
		layer.open({
			type : 2,
			shadeClose : true,// 点击背景关闭选择框
			shade : 0.1,// 背景阴影 
			//offset:setting.top,
			title : setting.title || '  ',
			maxmin : true, // 开启最大化最小化按钮
			area : [ setting.width , setting.height ],
			content : [ setting.url, setting.scroll || 'yes' ]
		// iframe的url，no代表不显示滚动条

		});
	},
	call : function(id, name) {
		var _id = id;
		var _name = name;
		var spanid = '#' + this.namespan;
		var valueid = '#' + this.idspan;
		if (_id == "") {
			this.clear();
		} else {
			$(valueid).val(_id);
			if ($(spanid).is('input')) {
				$(spanid).val(_name);
				$(spanid).attr("class", "");
			} else {
				$(spanid).html(_name);
			}
		}
		if(this.doAfterCall){
			this.doAfterCall(id, name);
		}
		this.close();
	}
};
(function($) {
	$.fn.naviLayer = function(options) {
		var defaults = {
			w:"600px",
			h:"280px",
			urlAttr:"url"
		};
		var opts = $.extend({}, defaults, options);
		return this.each(function() {
			var obj=$(this);
			obj.click(function(){
				if(obj.attr(opts.urlAttr)==""){
					alert("服务器地址为空，请设置请求的服务器地址!");
					return;
				}
				var windowWidth = document.documentElement.clientWidth;   
				var windowHeight = document.documentElement.clientHeight;  
				var idspan=obj.attr("idspan")?obj.attr("idspan"):"idspan";
				var namespan=obj.attr("namespan")?obj.attr("namespan"):"namespan";
				var w=obj.attr("w")?obj.attr("w"):opts.w;
				var h=obj.attr("h")?obj.attr("h"):opts.h;
				var t=(windowHeight-parseInt(h))/2+$(document).scrollTop();
				var l= (windowWidth-parseInt(w))/2;
				var title=obj.attr("title")?obj.attr("title"):"弹出层";
				naviLayer.open({title:title,width:w,height:h,top:t,left:l,idspan:idspan,namespan:namespan,url:obj.attr(opts.urlAttr)});
			});
		});
	};
})(jQuery);