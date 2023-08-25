<%--
  Created by IntelliJ IDEA.
  User: Aron
  Date: 2022/5/27
  Time: 23:59
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
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/shopadmin2.css">
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
                    <a href="shopadmin.jsp" id="shopadmin">商品管理系统</a>
                    <!--下拉列表部分-->
                </li>
                <li>
                    <a href="#" style="opacity: 0">图片上传系统</a>
                </li>
                <li>
                    <a href="#" style="opacity: 0">商品添加系统</a>
                </li>
                <li>
                    <a href="javascript:;" id="useradmin">用户管理系统</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<!--导航结束-->
<!--主体开始-->
<%--<a id="shops" style="opacity: 0;"></a>--%>
<%--<a id="users" style="opacity: 0;"></a>--%>
<div class="container">
    <div class="wraps">
        <div class="c_body2">
            <div class="list-header2">
                <ul>
                    <li>用户id</li>
                    <li>用户邮箱</li>
                    <li>用户名</li>
                    <li>用户密码</li>
                    <li>设置权限</li>
                    <li>删除用户</li>
                </ul>
            </div>
            <%
                String sql = "select `user_id`,`email`,`username`,`password`,`state` from user";
                pst = con.prepareStatement(sql);
                rs = pst.executeQuery();
                int j=0;
                if(rs != null){
                    while(rs.next()){
                        j++;
            %>
            <div class="list-body2">
                <div class="cart-list-shop2">
                    <ul>
                        <li><%=rs.getInt(1)%></li>
                        <li><%=rs.getString(2)%></li>
                        <li><%=rs.getString(3)%></li>
                        <%
                            if(rs.getString(5).equals("superadmin")){
                        %>
                        <li>无法查看</li>
                        <%
                        }else{
                        %>
                        <li><%=rs.getString(4)%></li>
                        <%
                            }
                        %>
                        <li>
                            <form action="#" method="post">
                                <button type="submit" value="c" name="change<%=j%>"><%=rs.getString(5)%></button>
                            </form>
                        </li>
                        <li>
                            <form action="#" method="post">
                                <button type="submit" value="x" name="removeu<%=j%>"><i class="icon-chahao-copy iconfont"></i></button>
                            </form>
                        </li>
                    </ul>
                </div>
            </div>
            <%
                //控制用户权限修改的方法：
                String changes = request.getParameter("change"+j);
                if (changes==null){
                    changes="";
                }
                if (changes.equals("c")){
                    if (rs.getString(5).equals("superadmin")){
            %>
            <div class="cart-list-foot4">
                <p>无法对超级管理员进行权限更改操作！</p>
            </div>
            <%
            }else if (rs.getString(5).equals("admin")){
                String sql10="update user set `state`=? where user_id=?";
                pst = con.prepareStatement(sql10);
                pst.setString(1,"user");
                pst.setInt(2,rs.getInt(1));
                int ok4 = pst.executeUpdate();
                if (ok4>0){
            %>
            <div class="cart-list-foot4">
                <p>更改成功，当前权限为user<button type="button" id="shuaxin4">点击进行刷新</button></p>
            </div>
            <script>
                $("#shuaxin4").click(function () {
                    history.go(0);
                })
            </script>
            <%
                }
            }else if(rs.getString(5).equals("user")){
                String sql10="update user set `state`=? where user_id=?";
                pst = con.prepareStatement(sql10);
                pst.setString(1,"admin");
                pst.setInt(2,rs.getInt(1));
                int ok3 = pst.executeUpdate();
                if (ok3>0){
//                    response.sendRedirect("shopadmin.jsp");
            %>
            <div class="cart-list-foot4">
                <p>更改成功，当前权限为admin<button type="button" id="shuaxin5">点击进行刷新</button></p>
            </div>
            <script>
                $("#shuaxin5").click(function () {
                    history.go(0);
                })
            </script>
            <%
                        }
                    }
                }
            %>
            <%
                //控制用户删除的方法
                String removeu = request.getParameter("removeu"+j);
                if (removeu == null){
                    removeu = "0";
                }
                if (removeu.equals("x")){
                    String sql6 = "select `state` from user where user_id=?";
                    pst = con.prepareStatement(sql6);
                    pst.setInt(1, rs.getInt(1));
                    rs2 = pst.executeQuery();
                    if (rs2.next()){
                        if (rs2.getString(1).equals("superadmin")){
            %>
            <div class="cart-list-foot4">
                <p>你居然想删除超级管理员？？</p>
            </div>
            <%
            }else if (rs2.getString(1).equals("admin")){
                String sql8 = "select `state` from user where user_id=?";
                pst = con.prepareStatement(sql8);
                pst.setInt(1, Integer.parseInt(user_id));
                rs3 = pst.executeQuery();
                if (rs3.next()){
                    if (rs3.getString(1).equals("superadmin")){
                        String sql5 = "delete from user where user_id=?";
                        pst = con.prepareStatement(sql5);
                        pst.setInt(1, rs.getInt(1));
                        int ok2 = pst.executeUpdate();
                        if (ok2>0){
                            request.removeAttribute("removeu"+j);
            %>
            <div class="cart-list-foot2">
                <p>管理员删除成功！<button type="button" id="shuaxin6">点击进行刷新</button></p>
            </div>
            <script>
                $("#shuaxin6").click(function () {
                    history.go(0);
                })
            </script>
            <%
                }
            }else{
            %>
            <div class="cart-list-foot4">
                <p>你居然想删除你的同伴？这事只有超级管理员才能办到！</p>
            </div>
            <%
                    }
                }
            }else if (rs2.getString(1).equals("user")){
                String sql5 = "delete from user where user_id=?";
                pst = con.prepareStatement(sql5);
                pst.setInt(1, rs.getInt(1));
                int ok2 = pst.executeUpdate();
                if (ok2>0){
            %>
            <div class="cart-list-foot2">
                <p>用户删除成功！<button type="button" id="shuaxin3">点击进行刷新</button></p>
            </div>
            <script>
                $("#shuaxin3").click(function () {
                    history.go(0);
                })
            </script>
            <%
                            }
                        }
                    }
                }
            %>
            <%
                    }
                }
            %>
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

