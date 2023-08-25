<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Iterator" %>
<%--
  Created by IntelliJ IDEA.
  User: Aron
  Date: 2022/5/16
  Time: 23:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Rog玩家国度</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath }/end/images/weblogo.ico">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/reset.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/shopcart.css">
    <link rel="stylesheet" href="https://at.alicdn.com/t/font_3403513_fenry85csl8.css">
    <style>
        .cart-list-shop>ul>li:last-child>form>button{
            width: 25px;
            height: 25px;
            background-color: #fff;
            border-radius: 12.5px;
            transition: all .3s;
            cursor: pointer;
        }
        .cart-list-shop>ul>li:last-child>form>button:hover{
            background-color: #409eff;
        }
        .cart-list-shop>ul>li:last-child>form>button>i{
            font-size: 18px;
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
        .cart-list-foot>ul>li:nth-child(2) a{
            display: inline-block;
            width: 200px;
            height: 52px;
            background-color: #72aaec;
            font-size: 16px;
            color: #fff;
        }
        .cart-list-foot>ul>li:nth-child(2) a:hover{
            background-color: #409eff;
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
<!--头部开始-->
<div class="header">
    <div class="wrap">
        <ul class="header-left">
            <li><a href="shoplist.jsp"><img src="images/logo.png" alt=""/></a></li>
            <li>我的购物车</li>
            <li>温馨提示：产品是否购买成功，以最终下单为准哦，请尽快结算</li>
        </ul>
        <ul class="header-right">
            <li><a href="shoplist.jsp?com=exit">退出登录</a><span>|</span></li>
            <li><a href="register.jsp">注册</a></li>
        </ul>
    </div>
</div>
<!--头部结束-->
<!--主体开始-->
<%--<%--%>
<%--    String shu = (String) session.getAttribute("shu"); /*取出来是Object类型，必须要向下转型一下*/--%>
<%--    if (shu == null){--%>
<%--        shu = "";--%>
<%--    }--%>
<%--    String id = request.getParameter("id");--%>
<%--    if (id == null){--%>
<%--        id = "";--%>
<%--    }--%>
<%--%>--%>
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
    PreparedStatement pst2 = null;
    PreparedStatement pst3 = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;
    ResultSet rs4 = null;
%>
<%
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
<%
    /*判断登陆与否的方法，没登录返回shoplist的方法*/
    String user_id = (String)session.getAttribute("user_id");
    if (user_id==null){
        user_id="";
    }
    if (Objects.equals(user_id, "")){
        response.sendRedirect("login.jsp");
        /*不能重复调用response.sendRedirect，其跳转完后面的代码依然会执行*/
    }
%>

<div class="container">
    <div class="wrap">
        <div style="margin-top: 30px"></div>
        <div class="cart-list">
            <div class="list-header">
                <ul>
                    <li>
                        <div style="width: 20px;height: 20px;margin-right: 10px;float: left"></div>
                        <div style="float: right;position: relative;left: -30px">选择</div>
                    </li>
                    <li style="margin-left: 40px"></li>
                    <li>商品名称</li>
                    <li>单价</li>
                    <li>数量</li>
                    <li>小计</li>
                    <li>操作</li>
                </ul>
            </div>
<%--            <%--%>
<%--                String quantity = request.getParameter("quantity");--%>
<%--                if (quantity==null){--%>
<%--                    quantity = "0";--%>
<%--                }--%>
<%--            %>--%>
            <%
                int suball = 0;
                int select = 0;
                if (!Objects.equals(user_id, "")){
                    HashSet<Integer> ids = new HashSet<>(); //为了保证元素不重复
                    String sql2 = "select `s_id`,`quantity` from cart where u_id=?";
                    pst = con.prepareStatement(sql2);
                    pst.setInt(1, Integer.parseInt(user_id));
                    rs = pst.executeQuery();
                    int i = 0;
                    int quantity;
                    int s_id;

                //开始输出所有商品
                while (rs.next()){
                    i++;
                    s_id = rs.getInt(1);
                    quantity = rs.getInt(2);

                    //控制数量增减的方法
                    String change = request.getParameter("change"+i);
                    if (change == null){
                        change = "0";
                    }
                    if (change.equals("1") || change.equals("-1")){
                        if(quantity+Integer.parseInt(change)==0){
                            String sql9 = "delete from cart where s_id=?";
                            pst3 = con.prepareStatement(sql9);
                            pst3.setInt(1, s_id);
                            int ok3 = pst3.executeUpdate();
                            if (ok3>0){
                                request.removeAttribute("change"+i);
                                response.sendRedirect("#");
                            }
                        }else {
                            String sql4 = "update cart set `quantity`= ? where s_id = ?";
                            pst3 = con.prepareStatement(sql4);
                            pst3.setInt(1, quantity + Integer.parseInt(change));
                            pst3.setInt(2, s_id);
                            int ok2 = pst3.executeUpdate();

                            if (ok2>0){
//                              change = "0";
                                request.removeAttribute("change"+i);
                                response.sendRedirect("#");
                            }
                        }
                    }
                    //控制商品删除的方法
                    String removex = request.getParameter("removex"+i);
                    if (removex == null){
                        removex = "0";
                    }
                    if (removex.equals("x")){
                        String sql5 = "delete from cart where s_id=?";
                        pst3 = con.prepareStatement(sql5);
                        pst3.setInt(1, s_id);
                        int ok2 = pst3.executeUpdate();
                        if (ok2>0){
                            request.removeAttribute("removex"+i);
                            response.sendRedirect("#");
                        }
                    }
                    //开始输出一行商品：
                    String sql3 = "select `picture`,`name`,`price` from commodity where id=?";
                    pst2 = con.prepareStatement(sql3);
                    pst2.setInt(1, s_id);
                    rs2 = pst2.executeQuery();
                    rs2.next(); /*实际上每次就只有一行数据*/
            %>
            <div class="list-body">
                <div class="cart-list-shop">
                    <ul>
                        <li>
                            <%
                                //根据提交的sid改变数据库中选中状态state参数的值的方法
                                String ssid = request.getParameter("ssid"+i);
                                if (ssid == null){
                                    ssid = "";
                                }
                                if (!Objects.equals(ssid, "")) {
                                    String sql7 = "select `state`from cart where s_id = ?";
                                    pst2 = con.prepareStatement(sql7);
                                    pst2.setInt(1, Integer.parseInt(ssid));
                                    rs3 = pst2.executeQuery();
                                    rs3.next();
                                    String state = rs3.getString(1);
                                    String sql6 = "update cart set `state`= ? where s_id = ?";
                                    pst2 = con.prepareStatement(sql6);
                                    if (state.equals("false")) {
                                        pst2.setString(1, "true");
                                    } else {
                                        pst2.setString(1, "false");
                                    }
                                    pst2.setInt(2, Integer.parseInt(ssid));
                                    int ok3 = pst2.executeUpdate();
                                    if (ok3 > 0) {
                                        request.removeAttribute("ssid" + i);
                                        response.sendRedirect("#");
                                    }
                                }
                            %>
                            <%
                                //根据state参数的不同展示不同的效果的判断语句：
                                String sql8 = "select `state`from cart where s_id = ?";
                                pst2 = con.prepareStatement(sql8);
                                pst2.setInt(1, s_id);
                                rs4 = pst2.executeQuery();
                                rs4.next();
                                String state2 = rs4.getString(1);
                                if (state2.equals("false")){
                            %>
                            <form action="#" method="post">
                                <input type="hidden" value="<%=s_id%>" name="ssid<%=i%>">
                                <button type="submit" value="" class="sall color1"></button>
                            </form>
                            <%
                                }else{
                            %>
                            <form action="#" method="post">
                                <input type="hidden" value="<%=s_id%>" name="ssid<%=i%>">
                                <button type="submit" value="" class="sall img2"></button>
                            </form>
                            <%
                                }
                            %>
                        </li>
                        <li>
                            <div>
                                <img src="<%=rs2.getString(1)%>" alt="">
                            </div>
                        </li>
                        <li><%=rs2.getString(2)%></li>
                        <%
                            int price = Integer.parseInt(rs2.getString(3).substring(0,rs2.getString(3).length()-3));
                        %>
                        <li><%=price%>元</li>
                        <li class="number-box">
<%--                            <form action="#" method="post">--%>
<%--                                <input type="hidden" name="change" value="-1">--%>
<%--                                <button type="submit" class="on-number" data-v="-1">-</button>--%>
<%--                            </form>--%>
<%--                                <input type="text" value="<%=rs.getInt(2)%>" class="putin" name="quantity">--%>
<%--                            <form action="#" method="post">--%>
<%--                                <input type="hidden" name="change" value="1">--%>
<%--                                <button type="submit" class="on-number" data-v="1">+</button>--%>
<%--                            </form>--%>
                                <form action="#" method="post">
                                    <input type="hidden" name="change<%=i%>" value="-1">
                                    <button type="submit" class="on-number">-</button>
                                </form>
                                <input type="text" value="<%=quantity%>" class="putin" pattern="^[1-9][0-9]*$" required>
                                <form action="#" method="post">
                                    <input type="hidden" name="change<%=i%>" value="1">
                                    <button type="submit" class="on-number">+</button>
                                </form>
                        </li>
                        <li><%=price*quantity%>元</li>
                        <%
                            if(state2.equals("true")){
                                suball+=price*quantity;
                                select+=1;
                                ids.add(s_id);
                            }else{
                                ids.remove(s_id);
                            }
                        %>
                        <li>
                            <form action="#" method="post">
                                <button type="submit" value="x" name="removex<%=i%>"><i class="icon-chahao-copy iconfont"></i></button>
                            </form>
                        </li>
                    </ul>
                </div>
            </div>
                <%
                        } /*rs.next的尾括号*/
                %>
        </div>
        <div class="cart-list-foot">
            <ul>
                <li>
                    <a href="shoplist.jsp">继续购物</a>
                    <span>|</span>
                    已选择<span><%=select%> </span>件
                </li>
                <li>
                    <%
                        String idstr = "";
                        if(!ids.isEmpty()){
                            Iterator<Integer> it = ids.iterator(); //获取迭代器
                            while (it.hasNext()){
                                idstr = idstr + "#"+it.next(); //输出元素
                            }
                            idstr = suball+"/"+idstr;
                        }
                    %>
                    <form action="account.jsp">
                        <input type="hidden" name="idstr" value="<%=idstr%>">
                        <%
                            if(idstr.equals("")){
                        %>
                        <a href="shopmore.jsp">去选购</a>
                        <%
                            }else{
                        %>
                        <button type="submit">结算</button>
                        <%
                            }
                        }
                        %>
                    </form>
                </li>
                <li>合计：<span><%=suball%></span>元</li>
            </ul>
        </div>
        <div style="margin-top: 60px"></div>
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
<!--主体结束-->
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
<div id="box" class="box">
    <div class="box-in"></div>
</div>
<%
    }catch (SQLException e) {
        e.printStackTrace();
    }finally {
        if (rs != null && rs2 !=null) {
            try {
                rs.close();
                rs2.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pst != null && pst2 != null && pst3 != null) {
            try {
                pst.close();
                pst2.close();
                pst3.close();
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
<!--尾部结束-->
<script src="https://lib.baomitu.com/jquery/3.6.0/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/end/js/shoplist.js"></script>
<script>
    $(function() {
        // $('.sall').click(function () {
        //     $(this).css('background-color', 'red');
        // })
        $(".sall").click(function(){
            if($(this).hasClass("color1")){
                $(this).removeClass("color1");
                $(this).addClass("img2");
            }else{
                $(this).removeClass("img2");
                $(this).addClass("color1");
            }
        });
    });
    $(window).on("scroll",function(){
        if ($(window).scrollTop()>=250){
            $("#box").fadeIn(700).css('display','block');
        }else{
            $("#box").fadeOut(700,function () {
                $("#box").css('display','none');
            });
        }
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
<%--<script>--%>
<%--    $(document.documentElement).on("click", ".on-number", function() {--%>
<%--        /*点button对象从而取到input的jquery对象$val*/--%>
<%--        // var $val = $(this).siblings("input[type='text']");--%>
<%--        var $val = $(".putin");--%>
<%--        /*保证第一个参数为10进制数字，.val()方法是取input的value值*/--%>
<%--        /*after是点击完按钮之后变成的值*/--%>
<%--        var after = parseInt($val.val(), 10) + parseInt($(this).data("v"));--%>
<%--        $val.val(isNaN(after)||after<=0 ? 0 : after);--%>
<%--    });--%>
<%--</script>--%>
</body>
</html>
