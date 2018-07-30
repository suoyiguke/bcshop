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

        var index = localStorage.getItem('itemIndex');
        localStorage.removeItem("itemIndex");
        console.log(index);
        if (index == null) {
            index = '';
        }


        // 工具栏
        var toolbar = [{
            id: 'button-search',
            text: '搜索',
            iconCls: 'icon-search',
            handler: doSearch
        }, {
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
            }, {
                field: 'id',
                title: '编号',
                width: 225,
                rowspan: 2,
                align: 'center',
                formatter: formatCellTooltip
            }, {
                field: 'itemid',
                title: '商品',
                width: 100,
                rowspan: 2,
                align: 'center',
                formatter: formatCellTooltip
            }, {
                field: 'flid',
                title: '规格名',
                width: 150,
                rowspan: 2,
                align: 'center',
                formatter: formatCellTooltip
            }, {
                field: 'value',
                title: '参数值',
                width: 100,
                rowspan: 2,
                align: 'center',
                formatter: formatCellTooltip
            }, {
                field: 'position',
                title: '排序',
                width: 100,
                rowspan: 2,
                align: 'center',
                formatter: formatCellTooltip
            }, {
                field: 'createdate',
                title: '创建时间',
                width: 150,
                rowspan: 2,
                align: 'center',
                formatter: formatCellTooltip
            }, {
                field: 'modifydate',
                title: '最近修改时间',
                width: 100,
                rowspan: 2,
                align: 'center',
                formatter: formatCellTooltip
            }]];
        $(function () {

            //隐藏域
            $('INPUT[name="itemid"]').val(index);


            //easyUI下拉框
            $('#objname').combobox({
                url: '/weixinmanager/getGgTitle.do?id=' + index,
                valueField: 'id',
                textField: 'objname'
            });


            // 初始化 datagrid
            // 创建grid
            $('#grid').datagrid({
                toolbar: toolbar,
                url: "/weixinmanager/getGgcsValue.do?id=" + index,
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
                striped: true,
                //加载成功之后，选定并获取首行数据
                onLoadSuccess: function (data) {


                    $('td[field="imgfile"]').mousemove(function () {
                        if ($(this).attr('rowspan')) {
                            return;
                        }
                        var self = this;
                        var content = $(this).children('div').children('img').attr('src');
                        console.log(content);
                        var img = '<img class="fdimg" width="200px" height="200px" border="0" src="' + content + '"/>'
                        $.pt({
                            position: 'b',     //提示框相对目标元素位置 t=top,b=bottom,r=right,l=left
                            align: 't',        //提示框与目标元素的对齐方式，自动调节箭头显示位置，指向目标元素中间位置
                            //c=center, t=top, b=bottom, l=left, r=right
                            //[postion=t|b时，align=l|r有效][position=t|b时，align=t|d有效]
                            arrow: true,       //是否显示箭头
                            content: img,       //内容
                            width: 200,        //宽度
                            hight: 200,     //高度
                            target: self,      //目标元素
                            autoClose: true,   //是否自动关闭
                            time: 2000,        //自动关闭延时时长
                            leaveClose: true, //提示框失去焦点后关闭
                            close: null        //关闭回调函数
                        })
                    });

                }


            });


            $("#searchWindow").window({
                minimizable: false,
                maximizable: false,
                closed: true,
                modal: true,
                title: "弹出窗",
                width: 400,
                height: 200


            });


            $('.addParam').click(function () {
                alert(123);
            });

            //表单提交
            $('#btn').click(function () {

                $('#ggcs').form('submit', {
                    url: '/weixinmanager/addANDeditItemGgcs.do',
                    onSubmit: function () {
                        var isValid = $(this).form('validate');
                        return isValid;	// 返回false终止表单提交
                    },
                    success: function (data) {
                        var data = eval('(' + data + ')');  // change the JSON string to javascript object
                        sysAlert(data.msg);
                        $('#ggcs').form('clear');

                        $('#searchWindow').window('close');
                        $("#grid").datagrid("load");

                        $('#btn').attr('data-options',"iconCls:'icon-edit'");

                    }
                });


            });

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
                //隐藏域
                $('INPUT[name="id"]').val(rows[0].id);

                $("#searchWindow").window("open");
                //将窗口绝对居中
                $('#searchWindow').window('center');

                $('#ggcs').form('load','/weixinmanager/getAddGgcsFormValue.do?id='+rows[0].id); // 读取表单的URL
            }
        }

        function doDelete() {
            //获取数据表格中所有选中的行，返回数组对象
            var rows = $("#grid").datagrid("getChecked");
            console.log(rows)
            if (rows.length == 0) {
                //没有选中记录，弹出提示
                $.messager.alert("提示信息", "请选择记录！", "warning");
                return;
            }//选择多个
            var array = new Array();
            for (var i = 0; i < rows.length; i++) {
                var staff = rows[i];//json对象
                var id = staff.id;
                array.push(id);
            }
            var ids = array.join(",");
            console.log(ids);
            $.messager.confirm("警告", "你确定要删除选中记录吗？", function (r) {
                if (r) {//确认删除
                    var data = {"id": ids};
                    $.get("/weixinmanager/deleteGgcsValue.do", data, function (message) {
                        alert(message.message);
                    }, 'json');
                    $("#grid").datagrid("load");//重新加载
                }

            });
        }

        function doSearch() {
            alert("搜索");
            $("#searchWindow").window("open");

        }

        function doRemove() {
            //获取数据表格中所有选中的行，返回数组对象
            var rows = $("#grid").datagrid("getSelections");
            if (rows.length == 0) {
                //没有选中记录，弹出提示
                $.messager.alert("提示信息", "请选择需要删除的记录！", "warning");
                return;
            }//选择多个
            var array = new Array();
            for (var i = 0; i < rows.length; i++) {
                var staff = rows[i];//json对象
                var id = staff.id;
                array.push(id);
            }
            var ids = array.join(",");
            $.messager.confirm("警告", "你确定要删除选中记录吗？", function (r) {
                if (r) {//确认删除
                    var data = {"id": ids};
                    $.post("/weixinmanager/deleteGgcsValue.do", data, function (data) {
                        sysAlert(data.msg);
                        $("#grid").datagrid("load");//重新加载

                    }, 'json');
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


        function sysAlert(msg) {
            layer.msg(msg);
        }


    </script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
    <table id="grid"></table>
</div>


<!-- 添加版块窗口 -->
<div class="easyui-window" id="searchWindow">
    <div>
        <form id="ggcs">
            <table class="table-edit" width="80%" align="center">
                <tr class="name">
                    <td colspan="2">商品规格参数</td>
                </tr>
                <tr>
                    <td>规格标题</td>
                    <input type="hidden" name="itemid"/>
                    <input type="hidden" name="id"/>


                    <td>


                        <input id="objname" name="flid" value="== 请选择规格标题 ==">
                    </td>
                </tr>
                <tr>
                    <td>规格值</td>
                    <td><input type="text" name="value"/>

                    </td>
                </tr>
                <tr>
                    <td>排序</td>
                    <td><input type="text" name="position"/>

                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

</body>
</html>