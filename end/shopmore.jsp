<%--
  Created by IntelliJ IDEA.
  User: Aron
  Date: 2022/5/20
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %>
<html>
<head>
    <title>Rog玩家国度</title>
    <!--网页图标-->
    <link rel="shortcut icon" href="${pageContext.request.contextPath }/end/images/weblogo.ico">
    <!--字体图标-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/iconfont.css">
    <!--全局样式-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/reset.css">
    <!--自定义样式-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/shopmore.css">
    <style>
        /*主体开始*/
        .container{
            width: 100%;
            background-color: #f5f5f5;
            padding: 4px 0 12px;
            /*overflow: hidden;*/
            display: flex;
            justify-content: space-around;
            /*align-items:center;*/
            flex-wrap: wrap;
            min-height: 1000px;
            align-items:flex-start;/*项目位于容器开头*/
        }
        /*加入购物车成功框开始*/
        .order{
            width: 1000px;
            height: 150px;
            background-color: #fff;
            /*垂直居中*/
            align-items: center;
            /*justify-content: center;*/
            position: relative;
            display: flex;
            transition: all .2s linear;
            margin: 0 auto 20px;
        }
        .order:hover{
            box-shadow: 0 15px 30px rgba(0,0,0,.1);
            transform: translateY(-2px);
            border-radius: 20px;
        }
        .order-left{
            float: left;
            width: 100px;
            height: 100px;
            margin-left: 50px;
        }
        .order-left>img{
            width: 100px;
            height: 100px;
        }
        .order-right{
            float: right;
            width: 995px;
            height: 122px;
            padding: 20px 0;
            display: flex;
            align-items: center;
        }
        .word-left{
            float: left;
            width: 548px;
            height: 100px;
        }
        .word-left>h2{
            font-size: 24px;
            font-weight: 400;
            line-height: 24px;
            color: #424242;
            text-align: left;
            padding-left: 50px;
        }
        .word-left>h2>span{
            display: inline-block;
            width: auto;
            padding: 0 10px;
            height: 20px;
            border-radius: 10px;
            background-color: #409eff;
            color: #fff;
            font-size: 15px;
            text-align: center;
            line-height: 20px;
            position: relative;
            bottom: 3px;
            /*animation: tittlemove alternate infinite 2s ease-in-out;*/
        }
        .word-left>h2>span:first-child{
            margin-left: 20px;
            margin-right: 10px;
        }
        .word-left>p{
            color: #616161;
            text-align: left;
            padding-left: 50px;
            margin-top: 15px;
        }
        .word-right{
            float: right;
            width: 350px;
            height: 40px;
            display: flex;
            align-items: center;
            font-size: 16px;
            color: #757575;
            position: absolute;
            right: 30px;
        }
        .back{
            display: inline-block;
            width: 150px;
            height: 40px;
            background-color: #f5f5f5;
            color: #409eff;
            border: 1px #f5f5f5 solid;
            transition: all .5s;
            line-height: 40px;
            font-size: 18px;
            cursor: pointer;
        }
        .back:hover{
            box-shadow: 0 15px 30px rgba(0,0,0,.1);
            transform: translateY(-2px);
            border-radius: 10px;
            background-color: #fff;
            border-color: #409eff;
            color: #757575;
        }
        .gocart:hover{
            box-shadow: 0 15px 30px rgba(0,0,0,.1);
            transform: translateY(-2px);
            border-radius: 10px;
            background-color: #409eff;
            border-color:#409eff;
        }
        .gocart{
            margin-left: 20px;
            display: inline-block;
            width: 180px;
            height: 40px;
            background-color: #72aaec;
            color: #fff;
            border: 1px #72aaec solid;
            transition: all .5s;
            line-height: 40px;
        }

        @keyframes tittlemove {
            0% {}
            50% {
                transform: translateY(-2px);
            }
            100% {
                transform: translateY(2px);
            }
        }
        /*框结束*/
        /*主体结束*/
        /*尾部样式开始*/
        .footer{
            width: 100%;
            height: 300px;
        }
        .footer .b{
            margin: 50px auto -15px;
            border-top: 1px solid #e0e0e0;
            width: 1226px;
        }
        .footer img{
            width: 600px;
            height: 250px;
            margin-top: 30px;
        }
        .footer .word{
            margin-top: 10px;
            text-align: right;
        }
        .footer .word span{
            margin-right: 20px;
            color: #999;
        }
        .footer .word span:last-child{
            margin-right: 0;
        }
        /*尾部样式结束*/
        .words{
            position: relative;
            margin: 0;
            height: 50px;
            font-size: 30px;
            font-weight: 400;
            color: #757575;
            border-top: 1px solid #e0e0e0;
        }
        .words>span{
            display: block;
            position: absolute;
            top: -20px;
            left: 372px;
            height: 40px;
            width: 482px;
            line-height: 40px;
            text-align: center;
            background-color: #f5f5f5;
        }
        /*固定导航栏*/
        .fixed {
            position: fixed;
            top: 0;
            z-index: 9999;
            display: none;
        }
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
        /*商品价格区间查询开始*/
        .section{
            width: 1000px;
            height: 100px;
            background-color: #fff;
            /*垂直居中*/
            align-items: center;
            justify-content: center;
            display: flex;
            margin: 0 auto 20px;
            padding: 7px 0;
            color: #616161;
            font-size: 16px;
        }
        .section input{
            width: 100px;
            height: 30px;
            border: 2px solid #409eff;
            border-radius: 10px;
            margin: 0 10px;
            color: #616161;
            font-size: 16px;
            text-align: center;
        }
        .section span{
            margin: 0 10px;
        }
        .section button{
            width: 70px;
            height: 30px;
            color: #fff;
            background-color: #72aaec;
            border-radius: 10px;
            border: 2px solid #72aaec;
            margin-left: 20px;
            font-size: 16px;
            padding-bottom: 3px;
        }
        .section button:hover{
            background-color: #409eff;
            border: 2px solid #409eff;
        }
        /*商品价格区间查询结束*/
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
                        flag=2;
                        String sql8 = "select `username` from user where user_id=?";
                        pst = con.prepareStatement(sql8);
                        pst.setInt(1, Integer.parseInt(user_id));
                        rs = pst.executeQuery();
                        if(rs.next()){
                %>
                <span>欢迎你！尊贵的<%=rs.getString(1)%>用户</span>
                <%
                    }
                }else{
                %>
                <span>Rog玩家国度旗舰店</span>
                <%
                    }
                %>
            </li>
        </ul>
        <ul class="header-right">
            <li>
                <a href="#">关注公众号</a><span>|</span>
                <!--二维码-->
                <div class="download">
                    <a><img src="images/download.png"></a>
                    <p>玩家国度公众号</p>
                </div>
                <!--三角形-->
                <div class="triangle"></div>
            </li>
            <%
                if (flag==1){
            %>
            <li><a href="login.jsp">登录</a><span>|</span></li>
            <%
            }else if(flag==2){
            %>
            <li><a href="account.jsp">我的订单</a><span>|</span></li>
            <li><a href="shoplist.jsp?com=exit">退出登录</a><span>|</span></li>
            <%
                }
            %>
            <li><a href="register.jsp">注册</a></li>
            <!--单独设置购物车的样式-->
            <li class="cart">
                <%
                    if (flag==1){
                %>
                <a href="shopcart.jsp"><i class="iconfont">&#xe653;</i>购物车(0)</a>
                <div class="cart-list">还没有登录，登录后再添加购物车吧！</div>
                <%
                }else if(flag==2){
                    String sql9 = "select count(`s_id`) from cart where u_id=?";
                    pst = con.prepareStatement(sql9);
                    pst.setInt(1, Integer.parseInt(user_id));
                    rs = pst.executeQuery();
                    if(rs.next()){
                %>
                <a href="shopcart.jsp"><i class="iconfont">&#xe653;</i>购物车(<%=rs.getObject(1)%>)</a>
                <div class="cart-list">
                    <%
                        String sql10 = "select `s_id` from cart where u_id=?";
                        pst = con.prepareStatement(sql10);
                        pst.setInt(1, Integer.parseInt(user_id));
                        rs = pst.executeQuery();
                        int sum = 0;
                        int price = 0;
                        while (rs.next()){
                            String sql11 = "select `picture`,`name`,`price` from commodity where id=?";
                            pst = con.prepareStatement(sql11);
                            pst.setInt(1, rs.getInt(1));
                            rs2 = pst.executeQuery();
                            if (rs2.next()){
                                price = Integer.parseInt(rs2.getString(3).substring(0,rs2.getString(3).length()-3));
                                sum = sum + price;
                    %>
                    <p>
                        <img src="<%=rs2.getString(1)%>" alt="">
                        <span><%=rs2.getString(2)%></span>
                        <span><%=price%>元</span>
                    </p>
                    <%
                            }
                        }
                    %>
                    <p id="ppp">
                        <span>合计：<%=sum%>元</span>
                        <a href="shopcart.jsp"><span>去购物车结算</span></a>
                    </p>
                </div>
                <%
                        }
                    }
                %>
            </li>
        </ul>
    </div>
