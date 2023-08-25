<%--
  Created by IntelliJ IDEA.
  User: Aron
  Date: 2022/5/9
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.HashMap" %>
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
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/shopdetail.css">
    <!--字体样式-->
    <link rel="stylesheet" href="https://at.alicdn.com/t/font_3403513_wrnhlenwbz.css">
    <script src="https://lib.baomitu.com/jquery/3.6.0/jquery.js"></script>
    <style>
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
        /*标题语*/
        .words{
            position: relative;
            margin: 0;
            height: 50px;
            font-size: 30px;
            font-weight: 400;
            color: #757575;
            border-top: 1px solid #e0e0e0;
            background-color: #fff;
        }
        .words>span{
            display: block;
            position: absolute;
            top: -20px;
            left: 390px;
            height: 40px;
            width: 482px;
            line-height: 40px;
            text-align: center;
            background-color: #fff;
        }
        /*评论部分开始*/
        .eval{
            width: 100%;
            background-color: #fff;
            /*padding-top: 20px;*/
            padding-bottom: 12px;
            margin-top: -10px;
            /*overflow: hidden;*/
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            min-height: 320px;
            align-items:flex-start;/*项目位于容器开头,不要居中center！！*/
            flex-direction: column;
        }
        .eval_body{
            width: 500px;
            height: 280px;
            background-color: #fff;
            margin-left: 50px;
            margin-top: 40px;
            border: 2px solid #409eff;
            border-radius: 20px;
            padding: 20px 20px;
            transition: all .2s linear;
            float: left;
        }
        .eval_body:hover{
            box-shadow: 0 15px 30px rgba(91, 186, 234, 0.5);
            transform: translateY(-2px);;
        }
        .eval_body>li{
            text-align: left;
            padding: 5px 5px;
        }
        .eval_body>li:nth-child(4)>ul>li{
            float: left;
        }
        .eval_body>li:first-child{
            font-size: 18px;
            color: #616161;
            height: 20px;
        }
        .eval_body>li:nth-child(2){
            font-size: 16px;
            color: #b0b0b0;
            height: 18px;
        }
        .eval_body>li:nth-child(3)>span{
            font-weight:800;
        }
        .eval_body>li:nth-child(3){
            color: #b0b0b0;
            font-size: 16px;
            height: 18px;
        }
        .eval_body>li:nth-child(4){
            position: relative;
            height: 40px;
            margin-top: 15px;
        }
        .eval_body>li:nth-child(4)>ul:first-child{
            left: 5px;
            top: 10px;
            color: #616161;
        }
        .eval_body>li:nth-child(4)>ul{
            position: absolute;
            left: 90px;
        }
        .eval_body>li:last-child{
            color: #616161;
        }
        /*评论部分结束*/
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

<!--主体部分开始-->
<div class="container">
    <div class="wrap">
        <%
            String shopid = request.getParameter("shopid");
            if (shopid==null){
                shopid = "";
            }
            String backid = request.getParameter("backid");
            if (backid==null){
                backid = "";
            }
            /*判断非指定页面进入重定向error的方法*/
            /*不能加这个，要不然有错*/
