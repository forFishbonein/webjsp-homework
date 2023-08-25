<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: Aron
  Date: 2022/5/18
  Time: 19:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Rog玩家国度</title>
    <!--网页图标-->
    <link rel="shortcut icon" href="${pageContext.request.contextPath }/end/images/weblogo.ico">
    <!--全局样式-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/reset.css">
    <!--自定义样式-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/cartsuccess.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/currency.css">
    <!--字体图标-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/iconfont.css">
    <link rel="stylesheet" href="https://at.alicdn.com/t/font_3403513_lu024ohjdxe.css">
    <link rel="stylesheet" href="https://at.alicdn.com/t/font_3309454_cew0v4vzrp7.css">
    <script src="https://lib.baomitu.com/jquery/3.6.0/jquery.js"></script>
    <style>
        .container{
            width: 100%;
            background-color: #f5f5f5;
            padding: 4px 0 12px;
            /*overflow: hidden;*/
            display: flex;
            justify-content: space-around;
            /*align-items:center;*/
            flex-wrap: wrap;
            min-height: 700px;
            align-items:flex-start;/*项目位于容器开头*/
        }

        .cart-list{
            display: flex;
            justify-content: space-around;
            /*align-items:center;*/
            flex-wrap: wrap;
            /*flex-direction: column; !*设置为竖直方向布局*!*//*不要用这个！！除非想做一列完了接着一列的那种！！*/
            align-items:flex-start;/*项目位于容器开头*/
            width: 316px;
            height: 0;/*强制设置为0，相当于隐藏了*/
            /*但是行高为0，文字内容会溢出，加一个overflow*/
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,.15); /*盒子阴影，经典*/
            background-color: #fff;
            /*需要绝对定位，子绝父相*/
            position: absolute;
            right: 0; /*这样就和父元素右对齐了*/
            color: #424242;
            line-height: 100px;/*文字垂直居中*/
            /*display: none; display不能过渡！！不能用/
            /*需要一个过渡，并且是从上往下的*/
            transition: height .3s; /*通过控制高度实现*/
            z-index: 2000;
            padding: 0 20px;
        }
        /*子class也需要加.才行*/
        .cart:hover>.cart-list{
            /*display: block; 不能用！！*/
            /*鼠标悬停时给出来行高，不悬停时自动消失*/
            /*min-height: 100px;*/
            height: auto; /*auto就会自动伸缩了*/
            overflow: visible; /*设置为溢出可见*/
        }
        .cart-list>p{
            display: inline-block;
            float: left;
            width: 296px;
            height: 60px;
            margin-top: 20px;
            background-color: #fff;
            z-index: 2000;
            padding: 10px 5px;
            border-bottom: 1px solid #e0e0e0;
            position: relative;
        }
        .cart-list>p>img{
            width: 60px;
            height: 60px;
            position: absolute;
            top: 0;
            left: 0;
        }
        /*span本来就是块级元素*/
        .cart-list>p>span:nth-child(2){
            font-size: 16px;
            line-height: 60px;
            position: absolute;
            top: 0;
            right: 100px;
            color: #757575;
            width: 120px;
            text-align: center;
        }
        .cart-list>p>span:last-child{
            font-size: 16px;
            line-height: 60px;
            position: absolute;
            top: 0;
            right: 20px;
            color: #757575;
        }
        #ppp{
            display: inline-block;
            float: left;
            width: 296px;
            height: 60px;
            margin-top: 0;
            background-color: #fff;
            z-index: 2000;
            padding: 15px 5px;
            position: relative;
            box-sizing: border-box;
        }
        #ppp>span{
            font-size: 16px;
            line-height: 60px;
            position: absolute;
            top: 2px;
            left: 30px;
            color: #409eff;
        }
        #ppp>a{
            display: block;
            float: right;
            width: 120px;
            height: 35px;
            background-color: #72aaec;
            color: #fff;
            white-space:nowrap;
        }
        #ppp>a:hover{
            background-color: #409eff;
        }
        #ppp>a>span{
            position: relative;
            top:-32px;
            font-size: 14px;
        }
        /*下面的商品推荐开始*/
        .name2,.desc2{
            width: 214px;
            margin: 0 auto;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .name2{
            height: 21px;
            line-height: 21px;
            font-size: 14px;
            margin-bottom: 2px;
        }
        .desc2{
            height: 18px;
            line-height: 18px;
            margin-bottom: 10px;
            font-size: 12px;
            color: #b0b0b0;
        }
        .price2{
            color: #409eff;
            font-size: 14px;
        }
        .price2>del{
            color: #b0b0b0;
            margin-left: 7px;
        }
        .items2{
            position: relative;
            width: 292.5px;
            height: 200px;
            background-color: #fff;
            float: left;
            margin-bottom: 14px;
            margin-left: 7px;
            margin-right: 7px;
            transition: all .2s linear;
            /*让div里面的元素垂直水平居中的三句话！！！*/
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .home-box2{
            width: 100%;
            /*height: 414px;*/
            display: flex;
            justify-content: space-around;
            align-items:center;
            flex-wrap: wrap;
        }
        .items2:hover{
            box-shadow: 0 15px 30px rgba(0,0,0,.1);
            transform: translateY(-2px);
            border-radius: 20px;
        }
        .items2 .button{
            position: absolute;
            bottom: 10%;
            /*margin-top: -20px;*/
            width: 100px;
            height: 40px;
            background-color: #72aaec;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,.18);
            display: none;
        }
        .items2 .button img{
            position: absolute;
            bottom: 55px;
            right: -50px;
            width: 200px;
            height: 100px;
            border-radius: 20px;
        }
        .items2 .button a{
            width: 40px;
            height: 30px;
            color: #fff;
            text-align: center;
            line-height: 40px;
        }
        /*下面的商品推荐结束*/

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
//        response.sendRedirect("login.jsp");
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

                    /*判断非指定页面进入重定向error的方法*/
                    String mess=request.getHeader("referer");
                    if (mess==null){
                        mess = "";
                    }
                    if (!(mess.startsWith("http://localhost:8080/end/shopdetail.jsp"))&&!(mess.startsWith("http://124.220.15.95:8080/webjsp/end/shopdetail.jsp"))) {
                        response.sendRedirect("error.jsp");
                    }else if (Objects.equals(user_id, "")){
                        response.sendRedirect("login.jsp");
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
            <form action="shopmore.jsp" method="post"> <%--form放在最外层比较好--%>
                <input type="text" name="na" id="in" value="" placeholder="搜索商品关键字">
                <!--放大镜-->
                <!--什么标签都可以，不一定放在i里面，只要class叫iconfont即可-->
                <button type="submit"><i class="iconfont">&#xe63d;</i></button>
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
<%
//    String shu = (String) session.getAttribute("shu"); /*取出来是Object类型，必须要向下转型一下*/
//    if (shu == null){
//        shu = "";
//    }
    String param = request.getParameter("param");
    if (param == null){
        param = "";
    }
    String id = "";
    String shu = "";
    if (!Objects.equals(param, "")){
        String[] params = param.split("#");
        shu = params[0];
        id = params[1].trim();
    }
    request.setCharacterEncoding("utf-8");
    if(!Objects.equals(shu, "") && !Objects.equals(id, "") && !Objects.equals(user_id, "")){
        con = DriverManager.getConnection(url, username, password);
        String sql1 = "select `quantity` from cart where s_id=? and u_id=?";
        pst = con.prepareStatement(sql1);
        pst.setInt(1, Integer.parseInt(id));
        pst.setInt(2, Integer.parseInt(user_id));
        rs = pst.executeQuery();
        if(rs.next()){
            int quantity = rs.getInt(1);
            String sql4 = "update cart set `quantity`=? where s_id = ? and `u_id`= ?";
            pst = con.prepareStatement(sql4);
            pst.setInt(1, quantity+Integer.parseInt(shu));
            pst.setInt(2, Integer.parseInt(id));
            pst.setInt(3, Integer.parseInt(user_id));
            int ok2 = pst.executeUpdate();
            if(ok2>0){

            }
        }else{
            String sql4 = "INSERT INTO cart(`u_id`,`s_id`,`quantity`,`state`) VALUES (?,?,?,?)";
            pst = con.prepareStatement(sql4);
            pst.setInt(1, Integer.parseInt(user_id));
            pst.setInt(2, Integer.parseInt(id));
            pst.setInt(3, Integer.parseInt(shu));
            String state = "false";
            pst.setString(4, state);
            int ok = pst.executeUpdate();
            if(ok>0) {

            }
        }
        String sql5 = "select `name` from commodity where id=?";
        pst = con.prepareStatement(sql5);
        pst.setInt(1, Integer.parseInt(id));
        rs = pst.executeQuery();
        if (rs.next()){
            String name = rs.getString(1);
%>
        <div class="order">
            <div class="order-left">
                <i class="icon-tijiaochenggong iconfont"></i>
            </div>
            <div class="order-right">
                <div class="word-left">
                    <h2>已成功加入购物车！</h2>
                    <p><%=name%></p>
                </div>
                <div class="word-right">
                    <a href="shopdetail.jsp?backid=<%=id%>" class="back">返回上一级</a>
                    <a href="shopcart.jsp" class="gocart">去购物车结算</a>
                </div>
            </div>
        </div>
        <script>
            $(function() {
                $(".order").fadeIn(1000).css('display','flex');
            });
        </script>
        <div style="margin-top: 60px"></div>
    <%          }
            }
    %>
        <h2 class="words">
            <span>买购物车中商品的人还买了</span>
        </h2>
        <!--产品2开始-->
        <div class="phone">
            <div class="home-box2">
                <div class="home-box-list">
                    <ul>
                        <%
                            String sql4 = "select `picture`,`name`,`price`,`describe`,`id` from commodity order by rand() limit 8";
                            pst = con.prepareStatement(sql4);
                            rs = pst.executeQuery(); //相当于重新给rs赋值，不冲突
                            while (rs.next()){
                        %>
                        <li class="items2">
                            <div class="block">
                                <a>
                                    <p class="name2"><%=rs.getString(2)%></p>
                                    <p class="desc2"><%=rs.getString(4)%></p>
                                    <p class="price2"><%=rs.getString(3).substring(0,rs.getString(3).length()-3)%>元起
                                        <del><%=Integer.parseInt(rs.getString(3).substring(0,rs.getString(3).length()-3))+200%>元</del>
                                    </p>
                                </a>
                            </div>
                            <div class="button">
                                <img src="<%=rs.getString(1)%>" alt="">
                                <a href="shopdetail.jsp?shopid=<%=rs.getString(5)%>">查看商品</a>
                            </div>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                </div>
            </div>
        </div>
        <!--产品2结束-->
        <div style="margin-top: 50px"></div>
    </div>
</div>
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
<%
}catch (SQLException e) {
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
//    response.sendRedirect("shopcart.jsp");
%>
<script type="text/javascript" src="${pageContext.request.contextPath }/end/js/shoplist.js"></script>
</body>
</html>