</div>
<!--头部结束-->

<!--导航开始-->
<div class="nav">
    <div class="wrap">
        <!--logo图标-->
        <div class="logo">
            <a href="shoplist.jsp">
                <img src="images/logo.png">
            </a>
        </div>
        <!--导航nav-bar-->
        <div class="nav-bar">
            <ul>
                <li>
                    <a href="#">幻系列</a>
                    <!--下拉列表部分-->
                    <div class="nav-bar-list">
                        <div class="wrap">
                            <!--ul>li*6>a[href=#]>div.img-box>img-->
                            <ul>
                                <%
                                    String sql = "select `picture`,`name`,`price`,`id` from commodity where s_id=1";
                                    pst = con.prepareStatement(sql);
                                    rs = pst.executeQuery();
                                    if(rs != null){
                                        while(rs.next()){
                                %>
                                <li style="padding-bottom: 10px">
                                    <a href="shopdetail.jsp?shopid=<%=rs.getString(4)%>">
                                        <div class="img-box">
                                            <img src="<%=rs.getString(1)%>" alt="">
                                        </div>
                                        <p class="name1"><%=rs.getString(2)%></p>
                                        <p class="price1"><%=rs.getString(3).substring(0,rs.getString(3).length()-3)%>元起</p>
                                    </a>
                                </li>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                </li>
                <li>
                    <a href="#">魔霸系列</a>
                    <div class="nav-bar-list">
                        <div class="wrap">
                            <!--ul>li*6>a[href=#]>div.img-box>img-->
                            <ul>
                                <%
                                    String sql2 = "select `picture`,`name`,`price`,`id` from commodity where s_id=2";
                                    pst = con.prepareStatement(sql2);
                                    rs = pst.executeQuery(); //相当于重新给rs赋值，不冲突
                                    if(rs != null){
                                        while(rs.next()){
                                %>
                                <li style="padding-bottom: 10px">
                                    <a href="shopdetail.jsp?shopid=<%=rs.getString(4)%>">
                                        <div class="img-box"><img src="<%=rs.getString(1)%>" alt=""></div>
                                        <p class="name1"><%=rs.getString(2)%></p>
                                        <p class="price1"><%=rs.getString(3).substring(0,rs.getString(3).length()-3)%>元起</p>
                                    </a>
                                </li>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                </li>
                <li>
                    <a href="#">键盘</a>
                    <div class="nav-bar-list">
                        <div class="wrap">
                            <!--ul>li*6>a[href=#]>div.img-box>img-->
                            <ul>
                                <%
                                    String sql3 = "select `picture`,`name`,`price`,`id` from commodity where s_id=3";
                                    pst = con.prepareStatement(sql3);
                                    rs = pst.executeQuery(); //相当于重新给rs赋值，不冲突
                                    if(rs != null){
                                        while(rs.next()){
                                %>
                                <li style="padding-bottom: 10px">
                                    <a href="shopdetail.jsp?shopid=<%=rs.getString(4)%>">
                                        <div class="img-box"><img src="<%=rs.getString(1)%>" alt=""></div>
                                        <p class="name1"><%=rs.getString(2)%></p>
                                        <p class="price1"><%=rs.getString(3).substring(0,rs.getString(3).length()-3)%>元起</p>
                                    </a>
                                </li>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                </li>

                <!--                    <li><a href="#">服务</a></li>-->
                <!--                    <li><a href="#">社区</a></li>-->
            </ul>
        </div>
        <!--搜索框-->
        <div class="search">
            <!--注：css选择器是没有选择父元素的功能的，只能针对父元素让子元素产生事件-->
            <!--css只有后代和兄弟（后面的）-->
            <form action="#" method="post"> <%--form放在最外层比较好--%>
                <input type="text" name="na" id="in" value="" placeholder="搜索商品关键字">
                <!--放大镜-->
                <!--什么标签都可以，不一定放在i里面，只要class叫iconfont即可-->
                <button type="submit"><i class="iconfont">&#xe63d;</i></button>
                <%
                    String shopname = request.getParameter("na");
                    if (shopname==null){
                        shopname="";
                    }
                %>
                <!--写点击input会出现的列表-->
                <div class="search-list">
                    <%
                        String sql10 = "select `name` from commodity order by rand() limit 8";
                        pst = con.prepareStatement(sql10);
                        rs = pst.executeQuery();
                        if(rs != null){
                            while(rs.next()){
                    %>
                    <p id="sel"><%=rs.getString(1)%></p>
                    <%
                            }
                        }
                    %>
                </div>
            </form>
        </div>
    </div>
</div>
<!--导航结束-->

<%--主体开始--%>
<div class="container">
    <div class="wrap">
        <div style="margin-top: 30px"></div>
        <div class="section">
            <form action="#" method="post">
                价格位于：<input type="text" name="minval" placeholder="最小值" value="">元
                <span>——</span>
                <input type="text" name="maxval" placeholder="最大值" value="">元之间
                <button type="submit" value="">查询</button>
            </form>
        </div>
        <%
            String minval = request.getParameter("minval");
            if (minval==null){
                minval="";
            }
            String maxval = request.getParameter("maxval");
            if (maxval==null){
                maxval="";
            }
        %>
        <%
            if (Objects.equals(shopname, "")&& Objects.equals(minval, "")&& Objects.equals(maxval, "")) {
                String sql4 = "select `picture`,`name`,`price`,`describe`,`param`,`id`,`series`,`color` from commodity";
                pst = con.prepareStatement(sql4);
                rs = pst.executeQuery();
            }else if(!Objects.equals(shopname, "")){
                String sql4 = "select `picture`,`name`,`price`,`describe`,`param`,`id`,`series`,`color` from commodity where name like ?";
                pst = con.prepareStatement(sql4);
                pst.setString(1, "%"+shopname+"%");
                rs = pst.executeQuery();
                if(rs.next()){ //用rs.next判断是否结果为空!!!!——>判断是否为空的重要方法
                    rs.previous(); //判断完要把指针向前移动一位，要不然结果会少一个
        %>
            <div style="margin-top: 60px"></div>
            <h2 class="words">
                <span>搜索结果</span>
            </h2>
        <%
                }else{
        %>
            <div style="margin-top: 60px"></div>
            <h2 class="words">
                <span>很抱歉没有找到您想要的商品</span>
            </h2>
        <%
                }
            }else if(!Objects.equals(minval, "")||!Objects.equals(maxval, "")){
                String sql5 = "select `picture`,`name`,`price`,`describe`,`param`,`id`,`series`,`color` from commodity where `price` between ? and ?";
                pst = con.prepareStatement(sql5);
                if(!Objects.equals(minval, "")&&Objects.equals(maxval, "")){
                    pst.setString(1,minval);
                    pst.setString(2, "1000000000");
                }else if(Objects.equals(minval, "")&&!Objects.equals(maxval, "")){
                    pst.setString(1,"0");
                    pst.setString(2,maxval);
                }else if(!Objects.equals(minval, "")&&!Objects.equals(maxval, "")){
                    pst.setString(1,minval);
                    pst.setString(2,maxval);
                }
                rs = pst.executeQuery();
                    if(rs.next()){ //用rs.next判断是否结果为空!!!!——>判断是否为空的重要方法
                        rs.previous(); //判断完要把指针向前移动一位，要不然结果会少一个
                    %>
                    <div style="margin-top: 60px"></div>
                    <h2 class="words">
                        <span>搜索结果</span>
                    </h2>
                    <%
                    }else{
                    %>
                    <div style="margin-top: 60px"></div>
                    <h2 class="words">
                        <span>很抱歉没有找到相关商品</span>
                    </h2>
                    <%
                }
            }
            if(rs != null){
                while(rs.next()){
        %>
        <div class="order">
            <div class="order-left">
                <img src="<%=rs.getString(1)%>" alt="">
            </div>
            <div class="order-right">
                <div class="word-left">
                    <h2><%=rs.getString(2)%><span><%=rs.getString(7)%></span><span>配色：<%=rs.getString(8)%></span></h2>
                    <p>• <%=rs.getString(4)%></p>
                    <p>• 配置参数：<%=rs.getString(5)%></p>
                </div>
                <div class="word-right">
                    <p class="back"><%=rs.getString(3)%>元</p>
                    <a href="shopdetail.jsp?shopid=<%=rs.getString(6)%>" class="gocart">查看商品详情</a>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>
        <div style="margin-top: 60px"></div>
    </div>
</div>
<%--主体结束--%>

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
    <script src="https://lib.baomitu.com/jquery/3.6.0/jquery.js"></script>
    <script>
        // 监听滚动事件
        $(window).on("scroll",function(){
            //判断向下滑动的距离
            if($(window).scrollTop()>=100){
                //将顶部导航栏固定
                $(".header").addClass("fixed").fadeIn(1000);
            }else{
                $(".header").removeClass("fixed");
            }

            if ($(window).scrollTop()>=250){
                $("#box").fadeIn(700).css('display','block');
            }else{
                $("#box").fadeOut(700,function () {
                    $("#box").css('display','none');
                });
            }
        });
        $(function(){
            $(".order").mouseover(function () {
                $(".word-left>h2>span").css({
                    'animation':'tittlemove alternate infinite 2s ease-in-out',
                    'color':'#409eff',
                    'background-color':'#fff',
                    'box-shadow':'0 5px 10px rgba(0,0,0,.4)',
                    'font-weight':'1000'
                });
            }).mouseleave(function () {
                $(".word-left>h2>span").css({
                    'animation':'',
                    'color':'#fff',
                    'background-color':'#409eff',
                    'box-shadow':'',
                    'font-weight':''
                });
            });
            /*控制搜索框样式的js方法*/
            $(".search-list>p").on('click',function () {
                $("#in").val($(this).text());
                $(".search-list").css('display','none');
            }).hover(function () {
                $(".search-list").css('display','block');
            },function () {
                $(".search-list").css('display','none');
            });
            // $(".search-list").mouseleave(function () {
            //     if ($(".search input").is(':focus')===true){
            //         $(".search input").hover(function () {
            //             $(".search-list").css('display','block');
            //         })
            //     }
            // })
            $(".search input").on('focus',function () {
                $(".search-list").css('display','block');
            }).hover(function () {
                $(".search-list").css('display','block');
            },function () {
                $(".search-list").css('display','none');
            });
        });
    </script>
<script>
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
</script>
    </body>
</html>