//            String mess=request.getHeader("referer");
//            if (mess==null){
//                mess="";
//            }
//            if (!(mess.contains("shopid")||mess.contains("backid"))){
//                response.sendRedirect("error.jsp");
//            }
            String sql4 = "select `picture`,`name`,`describe`,`price`,`color`,`param`,`id` from commodity where id=?";
            pst = con.prepareStatement(sql4);
            if (!Objects.equals(shopid, "") && Objects.equals(backid, "")){
                pst.setInt(1, Integer.parseInt(shopid));
            }else if(Objects.equals(shopid, "") && !Objects.equals(backid, "")){
                pst.setInt(1, Integer.parseInt(backid));
            }
            rs = pst.executeQuery(); //相当于重新给rs赋值，不冲突
            if(rs != null){
                while(rs.next()){
        %>
        <div class="shopimg">
            <img src="<%=rs.getString(1)%>" alt="">
        </div>
        <div class="shopinfo">
            <div class="haha">
                <h2><%=rs.getString(2)%></h2>
            </div>
            <p class="p1"><%=rs.getString(3)%></p>
            <p class="p2">旗舰店自营</p>
            <div class="shopprice">
                <span>
                    <%=rs.getString(4).substring(0,rs.getString(4).length()-3)%>元
                    <del><%=Integer.parseInt(rs.getString(4).substring(0,rs.getString(4).length()-3))+200%>元</del>
                </span>
            </div>
            <div style="font-size: 18px ;margin-top:15px">选择颜色</div>
            <div class="selcolor">
                <select>
                    <option><%=rs.getString(5)%></option>
                </select>
            </div>
            <div style="font-size: 18px ;margin-top:15px">选择参数</div>
            <div class="sellist">
                <!--必须用for关联起来二者-->
                <input type="radio" name="zoom" id="zoom1" required="required" checked="checked"/><label for="zoom1"><%=rs.getString(6)%></label>
<%--                <input type="submit" id="s1" style="display: none" value="">--%>
            </div>
            <div style="font-size: 18px ;margin-top:15px">选择数量</div>
            <div class="number-box">
                    <%
                        String shu = request.getParameter("shu");
                        if (shu==null){
                            shu = "1";
                        }
//                        request.setAttribute("shu", shu);/*这个方法是一次性的，如果设置值的本次没有跳转，下次再跳转也不能用了*/
                        HashMap<String, String> map = new HashMap<>();
                        if (shu.matches("^[1-9][0-9]*$")) {
//                          session.setAttribute("shu", shu);/*可以用session方法，每个用户都会有一个session变量*/
                            map.put("1", shu);
                        }else{
                            map.remove("1");
                        }
                    %>
                <form action="#" method="post">
                    <button type="submit" class="on-number" data-v="-1">-</button>
                    <input type="text" value="<%=shu%>" name="shu" pattern="^[1-9][0-9]*$" required>
                    <button type="submit" class="on-number" data-v="1">+</button>
                </form>
                <%--下面这个表单是不可见的--%>
<%--                <form action="shopcart.jsp">--%>
<%--                    <div style="display: none">--%>
<%--                    <input type="text" value="<%=shu%>" name="shu2">--%>
<%--                    <input type="submit" id="s1"> &lt;%&ndash;提交按钮不需要name，input才需要&ndash;%&gt;--%>
<%--                    </div>--%>
<%--                </form>--%>
            </div>
            <div class="sumprice">
                <ul class="pricetop">
                    <li class="li1"><%=rs.getString(2)%></li>
                    <li>
                        <%=rs.getString(4).substring(0,rs.getString(4).length()-3)%>元
                        <del><%=Integer.parseInt(rs.getString(4).substring(0,rs.getString(4).length()-3))+200%>元</del>
                    </li>
                </ul>
                <ul class="pricebottom">
                    <li>单价：<%=rs.getString(4).substring(0,rs.getString(4).length()-3)%>元</li>
                </ul>
            </div>
<%--            <%--%>
<%--                String id = rs.getString(7);--%>
<%--                session.setAttribute("id", id);--%>
<%--            %>--%>
            <div class="salelist">
                <form action="cartsuccess.jsp" method="post">
                    <%
                        String liang = map.get("1");
                        String param = "";
                        if (liang!=null){
                            param = liang+"#"+rs.getString(7);
                        }
                    %>
                    <input type="hidden" value="<%=param%>" name="param">
<%--                    <button type="submit" class="addcart" onclick="submitall()">--%>
                    <button type="submit" class="addcart">
                        加入购物车
                    </button>
                </form>
            </div>
            <div class="infolist">
                <ul>
                    <li>
                        <i class="icon-kongxinduigou iconfont"></i>
                        <div id="hidebox">
                            <p onClick="hide();" style="cursor:pointer">关闭</p>
                            <span>
                                <br>由玩家国度旗舰店发货商品(不含有品),单笔满500元免运费;<br>
                               由官方发货的商品,免运费;<br>
                               由第三方商家发货的商品，运费以实际结算金额为准;<br>
                               特殊商品需要单独收取运费,具体以实际结算金额为准;优惠券等不能抵扣运费金额;如需无理由退货,用户将承担该商品的退货物流费用;<br>
                               使用门店闪送服务，需单独支付10元运费。<br>
                            </span>
                        </div>
                        <span class="content" onClick="show();">玩家国度自营</span>
                    </li>
                    <li>
                        <i class="icon-kongxinduigou iconfont"></i>
                        <span class="content">玩家国度发货</span>
                    </li>
                    <li>
                        <i class="icon-kongxinduigou iconfont"></i>
                        <span class="content">7天无理由退货</span>
                    </li>
                    <li>
                        <i class="icon-kongxinduigou iconfont"></i>
                        <span class="content">运费说明</span>
                    </li>
                    <li>
                        <i class="icon-kongxinduigou iconfont"></i>
                        <span class="content">企业信息</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <%
            }
        }
    %>
