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
    <script type="text/javascript">
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
        var columns = [[{
            field: 'id',
            title: '编号',
            width: 225,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }, {
            field: 'username',
            title: '微信昵称',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }, {
            field: 'created',
            title: '创建时间',
            width: 150,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }, {
            field: 'updated',
            title: '最近修改时间',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }, {
            field: 'openId',
            title: 'openId',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }, {
            field: 'imgfile',
            title: '微信头像',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: showImg,
            nowrap: true
        }, {
            field: 'city',
            title: '城市',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }, {
            field: 'country',
            title: '国家',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }]];
        $(function () {
            // 初始化 datagrid
            // 创建grid
            $('#grid').datagrid({
                toolbar: toolbar,
                url: "/weixinmanager/getAllUser.do",
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
                onLoadSuccess:function(data){


                    $('td[field="imgfile"]').mousemove(function() {
                        if($(this).attr('rowspan')){
                            return;
                        }
                        var self = this;
                        var content = $(this).children('div').children('img').attr('src');
                        console.log(content );
                        var img = '<img class="fdimg" width="200px" height="200px" border="0" src="'+content+'"/>'
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
                title: "添加版块窗口 ",
                width: 500


            });

/*            $("#btn").click(function () {
                var name = $("input[name=name]").val();
                var description = $("#textx").val();
                var data = {"name": name, "description": description};
                $.post("addForum.action", data, function (message) {

                    $("#searchWindow").window("close");
                    alert(message.message);
                    $("#grid").datagrid("load");
                }, "json");
            });*/


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
            alert("编辑用户");
            var item = $('#grid').datagrid('getSelected');
            console.info(item);
            //window.location.href = "edit.html";
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

        function doSearch() {
            alert("搜索");
            $("#searchWindow").window("open");

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
                var id = staff.forumId;
                array.push(id);
            }
            var ids = array.join(",");
            $.messager.confirm("警告", "你确定要删除选中版块吗？", function (r) {
                if (r) {//确认删除
                    var data = {"forumIds": ids};
                    $.get("deleteForum.action", data, function (message) {
                        alert(message.message);
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



    </script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
    <table id="grid"></table>
</div>


<!-- 添加版块窗口 -->
<div class="easyui-window" id="searchWindow">
    <div style="overflow:auto;padding:5px;" border="false">
        <form>
            <table class="table-edit" width="80%" align="center">
                <tr class="name">
                    <td colspan="2">版块信息</td>
                </tr>
                <tr>
                    <td>版块名</td>
                    <td><input type="text" name="name"/></td>
                </tr>
                <tr>
                    <td>版块说明</td>
                    <td><textarea rows="20" cols="40" name="description" id="textx"></textarea>

                    </td>
                </tr>


                <tr>
                    <td colspan="2">
                        <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

</body>
</html>