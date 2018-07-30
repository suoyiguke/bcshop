var K=window.KindEditor;
var editors={};
function addRichEditor(basePath,id){
	var editor=K.create('#'+id, {
		cssPath : basePath+'js/kindeditor4.1.10/plugins/code/prettify.css',
		uploadJson : basePath+'attach/uploadImg.do',
		afterBlur: function () { 
			this.sync(); 
			self.edit = edit = this; 
		},
		 //得到焦点事件
        afterFocus: function () {
            self.edit = edit = this; 
            /*var strIndex = self.edit.html().indexOf("@我也说一句"); 
            if (strIndex != -1) { 
            	self.edit.html(self.edit.html().replace("@我也说一句", ""));
         	}*/
        }
	});
	editors[id]=editor;
}

function getEditor(id){
	for(key in editors){
		if(key==id){
			return editors[key];
		}
	}
}