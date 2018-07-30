/**
 * jqgrid插件
 * haichao.deng
 */
(function($) {
	$.fn.naviGrid = function(options) {
		var grid=$(this);
		var defaults = {
			colNames:['id','操作'],
			colModel:[
				{name:"id",index:"id",width:75},
				{name:"act",index:"act",width:75,sortable:false,align:'center'}
			],
			postData:{},
			listId:"list",
			pagerId:"pager",
			url:'',
			altClass:'ui-tr-alt',
			rowNum:15,
			width:150,
			rowList:[10,15,20,30,50],
			jsonReader:{
		            root:'recordList',
		            repeatitems: false,
		            total: "pageCount",
					page: "currentPage",
					records: "recordCount"
		    },
		    sortname:'position',
		    sortorder: "desc",
		    gridComplete:function(){
				var ids = grid.jqGrid('getDataIDs');
				//var id = jQuery("#"+listId).jqGrid('getGridParam','selrow');//获取选中行
				for(var i=0;i < ids.length;i++){
					var cl = ids[i];
					var ret = grid.jqGrid('getRowData',cl);
					be = "<i class=\"fam-pencil\" style=\"cursor:pointer\" onclick=\"editRow('"+ret.id+"')\" title=\"编辑\"></i>&nbsp;"; 
					se = "<i class=\"fam-cross\" style=\"cursor:pointer\" onclick=\"deleteRow('"+ret.id+"')\" title=\"删除\"></i>&nbsp;"; 
					grid.jqGrid('setRowData',ids[i],{act:be+se});
				}	
			}
		};
		var opts = $.extend({}, defaults, options);
		return this.each(function() {
			grid.jqGrid({
			   	url:opts.url,
				datatype: "json",
				mtype:"post",
				//shrinkToFit: false,
				altRows:true,//隔行变色
				altclass:opts.altClass,//隔行变色样式
				rowNum:opts.rowNum,//初始化时显示的条数
			   	//rownumbers: true,//是否显示行号
				postData:opts.postData,
			   	width: opts.width,
				height: 'auto',
			   	colNames:opts.colNames,
			   	colModel:opts.colModel,
			   	rowList:opts.rowList,
			   	jsonReader:opts.jsonReader,
			   	pager: opts.pagerId,
			   	sortname: opts.sortname,
			    viewrecords: true,
			    multiselect: true,
			    sortorder: opts.sortorder,
			    gridComplete:opts.gridComplete,
			    shrinkToFit: false//设置冻结
			});
			grid.jqGrid('navGrid','',{edit:false,add:false,del:false,addtext:"添加",edittext:"编辑",deltext:"删除",searchtext:"搜索",refreshtext:"刷新"});
			grid.jqGrid('setFrozenColumns');//设置冻结
		});
	};
})(jQuery);
/**
 * 重新加载grid
 * @param el
 */
function reloadGrid(el){
	jQuery(el).jqGrid().trigger("reloadGrid");
}

function search(){
	var url=$("#NaviForm").attr("action");
	var postData={};
	$(".searchBar input").each(function(){
		var c=$(this);
		postData[c.attr("name")]=c.val();
	});
	jQuery("#list").jqGrid('setGridParam',
	{
		url:url,
		page:1,
		postData:postData
	}).trigger("reloadGrid");
}