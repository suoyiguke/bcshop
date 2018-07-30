<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <style>

        .imgfilet {
            position: relative;
            top: 3px;
        }
    </style>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>

    <link rel="stylesheet" type="text/css" href="/css/my.css">
    <link rel="stylesheet" type="text/css" href="/js/easyui/1.3.4/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/js/easyui/1.3.4/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="/css/default.css">
    <script type="text/javascript" src="/js/easyui/1.3.4/jquery.min.js"></script>
    <script type="text/javascript" src="/js/easyui/1.3.4/jquery.easyui.min.js"></script>


    <link href="/plugin/top/tooltips.css" rel="stylesheet" id="skin">
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]--> <!-- Le fav and touch icons -->
    <script src="/plugin/top/holder.js"></script>
    <script src="/plugin/top/jquery.pure.tooltips.js"></script>

    <script src="/js/layer/layer_forLowerJq.js" type="application/javascript"></script>

    <script type="text/javascript">

        function sysAlert(msg){
            layer.msg(msg);
        }

        function cleanInput() {
            $('#ggform').find('input[name!="categoryId"],textarea').each(function(j,item){
                // 你要实现的业务逻辑
                $(item).val('');
            });
        }

        // 工具栏
        var toolbar = [{
            id: 'button-edit',
            text: '编辑',
            iconCls: 'icon-edit',
            handler: doEdit
        }, {
            id: 'button-add',
            text: '新增',
            iconCls: 'icon-add',
            handler: doAdd
        }, {
            id: 'button-remove',
            text: '删除',
            iconCls: 'icon-remove',
            handler: doRemove
        }];


        // 定义标题栏
        var columns = [[
            {
                checkbox: true
            },
            {
            field: 'id',
            title: '编号',
            width: 225,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }, {
            field: 'objname',
            title: '规格名',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }, {
            field: 'objdesc',
            title: '规格说明',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }, {
            field: 'categoryId',
            title: '属于的分类',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }]];


        $(function () {
            var index = localStorage.getItem('index');
            localStorage.removeItem("index");
             console.log(index);
             if(index == null){
               index = '';
             }
            // 初始化 datagrid
            // 创建grid
            $('#grid').datagrid({
                toolbar: toolbar,
                url: "/weixinmanager/getGgcsListByFlId.do?id="+index,
                method: "GET",
                columns: columns,
                onClickRow: onClickRow,
                onDblClickRow: doDblClickRow,
                pagination: true,
                idField: 'id',
                iconCls: 'icon-forward',
                fit: true,
                border: false,
                rownumbers: true,
                striped: true
            });


            $("#searchWindow").window({
                minimizable: false,
                maximizable: false,
                closed: true,
                modal: true,
                title: "微信小程序管理> 商品规格参数${(empty requestScope.product)?'添加':'修改'}",
                width: 500


            });

            $('#btn').click(function () {
                var p = $("#ggform").serializeJson();
                console.log(p)
                if( $('#id').val() != ""){//编辑

                    $.post('/weixinmanager/updateItemGg.do',p,function (data) {
                        sysAlert(data.msg);
                        $('#grid').datagrid('reload');//完成刷新  
                        $("#searchWindow").window("close");
                        $('#ggform').form('clear');
                        return;

                    },'json');

                }

                $.post('/weixinmanager/addItemGg.do',p,function (data) {
                    sysAlert(data.msg);
                    $('#grid').datagrid('reload');//完成刷新  
                    $("#searchWindow").window("close");
                    $('#ggform').form('clear');

                },'json');


            });


            $('#qc').click(function () {

                $('#ggform').form('clear');
            });


            $('input[name="categoryId"]').val(index);

        });
            // 双击
            function doDblClickRow(rowIndex, rowData) {

            }

            // 单击
            function onClickRow(rowIndex) {

            }

            function doAdd() {
                $("#searchWindow").window("open");
                //将窗口绝对居中
                $('#searchWindow').window('center');
            }

            function doEdit() {
                //获取数据表格中所有选中的行，返回数组对象
                var rows = $("#grid").datagrid("getSelections");
                console.log(rows)
                if(rows.length == 0){
                    //没有选中记录，弹出提示
                    $.messager.alert("提示信息","请选择需要修改的记录！","warning");
                }else if(rows.length != 1){
                    $.messager.alert("提示信息","一次只能修改一个记录！","warning");
                }else{
                    console.log(rows[0].id);
                    $("#searchWindow").window("open");
                    //将窗口绝对居中
                    $('#searchWindow').window('center');


                    $('#ggform').form('load','/weixinmanager/getSelectItem.do?id='+rows[0].id);	// 读取表单的URL
                }
            }

            function doDelete() {
                alert("删除用户");
                var ids = [];
                var items = $('#grid').datagrid('getSelections');
                for (var i = 0; i < items.length; i++) {
                    ids.push(items[i].id);
                }

                console.info(ids.join(","));

                $('#grid').datagrid('reload');
                $('#grid').datagrid('uncheckAll');
            }

            function doRemove() {
                //获取数据表格中所有选中的行，返回数组对象
                var rows = $("#grid").datagrid("getSelections");
                if (rows.length == 0) {
                    //没有选中记录，弹出提示
                    $.messager.alert("提示信息", "请选择用户！", "warning");
                    return;
                }//选择多个
                var array = new Array();
                for (var i = 0; i < rows.length; i++) {
                    var staff = rows[i];//json对象
                    var id = staff.id;
                    array.push(id);
                }
                var ids = array.join(",");
                console.log(array)
                $.messager.confirm("警告", "你确定要删除选中版块吗？", function (r) {
                    if (r) {//确认删除
                        var data = {"id": ids};
                        $.get("/weixinmanager/deleteSelectItems.do", data, function (data) {
                            sysAlert(data.msg);
                        }, 'json');
                        $("#grid").datagrid("load");//重新加载
                    }

                });
                

            }


            //格式化单元格提示信息
            function formatCellTooltip(value) {
                return "<span title='" + value + "'>" + value + "</span>";
            }


            function showImg(value, row, index) {


                //如下的写法太复杂了,注意只有数字才这么写.
                return '<img  class ="imgfilet" width="30px" height="30px" border="0" src="' + value + '"  onerror="this.src=\'/images/timg.jpg;this.onerror=null\'"' +
                    '' +
                    '/>';
            }

        //表单序列化
        $.fn.serializeJson=function(){
            var serializeObj={};
            var array=this.serializeArray();
            $(array).each(function(){
                if(serializeObj[this.name]){
                    if($.isArray(serializeObj[this.name])){
                        serializeObj[this.name].push(this.value);
                    }else{
                        serializeObj[this.name]=[serializeObj[this.name],this.value];
                    }
                }else{
                    serializeObj[this.name]=this.value;
                }
            });
            return serializeObj;
        };

    </script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
    <table id="grid"></table>
</div>


<!-- 添加版块窗口 -->
<div class="easyui-window" id="searchWindow">
    <div style="overflow:auto;padding:5px;" border="false">
        <form id="ggform">
            <table class="table-edit" width="80%" align="center">
                <tr class="name">
                    <td colspan="2">添加规格</td>
                    <input type="hidden" name="id"/>
                    <input type="hidden" name="categoryId"/>
                </tr>
                <tr>
                    <td>规格名</td>
                    <td><input type="text" name="objname"/></td>
                </tr>
                <tr>
                    <td>规格信息</td>
                    <td><textarea rows="10" cols="40" name="objdesc" id="textx"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>排列顺序</td>
                    <td><input type="text" name="position"/></td>
                </tr>


                <tr>
                    <td colspan="2">
                        <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">保存</a>
                        <a  id="qc" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">清除</a>

                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

</body>
</html>