</div>
<div id="hidebg"></div>
<%--评论部分开始--%>
<div style="margin-top: 60px"></div>
<h2 class="words">
    <span>历史评价</span>
</h2>
<div class="eval">
    <div class="wrap">
        <%
            double grades = 0;
            int sumgrade = 0;
            int i = 0;
            String sql5 = "select `u_id`,`content`,`time`,`grade` from evaluate where s_id=?";
            pst = con.prepareStatement(sql5);
            if (!Objects.equals(shopid, "") && Objects.equals(backid, "")){
                pst.setInt(1, Integer.parseInt(shopid));
            }else if(Objects.equals(shopid, "") && !Objects.equals(backid, "")){
                pst.setInt(1, Integer.parseInt(backid));
            }
            rs = pst.executeQuery();
            String uname = "";
            while (rs.next()){
                i++;
                String grade = rs.getString(4);
        %>
                <script>
                    $(function () {
                        $("#stars<%=i%>").sets<%=i%>(<%=grade%>);
                    });
                </script>
        <%
                sumgrade = sumgrade + Integer.parseInt(grade);
                int uid = rs.getInt(1);
                String sql7 = "select `username` from user where user_id=?";
                pst = con.prepareStatement(sql7);
                pst.setInt(1, uid);
                rs2 = pst.executeQuery();
                if (rs2.next()){
                    uname = rs2.getString(1);
                }
                /*在查commodity的时候，是商品号的id，而不是s_id*/
                String sql6 = "select `name`,`describe` from commodity where id=?";
                pst = con.prepareStatement(sql6);
                if (!Objects.equals(shopid, "") && Objects.equals(backid, "")){
                    pst.setInt(1, Integer.parseInt(shopid));
                }else if(Objects.equals(shopid, "") && !Objects.equals(backid, "")){
                    pst.setInt(1, Integer.parseInt(backid));
                }
                rs3 = pst.executeQuery();
                if(rs3.next()){
        %>
        <ul class="eval_body">
            <li>
                用户：<%=uname%>
            </li>
            <li>
                <%=rs.getString(3).substring(0,rs.getString(3).length()-2)%>
            </li>
            <li>
                <span>|</span>  已购商品：<%=rs3.getString(1)%> <%=rs3.getString(2)%>
            </li>
            <li>
                <ul>评价等级：</ul>
                <ul id="stars<%=i%>">
                    <li><img src="images/star.PNG" id="star1<%=i%>"></li>
                    <li><img src="images/star.PNG" id="star2<%=i%>"></li>
                    <li><img src="images/star.PNG" id="star3<%=i%>"></li>
                    <li><img src="images/star.PNG" id="star4<%=i%>"></li>
                    <li><img src="images/star.PNG" id="star5<%=i%>"></li>
                </ul>
            </li>
            <li>
                <%=rs.getString(2)%>
            </li>
        </ul>
            <%
                }
            %>
        <script>
            /*jq中自定义方法：但是必须写在自执行函数的外面，调用自定义函数的代码必须写在自执行函数的里面*/
            $.fn.sets<%=i%> = function(param){
                if(param === 1){//打分是1，设置第一颗星星亮，其他星星暗
                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star2<%=i%>").attr("src","images/star.PNG");
                    $("#star3<%=i%>").attr("src","images/star.PNG");
                    $("#star4<%=i%>").attr("src","images/star.PNG");
                    $("#star5<%=i%>").attr("src","images/star.PNG");
                    <%--console.log($("#grade<%=i%>").var())--%>
                }else if(param === 2){
                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star3<%=i%>").attr("src","images/star.PNG");
                    $("#star4<%=i%>").attr("src","images/star.PNG");
                    $("#star5<%=i%>").attr("src","images/star.PNG");
                }else if(param === 3){
                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star3<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star4<%=i%>").attr("src","images/star.PNG");
                    $("#star5<%=i%>").attr("src","images/star.PNG");
                }else if(param === 4){
                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star3<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star4<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star5<%=i%>").attr("src","images/star.PNG");
                }else if(param === 5){
                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star3<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star4<%=i%>").attr("src","images/yellowstar.PNG");
                    $("#star5<%=i%>").attr("src","images/yellowstar.PNG");
                }else if(param === 0){
                    $("#star1<%=i%>").attr("src","images/star.PNG");
                    $("#star2<%=i%>").attr("src","images/star.PNG");
                    $("#star3<%=i%>").attr("src","images/star.PNG");
                    $("#star4<%=i%>").attr("src","images/star.PNG");
                    $("#star5<%=i%>").attr("src","images/star.PNG");
                }
            };
        </script>
        <%
            }
            int quantity;
            if (sumgrade==0){
                 quantity = 1;
            }else{
                 quantity = 0;
            }
            String sql9 = "select count(`content`) from evaluate where s_id=?";
            pst = con.prepareStatement(sql9);
            pst.setInt(1, Integer.parseInt(shopid));
            rs = pst.executeQuery();
            if (rs.next()){
                quantity = rs.getInt(1);
                DecimalFormat df = new DecimalFormat("0.0");//设置保留位数
                grades = Double.parseDouble(df.format((double)sumgrade/quantity));
                if (Double.isNaN(grades)){
                    grades=0.0;
                }
        %>
        <%--用js来插入元素，非常方便，不要再用绝对定位了，元素位置会乱掉的--%>
        <script>
            $(".shopinfo>.haha>h2").prepend("<span>综合评分：<%=grades%>分</span>")
        </script>
        <%
            }
        %>
    </div>
