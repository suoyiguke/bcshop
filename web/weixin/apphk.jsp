<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <style>

        .imgfilet{
            position: relative;
            top: 3px;
        }
    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="/css/my.css">
    <link rel="stylesheet" type="text/css" href="/js/easyui/1.3.4/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/js/easyui/1.3.4/themes/icon.css">
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
            checkbox: true,
        }, {
            field: 'id',
            title: '编号',
            width: 225,
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
        }, {
            field: 'objdesc',
            title: '说明',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }, {
            field: 'img',
            title: '滑块图片',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: showImg,
            nowrap: true
        }, {
            field: 'position',
            title: '显示顺序',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: formatCellTooltip
        }, {
            field: 'isActive',
            title: '是否发布',
            width: 100,
            rowspan: 2,
            align: 'center',
            formatter: function (data) {
                formatCellTooltip();

                if (data == 1){
                    return '已发布'
                }else{
                    return '未发布'
                }

            }
        }]];
        $(function () {
            // 初始化 datagrid
            // 创建grid
            $('#grid').datagrid({
                toolbar: toolbar,
                url: "/weixinmanager/getHk.do",
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


                    $('td[field="img"]').mousemove(function() {
                        if($(this).attr('rowspan')){
                            return;
                        }
                        var self = this;
                        var content = $(this).children('div').children('img').attr('src');
                        console.log(content );
                        var img = '<img class="fdimg"  width="200px" height="200px" border="0" src="'+content+'"/>'
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
                shadow:true,
                minimizable: true,
                maximizable: false,
                closed: true,
                modal: true,
                title: "弹出窗",
                width: 709,
                height: 380
            });




        });

        // 双击
        function doDblClickRow(rowIndex, rowData) {
            var items = $('#grid').datagrid('selectRow', rowIndex);
            doView();
        }

        // 单击
        function onClickRow(rowIndex) {

        }

        //添加
        function doAdd() {

            $("#rightIframe").attr('src',"/weixin/hk_addUI.jsp");
            $("#searchWindow").window("open");
            $('#searchWindow').window('center');
        }

        /*修改*/
        function doEdit() {
            //获取数据表格中所有选中的行，返回数组对象
            var rows = $("#grid").datagrid("getSelections");
            console.log(rows)
            if (rows.length == 0) {
                //没有选中记录，弹出提示
                $.messager.alert("提示信息", "请选择需要修改的记录！", "warning");
            } else if (rows.length != 1) {
                $.messager.alert("提示信息", "一次只能修改一个记录！", "warning");
            } else {
                console.log(rows[0].id);
                $("#rightIframe").attr('src',"/weixinmanager/editUI.do"+"?id="+rows[0].id);
                $("#searchWindow").window("open");
                $('#searchWindow').window('center');

       /*         $.get('/weixinmanager/editHk.do',{'id':id},function (data) {
                    console.log(data)

                },'json');*/

            }

        }


            //删除批量
            function doRemove() {
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
                $.messager.confirm("警告", "你确定要删除选中版块吗？", function (r) {
                    if (r) {//确认删除
                        var data = {"ids": ids};
                        $.get("/weixinmanager/deleteHk.do", data, function (message) {
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
                return '<img class="imgfilet" width="30px" height="30px" border="0" src="/attach/showPicture.do?id=' + value + '"/>';
            }



    </script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
    <table id="grid"></table>
</div>


<!-- 窗口 -->
<div class="easyui-window" id="searchWindow">
    <iframe id="rightIframe" width="100%" height="100%" src="/weixin/hk_addUI.jsp">
    </iframe>
</div>

</body>
</html>