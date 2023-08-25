<%--
  Created by IntelliJ IDEA.
  User: Aron
  Date: 2022/5/25
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %>
<html>
<head>
    <title>玩家国度-管理系统</title>
    <!--网页图标-->
    <link rel="shortcut icon" href="${pageContext.request.contextPath }/end/images/weblogo.ico">
    <!--字体图标-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/iconfont.css">
    <!--全局样式-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/reset.css">
    <!--自定义样式-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/shopadmin.css">
    <link rel="stylesheet" href="https://at.alicdn.com/t/font_3403513_fenry85csl8.css">
    <script src="https://lib.baomitu.com/jquery/3.6.0/jquery.js"></script>
    <style>
        /*向上滚动的按钮开始*/
        .box{
            position:fixed;
            right:10px;
            bottom: 200px;
            height:30px;
            width: 50px;
            text-align:center;
            padding-top:20px;
            background-color: #e0e0e0;
            border-radius: 50%;
            overflow: hidden;
            display: none;
            cursor: pointer;
        }
        .box:hover{
            background-color: #409eff;
        }
        .box-in{
            visibility: visible;
            display:inline-block;
            height:18px;
            width: 18px;
            border: 3px solid black;
            border-color: white transparent transparent white;
            transform:rotate(45deg);
        }
        /*向上滚动的按钮结束*/
    </style>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    String url = "jdbc:mysql://124.220.15.95:3306/shopdatabase?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=GMT";
    String username = "root";
    String password = "123456";
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;
    try {
        con = DriverManager.getConnection(url,username,password);
%>
<%
    /*注销的方法*/
    String com = request.getParameter("com");
    if (com==null){
        com = "";
    }
    if (com.equals("exit")){
        session.removeAttribute("user_id");
        response.sendRedirect("login.jsp");
    }
%>
<!--头部开始-->
<div class="header">
    <!--水平居中的容器一般叫wrap或者container-->
    <div class="wrap">
        <!--ul>li*13>a[href=#]-->
        <!--ul是块元素，要进行浮动操作-->
        <ul class="header-left">
            <!--li也是块级元素，也要进行浮动操作,li只能左浮动，右浮动就倒序了-->
            <li>
                <%
                    int flag = 1; //设置一个flag为了标志登录状态，以至于下面的代码可以根据该状态进行变化！！
                    String user_id = (String)session.getAttribute("user_id");
                    if (user_id==null){
                        user_id="";
                    }
                    if (!Objects.equals(user_id, "")){
                    String sql9 = "select `state` from user where user_id=?";
                    pst = con.prepareStatement(sql9);
                    pst.setInt(1, Integer.parseInt(user_id));
                    rs = pst.executeQuery();
                    if (rs.next()){
                        if (rs.getString(1).equals("admin")||rs.getString(1).equals("superadmin")){
                            flag = 2;
                        }
                    }
                    if (flag==2){
                        String sql8 = "select `username` from user where user_id=?";
                        pst = con.prepareStatement(sql8);
                        pst.setInt(1, Integer.parseInt(user_id));
                        rs = pst.executeQuery();
                        if(rs.next()){
                %>
                <span>欢迎你！管理员：<%=rs.getString(1)%></span>
                <%
                    }
                }else{
                %>
                <span>Rog玩家国度后台管理系统</span>
                <%
                    }
                }
                %>
            </li>
        </ul>
        <ul class="header-right">
            <%
                if (flag==1){
            %>
            <li><a href="login.jsp">登录</a><span>|</span></li>
            <%
            }else if(flag==2){
            %>
            <li><a href="shoplist.jsp?com=exit">退出登录</a><span>|</span></li>
            <%
                }
            %>
            <li><a href="register.jsp">注册</a></li>
        </ul>
    </div>
</div>
<!--头部结束-->
<%
    if (flag==2){
%>
<!--导航开始-->
<div class="nav">
    <div class="wrap">
        <!--logo图标-->
        <div class="logo">
            <a href="#">
                <img src="images/logo.png">
            </a>
        </div>
        <!--导航nav-bar-->
        <div class="nav-bar">
            <ul>
                <li>
                    <a href="javascript:;" id="shopadmin">商品管理系统</a>
                    <!--下拉列表部分-->
                </li>
                <li>
                    <a href="#picupload">图片上传系统</a>
                </li>
                <li>
                    <a href="#shopadd">商品添加系统</a>
                </li>
                <li>
                    <a href="shopadmin2.jsp" id="useradmin">用户管理系统</a>

                </li>
            </ul>
        </div>
    </div>
</div>
<!--导航结束-->
<!--主体开始-->
<div class="container">
    <div class="wraps">
        <div class="c_body1">
            <div class="list-header">
                <ul>
                    <li>系列</li>
                    <li>图片</li>
                    <li>名称</li>
                    <li>颜色</li>
                    <li>参数</li>
                    <li>描述</li>
                    <li>价格</li>
                    <li>更新</li>
                    <li>删除</li>
                </ul>
            </div>
            <%
                String sql1 = "select `id`,`series`,`name`,`picture`,`color`,`describe`,`param`,`price` from commodity";
                pst = con.prepareStatement(sql1);
                rs = pst.executeQuery();
                int i = 0;
                //开始输出所有商品
                while (rs.next()){
                    i++;
                    //控制商品更新的方法
                    String val1  = request.getParameter("val1"+ i);
                    String val2  = request.getParameter("val2"+ i);
                    String val3  = request.getParameter("val3"+ i);
                    String val4  = request.getParameter("val4"+ i);
                    String val5  = request.getParameter("val5"+ i);
                    String val6  = request.getParameter("val6"+ i);
                    String val7  = request.getParameter("val7"+ i);
                    if (val1==null){
                        val1="";
                    }
                    if (val2==null){
                        val2="";
                    }
                    if (val3==null){
                        val3="";
                    }
                    if (val4==null){
                        val4="";
                    }
                    if (val5==null){
                        val5="";
                    }
                    if (val6==null){
                        val6="";
                    }
                    if (val7==null){
                        val7="";
                    }
                    if (!Objects.equals(val1, "") &&!Objects.equals(val2, "") &&!Objects.equals(val3, "") &&!Objects.equals(val4, "")&&!Objects.equals(val5, "") &&!Objects.equals(val6, "") &&!Objects.equals(val7, "") ){
                        String sql2 = "update commodity set `series`=?,`name`=?,`picture`=?,`color`=?,`describe`=?,`param`=?,`price`=? where id=?";
                        pst = con.prepareStatement(sql2);
                        pst.setString(1, val1);
                        pst.setString(2, val3);
                        pst.setString(3, val2);
                        pst.setString(4, val4);
                        pst.setString(5, val6);
                        pst.setString(6, val5);
                        pst.setString(7, val7);
                        pst.setInt(8, rs.getInt(1));
                        int ok3 = 0;
                        ok3 = pst.executeUpdate();
                        if (ok3>0){
                            %>
                            <script>
                                // //1.这种刷新是不带参数的刷新,但是有时候不好用！
                                window.location.href=window.location.href; //这个时候必须用这个！！！——>暂时不知道为什么
                                // //2.这种刷新的带参数的刷新
                                // // window.location.reload();
                                // //3.能不用重定向本页面刷新就尽量不用
                                // //response.sendRedirect("#");
                                // history.go(0);
                            </script>
            <%
                        }
                    }
            %>
            <div class="list-body">
                <div class="cart-list-shop">
                    <script>
                        $(function () {
                            //one表示在当前页面加载完成之后，只执行一次的事件
                            //必须用one，这样才可以点击提交。传值到本页面，然后页面直接刷新，要不然的话提交不上去，因为会一直触发click
                            $("#update<%=i%>").one('click',function () {
                                $("#update<%=i%>").attr('type','submit').addClass("body1").val("保存");
                                $("#li1<%=i%>").css('padding','0 10px').empty().prepend('<input type="text" name="val1<%=i%>" value="<%=rs.getString(2)%>" class="inin" required>');
                                $("#li2<%=i%>").css('padding','0 10px').empty().prepend('<input type="text" name="val2<%=i%>" value="<%=rs.getString(4)%>" class="inin" required>');
                                $("#li3<%=i%>").css('padding','0 10px').empty().prepend('<input type="text" name="val3<%=i%>" value="<%=rs.getString(3)%>" class="inin" required>');
                                $("#li4<%=i%>").css('padding','0 10px').empty().prepend('<input type="text" name="val4<%=i%>" value="<%=rs.getString(5)%>" class="inin" required>');
                                $("#li5<%=i%>").css('padding','0 10px').empty().prepend('<input type="text" name="val5<%=i%>" value="<%=rs.getString(7)%>" class="inin" required>');
                                $("#li6<%=i%>").css('padding','0 10px').empty().prepend('<input type="text" name="val6<%=i%>" value="<%=rs.getString(6)%>" class="inin2" required>');
                                $("#li7<%=i%>").css('padding','0 10px').empty().prepend('<input type="text" name="val7<%=i%>" value="<%=rs.getString(8)%>" class="inin" required>');
                                return false; //必须要加上这个，否则会自动点击提交！！！
                            });
                        });
                    </script>
                    <ul>
                        <form action="shopadmin.jsp" method="post">
                            <li id="li1<%=i%>"><%=rs.getString(2)%></li>
                            <li id="li2<%=i%>">
                                <div>
                                    <img src="<%=rs.getString(4)%>" alt="">
                                </div>
                            </li>
                            <li id="li3<%=i%>"><%=rs.getString(3)%></li>
                            <li id="li4<%=i%>"><%=rs.getString(5)%></li>
                            <li id="li5<%=i%>"><span><%=rs.getString(7)%></span></li>
                            <li id="li6<%=i%>"><span><%=rs.getString(6)%></span></li>
                            <li id="li7<%=i%>"><%=rs.getString(8)%>元</li>
                            <li id="li8<%=i%>">
                                <input type="button" id="update<%=i%>" value="更新">
                            </li>
                        </form>
                        <li id="li9<%=i%>">
                            <form action="#" method="post">
                                <button type="submit" value="x" name="removex<%=i%>" class="body1"><i class="icon-chahao-copy iconfont"></i></button>
                            </form>
                        </li>
                    </ul>
                </div>
            </div>
            <%
            //控制商品删除的方法
            String removex = request.getParameter("removex"+i);
            if (removex == null){
                removex = "0";
            }
            if (removex.equals("x")){
            String sql5 = "delete from commodity where id=?";
            pst = con.prepareStatement(sql5);
            pst.setInt(1, rs.getInt(1));
            int ok2 = pst.executeUpdate();
            if (ok2>0){
                request.removeAttribute("removex"+i);
            %>
                <div class="cart-list-foot2">
                    <p>商品删除成功！<button type="button" id="shuaxin2" class="body1">点击进行刷新</button></p>
                </div>
                <script>
                    $("#shopadmin").trigger("click");
                    $("#shuaxin2").click(function () {
                        window.location.reload();//这个在禁用f5的时候也可以！
                        // history.go(0);
                    })
                </script>
            <%
                        }
                    }
                }
            %>
            <div class="cart-list-foot" id="picupload">
                <ul>
                    <form action="fileup.do" method="post" enctype="multipart/form-data">
                        <li>
                            图片上传系统：
                            <a href="javascript:;" id="upload">
                            点击选择您要上传的图片<input type="file" name="fileName" id="change" accept="image/gif,image/jpg,image/jpeg,image/png,image/svg" required>
                            </a>
                        </li>
                        <li>
                            支持的格式为：*.gif,*.jpg,*.jpeg,*.png,*.svg
                        </li>
                        <li>
                            <img src="" id="imgs">
                        </li>
                        <li>
                            <input type="submit" value="提交" class="body1">
                        </li>
                    </form>
                    <script>
                        //当file改变的时候，将img的src改为修改后的值
                        $('#change').change(function () {
                            f = document.getElementById('change').files[0];
                            var reads = new FileReader();
                            reads.readAsDataURL(f);
                            reads.onload = function(e) {
                                $('#imgs').attr("src",this.result);
                            }
                        })
                    </script>
                </ul>
            </div>
            <%
                //String fileName = request.getParameter("fileName"); getParameter方法接收的是用户form输入的值
                String fileName = (String) request.getAttribute("fileName"); //getAttribute接收的是程序设置的值，所以必须用这个
                // ${requestScope.fileName}的底层就是request.etAttribute
                if (fileName==null){
                    fileName="";
                }
                if (!Objects.equals(fileName, "")){
            %>
                <div class="cart-list-foot2">
                    <p>上传成功！您上传的文件路径为：<span>images/<%=fileName%></span></p>
                    <p>请复制此路径，用于进行更新、添加等操作！</p>
                </div>
            <%
                }
            %>
            <%
                //String fileName = request.getParameter("fileName"); getParameter方法接收的是用户form输入的值
                String tips = (String) request.getAttribute("tips"); //getAttribute接收的是程序设置的值，所以必须用这个
                // ${requestScope.fileName}的底层就是request.getAttribute
                if (tips==null){
                    tips="";
                }
                if (!Objects.equals(tips, "")){
            %>
            <div class="cart-list-foot2">
                <p>该文件已存在，请不要重复上传文件！</p>
            </div>
            <%
                }
            %>

            <div class="cart-list-foot3" id="shopadd">
                <div class="wor">商品添加系统：</div>
                <div style="margin-bottom: 12px"></div>
                <ul>
                    <form action="shopadmin.jsp" method="post">
                        <li><input type="text" name="vals1" value="" class="inin" required placeholder="系列名"></li>
                        <li><input type="text" name="vals8" value="" class="inin" required placeholder="系列号"></li>
                        <li>
                            <input type="text" name="vals2" value="" class="inin" required placeholder="图片路径">
                        </li>
                        <li><input type="text" name="vals3" value="" class="inin" required placeholder="名称"></li>
                        <li><input type="text" name="vals4" value="" class="inin" required placeholder="颜色"></li>
                        <li><input type="text" name="vals5" value="" class="inin" required placeholder="参数"></li>
                        <li><input type="text" name="vals6" value="" class="inin" required placeholder="描述"></li>
                        <li><input type="text" name="vals7" value="" class="inin" required placeholder="价格"></li>
                        <li>
                            <input type="submit" id="updates" value="添加" class="body1">
                        </li>
                    </form>
                </ul>
            </div>

            <%--添加商品的功能块！！开始--%>
            <%
                //控制商品更新的方法
                String vals1  = request.getParameter("vals1");
                String vals2  = request.getParameter("vals2");
                String vals3  = request.getParameter("vals3");
                String vals4  = request.getParameter("vals4");
                String vals5  = request.getParameter("vals5");
                String vals6  = request.getParameter("vals6");
                String vals7  = request.getParameter("vals7");
                String vals8  = request.getParameter("vals8");
                if (vals1==null){
                    vals1="";
                }
                if (vals2==null){
                    vals2="";
                }
                if (vals3==null){
                    vals3="";
                }
                if (vals4==null){
                    vals4="";
                }
                if (vals5==null){
                    vals5="";
                }
                if (vals6==null){
                    vals6="";
                }
                if (vals7==null){
                    vals7="";
                }
                if (vals8==null){
                    vals8="";
                }
                if (!Objects.equals(vals1, "") &&!Objects.equals(vals2, "") &&!Objects.equals(vals3, "") &&!Objects.equals(vals4, "")&&!Objects.equals(vals5, "") &&!Objects.equals(vals6, "") &&!Objects.equals(vals7, "")&&!Objects.equals(vals8, "") ){
                    String sql2 = "insert into commodity(`series`,`name`,`picture`,`color`,`describe`,`param`,`price`,`s_id`) VALUES (?,?,?,?,?,?,?,?)";
                    pst = con.prepareStatement(sql2);
                    pst.setString(1, vals1);
                    pst.setString(2, vals3);
                    pst.setString(3, vals2);
                    pst.setString(4, vals4);
                    pst.setString(5, vals6);
                    pst.setString(6, vals5);
                    pst.setString(7, vals7);
                    pst.setInt(8, Integer.parseInt(vals8));
                    int ok4 = 0;
                    ok4 = pst.executeUpdate();
                    if (ok4>0){
            %>
            <div class="cart-list-foot2">
                <p>商品添加成功！<button type="button" id="shuaxin1" class="body1">点击进行刷新</button></p>
            </div>
            <script>
                $("#shuaxin1").click(function () {
                    history.go(0);
                })
            </script>
            <%
                    }
                }
            %>
            <%--添加商品的功能块！！结束--%>
        </div>
    </div>
</div>
<%
    }else{ /*flag=2的else*/
%>
<div style="margin-top: 60px"></div>
<h2 class="words">
    <span>请先登录</span>
</h2>
<%
    }
%>
<!--尾部开始-->
<div class="footer">
    <div class="b">
        <div class="word">
            <span>使用条款</span><span>隐私权保护政策</span><span>沪公网安备</span><span>31011202002313号</span><span>沪ICP备11025349号-3</span><span>©ASUSTeK Computer Inc. 版权所有.</span>
        </div>
    </div>
    <div class="wrap">
        <img src="images/logo.png" alt="">
    </div>
</div>
<!--尾部结束-->
<div id="box" class="box">
    <div class="box-in"></div>
</div>
<%
    } catch (SQLException e) {
        e.printStackTrace();
    }finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pst != null) {
            try {
                pst.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
<script>
    // 监听滚动事件
    $(window).on("scroll",function(){
        if ($(window).scrollTop()>=250){
            $("#box").fadeIn(700).css('display','block');
        }else{
            $("#box").fadeOut(700,function () {
                $("#box").css('display','none');
            });
        }
    });
    var timer = null;
    box.onclick = function(){
        cancelAnimationFrame(timer);
        timer = requestAnimationFrame(function fn(){
            var oTop = document.body.scrollTop || document.documentElement.scrollTop;
            if(oTop > 0){
                document.body.scrollTop = document.documentElement.scrollTop = oTop - 50;
                timer = requestAnimationFrame(fn);
            }else{
                cancelAnimationFrame(timer);
            }
        });
    }
    $(function () {
        //平滑锚点的方法
        $('a[href*="#shopadd"],area[href*="#shopadd"]').click(function () {
            if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
                var $target = $(this.hash);
                $target = $target.length && $target || $('[name=' + this.hash.slice(1) + ']');
                if ($target.length) {
                    var targetOffset = $target.offset().top - 50;
                    $('html,body').animate({
                            scrollTop: targetOffset
                        },
                        1000);
                    return false;
                }
            }
        });
        $('a[href*="#picupload"],area[href*="#picupload"]').click(function () {
            if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
                var $target = $(this.hash);
                $target = $target.length && $target || $('[name=' + this.hash.slice(1) + ']');
                if ($target.length) {
                    var targetOffset = $target.offset().top - 50;
                    $('html,body').animate({
                            scrollTop: targetOffset
                        },
                        1000);
                    return false;
                }
            }
        });
    });
//重点方法！！禁用f5提交表单！！！，实现了可点击按钮进行刷新的功能！
    if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
    }
</script>
</body>

</html>