</div>

<!--主体部分结束-->
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
<script>
    $(document.documentElement).on("click", ".on-number", function() {
        /*点button对象从而取到input的jquery对象$val*/
        var $val = $(this).siblings("input[type='text']");
        /*保证第一个参数为10进制数字，.val()方法是取input的value值*/
        /*after是点击完按钮之后变成的值*/
        var after = parseInt($val.val(), 10) + parseInt($(this).data("v"));
        $val.val(isNaN(after)||after<=0 ? 0 : after);
    });
</script>
<script>
    function show()  //显示隐藏层和弹出层
    {
        var hideobj=document.getElementById("hidebg");
        hidebg.style.display="block";  //显示隐藏层
        //hidebg.style.height=document.body.clientHeight+"px";  //设置隐藏层的高度为当前页面高度
        document.getElementById("hidebox").style.display="block";  //显示弹出层
    }
    function hide()  //去除隐藏层和弹出层
    {
        document.getElementById("hidebg").style.display="none";
        document.getElementById("hidebox").style.display="none";
    }
</script>
<%--<script>--%>
<%--    function submitall() {--%>
<%--        $("#s1").click;--%>
<%--    }--%>
<%--</script>--%>
<script>
    $(function(){
        /*控制搜索框样式的js方法*/
        $(".search-list>p").on('click',function () {
            $("#in").val($(this).text());
            $(".search-list").css('display','none');
        }).hover(function () {
            $(".search-list").css('display','block');
        },function () {
            $(".search-list").css('display','none');
        });
        $(".search input").on('focus',function () {
            $(".search-list").css('display','block');
        }).hover(function () {
            $(".search-list").css('display','block');
        },function () {
            $(".search-list").css('display','none');
        });
    });
</script>
</body>
</html>
