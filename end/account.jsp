<%--
  Created by IntelliJ IDEA.
  User: Aron
  Date: 2022/5/19
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Rog玩家国度</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath }/end/images/weblogo.ico">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/reset.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/end/css/account.css">
    <link rel="stylesheet" href="https://at.alicdn.com/t/font_3403513_lu024ohjdxe.css">
    <link rel="stylesheet" href="https://at.alicdn.com/t/font_3309454_cew0v4vzrp7.css">
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
    PreparedStatement pst2 = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    try {
        con = DriverManager.getConnection(url, username, password);
%>
<%
    /*注销的方法*/
    String com = request.getParameter("com");
    if (com==null){
        com = "";
    }
    if (com.equals("exit")){
        session.removeAttribute("user_id");
//        response.sendRedirect("login.jsp"); 因为删除了这个id之后，后面会重定向，重定向不能重复，所以这句不用写
    }
%>
<!--头部开始-->
<div class="header">
    <ul class="header-left">
        <li><a href="shoplist.jsp"><img src="images/logo.png" alt=""/></a></li>
        <li>我的订单</li>
    </ul>
    <ul class="header-right">
        <li>
            <%
                String user_id = (String)session.getAttribute("user_id");
                if (user_id==null){
                    user_id="";
                }
                if (!Objects.equals(user_id, "")){
                    String sql8 = "select `username` from user where user_id=?";
                    pst = con.prepareStatement(sql8);
                    pst.setInt(1, Integer.parseInt(user_id));
                    rs = pst.executeQuery();
                    if(rs.next()){
            %>
                <%=rs.getString(1)%>
            <%
                    }
                }else {
                    response.sendRedirect("login.jsp");
                    /*不能重复调用response.sendRedirect，其跳转完后面的代码依然会执行*/
                }
            %>
            <i class="icon-xiangxiajiantou iconfont"></i>
            <div class="exit">
                <a href="account.jsp?com=exit">退出登录</a>
            </div>
        </li>
    </ul>
</div>
<!--头部结束-->
<!--主体开始-->
<div class="container">
    <div class="wrap">
        <div style="margin-top: 30px"></div>
<%
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String time = dateFormat.format(new Date());// 2021/03/22 16:37:15
    String suball = "0";

    String mess=request.getHeader("referer");
    if (mess==null){
        mess = "";
    }
    if (mess.startsWith("http://localhost:8080/end/shopcart.jsp")||mess.startsWith("http://124.220.15.95:8080/webjsp/end/shopcart.jsp")){
        String idstr = request.getParameter("idstr");
        if (idstr == null){
            idstr = "";
        }
        if (!Objects.equals(idstr, "")){
            String[] idstr2 = idstr.split("/");
            suball = idstr2[0];
            String idstr3 = idstr2[1];

            String[] ids = idstr3.split("#");
            for (int i = 0;i<ids.length;i++){
                //因为第一个是空格，要略过去
                if(i>0) {
                    String sql1 = "select `quantity` from cart where s_id=? and u_id=?";
                    pst = con.prepareStatement(sql1);
                    pst.setInt(1, Integer.parseInt(ids[i]));
                    pst.setInt(2, Integer.parseInt(user_id));
                    rs = pst.executeQuery();
                    //取出来一行
                    if (rs.next()) { //如果结果集里面只有一个，那就用if，也可以用while，一定不要什么都不加
                        int quantity = rs.getInt(1);
                        String sql2 = "INSERT INTO `order`(`u_id`,`s_id`,`quantity`,`buy_date`) VALUES (?,?,?,?)";
                        pst = con.prepareStatement(sql2);
                        pst.setInt(1, Integer.parseInt(user_id));
                        pst.setInt(2, Integer.parseInt(ids[i]));
                        pst.setInt(3, quantity);
                        pst.setString(4, time);
                        int ok = pst.executeUpdate();
                        if (ok > 0) {
                        }
                        String sql3 = "delete from cart where s_id=? and u_id=?";
                        pst = con.prepareStatement(sql3);
                        pst.setInt(1, Integer.parseInt(ids[i]));
                        pst.setInt(2, Integer.parseInt(user_id));
                        int ok2 = pst.executeUpdate();
                        if (ok2 > 0) {
                        }
                    }
                }
            }
        }
%>
<%--这个是只有通过shopcart进来才会显示的--%>
        <div class="order">
            <div class="order-left">
                <i class="icon-tijiaochenggong iconfont"></i>
            </div>
            <div class="order-right">
               <div class="word-left">
                    <h2>恭喜您，订单支付成功！</h2>
                    <p>将尽快为您安排配送~</p>
               </div>
               <div class="word-right">
                   <div class="word1">
                       共计消费：
                       <em><%=suball%></em>
                       <span>元</span>
                   </div>
                   <button type="button" id="xxx"><i class="icon-chahao-copy iconfont"></i></button>
               </div>
            </div>
        </div>
        <script>
            $(function() {
                $(".order").fadeIn(1000).css('display','flex');
            });
        </script>
<%
    }//判断来源的if结束
%>
<%--这个是什么时候进来都会显示的--%>
        <div style="margin-top: 60px"></div>
        <h2 class="words">
            <span>历史订单</span>
        </h2>
        <div class="cart-list">
            <div class="list-header">
                <ul>
                    <li>
                    </li>
                    <li style="margin-left: 60px"></li>
                    <li>商品名称</li>
                    <li>单价</li>
                    <li>购买数量</li>
                    <li>总价</li>
                    <li>购买时间</li>
                </ul>
            </div>
        <%
            if(!Objects.equals(user_id, "")){
                String sql4 = "select `s_id`,`quantity`,`buy_date` from `order` where u_id=?";
                pst = con.prepareStatement(sql4);

                pst.setInt(1, Integer.parseInt(user_id));
                rs = pst.executeQuery();
                int quantity;
                int s_id;
                String date;
                int i = 0;
                /*开始输出所有商品*/
                while (rs.next()){
                    i++;
                    s_id = rs.getInt(1);
                    quantity = rs.getInt(2);
                    date = rs.getString(3).substring(0,rs.getString(3).length()-2);
                    //开始输出一行商品：
                    String sql5 = "select `picture`,`name`,`price` from commodity where id=?";
                    pst2 = con.prepareStatement(sql5);
                    pst2.setInt(1, s_id);
                    rs2 = pst2.executeQuery();
                    rs2.next();
            %>
            <div class="list-body">
                <div class="cart-list-shop">
                    <ul>
                        <li>
                        </li>
                        <li>
                            <div>
                                <img src="<%=rs2.getString(1)%>" alt="">
                            </div>
                        </li>
                        <li>
                            <%=rs2.getString(2)%>
                            <div><button type="button" class="pingjia<%=i%> rem<%=i%>">进行评价</button></div>
                        </li>
                        <%
                            int price = Integer.parseInt(rs2.getString(3).substring(0,rs2.getString(3).length()-3));
                        %>
                        <li><%=price%>元</li>
                        <li><%=quantity%></li>
                        <li><%=price*quantity%>元</li>
                        <li><%=date%></li>
                    </ul>
                </div>
            </div>
            <%
                String fen = request.getParameter("fen"+i);
                if (fen==null){
                    fen="";
                }
                String contents = request.getParameter("contents"+i);
                if (contents==null){
                    contents="";
                }
                if (!Objects.equals(fen, "")&& !Objects.equals(contents, "")&& !Objects.equals(user_id, "")){
                    String sql1 = "INSERT INTO evaluate(`u_id`,`s_id`,`content`,`time`,`grade`) VALUES (?,?,?,?,?)";
                    pst2 = con.prepareStatement(sql1);
                    pst2.setInt(1, Integer.parseInt(user_id));
                    pst2.setInt(2, s_id);
                    pst2.setString(3, contents);
                    pst2.setString(4,time);
                    pst2.setString(5,fen);
                    int ok = pst2.executeUpdate();
                    if (ok>0){
            %>
                <script>
                    $(".cart-list").before("<div class='result'>评价成功，感谢您的评价！</div>")
                    $(".result").fadeIn(500).fadeOut(3000);
                    $(".rem<%=i%>").removeClass("pingjia<%=i%>").text('已评价');
                </script>
            <%
                    }
                }
            %>
            <div id="ev<%=i%>" style="display: none;">
                <form action="#" method="post">
                <div class="evaluate">
                    <div class="e_header">
                        <ul class="eee">
                            <li>满意度评分：</li>
                            <input type="hidden" value="" id="grade<%=i%>" name="fen<%=i%>">
                            <li>
                                <ul>
                                    <li onclick="click<%=i%>(1)"><img src="images/star.PNG" id="star1<%=i%>" onMouseOver="over<%=i%>(1)" onMouseOut="out<%=i%>(1)"/></li>
                                    <li onclick="click<%=i%>(2)"><img src="images/star.PNG" id="star2<%=i%>" onMouseOver="over<%=i%>(2)" onMouseOut="out<%=i%>(2)"/></li>
                                    <li onclick="click<%=i%>(3)"><img src="images/star.PNG" id="star3<%=i%>" onMouseOver="over<%=i%>(3)" onMouseOut="out<%=i%>(3)"/></li>
                                    <li onclick="click<%=i%>(4)"><img src="images/star.PNG" id="star4<%=i%>" onMouseOver="over<%=i%>(4)" onMouseOut="out<%=i%>(4)"/></li>
                                    <li onclick="click<%=i%>(5)"><img src="images/star.PNG" id="star5<%=i%>" onMouseOver="over<%=i%>(5)" onMouseOut="out<%=i%>(5)"/></li>
                                </ul>
                            </li>
                            <li id="message<%=i%>"></li>
                        </ul>
                        <script>
                            //星星评价功能
                            var check<%=i%> = 0;//该变量是记录当前选择的评分
                            /*over()是鼠标悬停在星星上的效果*/
                            /*记录打分*/
                            function click<%=i%>(param){
                                check<%=i%> = param;//记录当前打分
                                out<%=i%>();//设置星星数
                            }
                            function over<%=i%>(param){
                                if(param === 1){
                                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");//第一颗星星亮起来
                                    $("#message<%=i%>").html("1分");//设置提示语，下面以此类推
                                }else if(param === 2){
                                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#message<%=i%>").html("2分");
                                }else if(param === 3){
                                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star3<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#message<%=i%>").html("3分");
                                }else if(param === 4){
                                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star3<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star4<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#message<%=i%>").html("4分");
                                }else if(param === 5){
                                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star3<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star4<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star5<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#message<%=i%>").html("5分");
                                }
                            }
                            /*out 方法是当鼠标移出时，恢复到我的打分情况*/
                            function out<%=i%>(){
                                if(check<%=i%> === 1){//打分是1，设置第一颗星星亮，其他星星暗
                                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star2<%=i%>").attr("src","images/star.PNG");
                                    $("#star3<%=i%>").attr("src","images/star.PNG");
                                    $("#star4<%=i%>").attr("src","images/star.PNG");
                                    $("#star5<%=i%>").attr("src","images/star.PNG");
                                    $("#message<%=i%>").html("");
                                    $("#grade<%=i%>").val("1");
                                    <%--console.log($("#grade<%=i%>").var())--%>

                                }else if(check<%=i%> === 2){
                                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star3<%=i%>").attr("src","images/star.PNG");
                                    $("#star4<%=i%>").attr("src","images/star.PNG");
                                    $("#star5<%=i%>").attr("src","images/star.PNG");
                                    $("#message<%=i%>").html("");
                                    $("#grade<%=i%>").val("2");
                                }else if(check<%=i%> === 3){
                                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star3<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star4<%=i%>").attr("src","images/star.PNG");
                                    $("#star5<%=i%>").attr("src","images/star.PNG");
                                    $("#message<%=i%>").html("");
                                    $("#grade<%=i%>").val("3")
                                }else if(check<%=i%> === 4){
                                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star3<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star4<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star5<%=i%>").attr("src","images/star.PNG");
                                    $("#message<%=i%>").html("");
                                    $("#grade<%=i%>").val("4")
                                }else if(check<%=i%> === 5){
                                    $("#star1<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star2<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star3<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star4<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#star5<%=i%>").attr("src","images/yellowstar.PNG");
                                    $("#message<%=i%>").html("");
                                    $("#grade<%=i%>").val("5");
                                }else if(check<%=i%> === 0){
                                    $("#star1<%=i%>").attr("src","images/star.PNG");
                                    $("#star2<%=i%>").attr("src","images/star.PNG");
                                    $("#star3<%=i%>").attr("src","images/star.PNG");
                                    $("#star4<%=i%>").attr("src","images/star.PNG");
                                    $("#star5<%=i%>").attr("src","images/star.PNG");
                                    $("#message<%=i%>").html("");
                                    $("#grade<%=i%>").val("0");
                                }
                            }
                        </script>
                    </div>
                    <div class="e_body">
                        <label>
                            <textarea name="contents<%=i%>" value="" placeholder="从多个角度评价商品，可以帮助更多想买的人！(最多输入300个字符)" class="ininin" rows="8" maxlength="300" onchange="this.value=this.value.substring(0, 300)" onkeydown="this.value=this.value.substring(0, 300)" onkeyup="this.value=this.value.substring(0, 300)"></textarea>
                        </label>
                    </div>
                </div>
                <div class="e_footer">
                    <button type="submit">发布</button>
                </div>
                </form>
            </div>
            <script>
                $(".pingjia<%=i%>").click(function () {
                    if($("#ev<%=i%>").css("display")=="none"){
                        $("#ev<%=i%>").show();
                    }else{
                        $("#ev<%=i%>").hide();
                    }
                });
            </script>
            <%
                    }
                }
            %>
        </div>
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
<!--尾部结束-->
<div id="box" class="box">
    <div class="box-in"></div>
</div>
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
//    response.sendRedirect("account.jsp");
%>
<script>
    $(function() {
        $("#xxx").click(function () {
            $(".order").fadeOut(1000);
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
</body>
</html>
