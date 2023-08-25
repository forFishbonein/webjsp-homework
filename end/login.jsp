<%@ page import="java.util.Random" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Aron
  Date: 2022/5/21
  Time: 0:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>玩家国度账号-登录</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath }/end/images/weblogo.ico">
    <link rel="stylesheet" type="text/css" href="css/register-login.css">
    <link rel="stylesheet" href="https://at.alicdn.com/t/font_3403513_lu024ohjdxe.css">
    <script src="https://lib.baomitu.com/jquery/3.6.0/jquery.js"></script>
    <style>
        .eject {
            display: none;
            width: 302px;
            height: 41px;
            background-color: #72aaec;
            /*垂直居中*/
            align-items: center;
            justify-content: center;
            color: #fff;
            position: absolute;
            bottom: 1px;
            right: 0;
            border-radius: 3px;
            margin-bottom: 60px;
        }
        .eject>span{
            line-height: 30px;
        }
        #xxx{
            width: 25px;
            height: 25px;
            background-color: #fff;
            border-radius: 12.5px;
            transition: all .3s;
            cursor: pointer;
            position: absolute;
            top: 7.5px;
            right: 5px;
        }
        #xxx:hover{
            background-color: #409eff;
        }
        #xxx>i{
            font-size: 18px;
        }
        #remember-me{
            position: absolute;
            left: 0;
            top: 8px;
            opacity: 0;
            cursor: pointer;
            width: 9px;
            height: 9px;
            background: #409eff;
            margin: 1px;
            display: block;
        }
    </style>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String verify = request.getParameter("verify");
    if (verify==null){
        verify = "";
    }
    String email = request.getParameter("email");
    if (email==null){
        email = "";
    }
    String password1 = request.getParameter("password1");
    if (password1==null){
        password1 = "";
    }
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
    //用cookie保存用户输入信息的方法——>7天保存！！！
    // 用户邮箱
    String uemail = "";
    // 登录密码
    String pass = "";
    // 复选框是否选中
    String checked = "";
    // 获取的是请求里的所有cookie组成的数组
    Cookie[] cookies = request.getCookies();
    // 如果cookies数组不为空对其进行遍历
    if (cookies != null && cookies.length > 0) {
        // 循环遍历Cookie
        for (int i = 0; i < cookies.length; i++) {
            // 获取Cookie对象
            Cookie cookie = cookies[i];
            // 将创建的cookie名与获取的cookie数组中已经存在的cookie名进行比较
            if ("email".equals(cookie.getName())) {
                // "name"是在另一个jsp文件中创建的cookie名
                // 获取名字叫做"name"的cookie的值
                uemail = cookie.getValue();
                // 将“记住我”设置为勾选
                checked = "checked";
            }
            // 将创建的cookie名与获取的cookie数组中已经存在的cookie名进行比较
            if ("password1".equals(cookie.getName())) {
                // "password"是在另一个jsp文件中创建的cookie名
                // 获取名字叫做"password"的cookie的值
                pass = cookie.getValue();
            }
        }
    }
%>
<div id="box"></div>
<div class="cent-box">
    <div class="cent-box-header">
        <a href="shoplist.jsp"><h1 class="main-title hide">玩家国度</h1></a>
        <h2 class="sub-title">玩家国度 - REPUBLIC OF GAMERS</h2>
    </div>

    <div class="cont-main clearfix">
        <div class="index-tab">
            <div class="index-slide-nav">
                <a href="login.jsp" class="active">登录</a>
                <a href="register.jsp">注册</a>
                <div class="slide-bar"></div>
            </div>
        </div>

        <form action="#" method="post">
            <div class="login form">
                <div class="group">
                    <div class="group-ipt email">
                        <input type="text" name="email" id="email" class="ipt" value="<%=uemail%>" placeholder="邮箱地址" required>
                    </div>
                    <div class="group-ipt password">
                        <input type="password" name="password1" id="password" class="ipt" value="<%=pass%>" placeholder="输入您的登录密码" required>
                    </div>
                    <div class="group-ipt verify">
                        <input type="text" name="verify" id="verify" class="ipt" placeholder="输入验证码" required>
                        <%!
                            public String produce(){
                                Random random = new Random();
                                String ran = "";
                                int number = 0;
                                for (int i = 0; i < 4; i++) {
                                    for (int j = 0; j < 10; j++) {
                                        number = random.nextInt(10);
                                    }
                                    ran = ran + number;
                                }
                                return ran;
                            }
                        %>
                        <% String ran = produce(); %>
                        <% String ver = (String)session.getAttribute("ver");
                            if (ver==null){
                                ver="";
                            }
                        %>
                        <%
                            session.setAttribute("ver",ran);
                        %>
                        <img src="http://www.webxml.com.cn/WebServices/ValidateCodeWebService.asmx/cnValidateImage?byString=<%=ran%>" class="imgcode">
                    </div>
                    <%
                            //最外面是大前提！！！，往里面的限制性依次减小！
                            if (!Objects.equals(email, "") && !Objects.equals(password1, "") &&!Objects.equals(verify, "")&& !Objects.equals(ver, "")) {
                                if (verify.equals(ver)) {
                                    String sql1 = "select `email` from user";
                                    pst = con.prepareStatement(sql1);
                                    rs = pst.executeQuery();
                                    int flag = 2; //正常状态是flag=2，异常为flag=1
                                    String em = "";
                                    while (rs.next()){
                                        em = rs.getString(1);
                                        if (em.equals(email)){ //邮箱正确的情况下
                                            flag = 1;
                                            break;
                                        }
                                    }
                                    if (flag==2) {
                    %>
                    <div class="eject">
                        <span>该邮箱还没有注册，请先注册！</span>
                        <button type="button" id="xxx"><i class="icon-chahao-copy iconfont"></i></button>
                    </div>
                    <%
                        }
                        if (flag==1){
                            String sql3 = "select `password`,`user_id` from user where `email`=?";
                            pst = con.prepareStatement(sql3);
                            pst.setString(1, em);
                            rs = pst.executeQuery();
                            if (rs.next()) {
                                if (rs.getString(1).equals(password1)) { //密码正确的情况下
                                    session.setAttribute("user_id", rs.getString(2));
                                    String sql11 = "select `state` from user where user_id=?";
                                    pst = con.prepareStatement(sql11);
                                    pst.setInt(1, Integer.parseInt(rs.getString(2)));
                                    rs2 = pst.executeQuery();
                                    if(rs2.next()){ //此时用户名密码完全正确
                                        //储存传到表单里面的值到cookie中的方法！！！
                                        // 新建名为name的Cookie
                                        Cookie nameCookie = new Cookie("email", email);
                                        // 新建名为password的Cookie
                                        Cookie passwordCookie = new Cookie("password1", password1);

                                        // 设置Cookie的使用路径
                                        nameCookie.setPath(request.getContextPath() + "/");
                                        passwordCookie.setPath(request.getContextPath() + "/");

                                        // 获取是否保存Cookie
                                        String rememberme = request.getParameter("remember-me");
                                        if (rememberme==null){
                                            rememberme="";
                                        }
                                        // 判断复选框是否被选中，如果选中则返回on
                                        if (rememberme.equals("on")) {
                                            // 设置保存Cookie的时间长度，单位为秒
                                            nameCookie.setMaxAge(7 * 24 * 60 * 60); //可以保存7天
                                            passwordCookie.setMaxAge(7 * 24 * 60 * 60);
                                        } else {
                                            // 设置不保存Cookie
                                            nameCookie.setMaxAge(0);
                                            passwordCookie.setMaxAge(0);
                                        }
                                        // 输出到客户端——>必须要有，否则之前设置的Cookie.setPath白费，因为浏览器接收不到这个cookie的响应！！！
                                        response.addCookie(nameCookie);
                                        response.addCookie(passwordCookie);

                                        if (rs2.getString(1).equals("admin")||rs2.getString(1).equals("superadmin")){
                                            response.sendRedirect("shopadmin.jsp");
                                        }else{
                                            response.sendRedirect("shoplist.jsp");
                                        }
                                    }
                                }else{
                    %>
                    <div class="eject">
                        <span>密码错误，请重新输入！</span>
                        <button type="button" id="xxx"><i class="icon-chahao-copy iconfont"></i></button>
                    </div>
                    <%
                                }
                            }
                        }
                    }else {
                    %>
                    <div class="eject">
                        <span>验证码输入错误，请重新输入！</span>
                        <button type="button" id="xxx"><i class="icon-chahao-copy iconfont"></i></button>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
            <div class="button">
                <button type="submit" class="login-btn register-btn" id="button">登录</button>
            </div>
            <div class="remember clearfix">
                <label class="remember-me">
                    <span class="icon">
                        <span class="zt"></span>
                    </span>
                    <%--其实checkbox的默认值value就是on--%>
                    <input type="checkbox" name="remember-me" id="remember-me" class="remember-mecheck" checked="<%=checked%>" value="on"> 记住我
                </label>
                <label class="forgot-password">
                    <a href="shopadmin.jsp">忘记密码？</a>
                </label>
            </div>
        </form>
    </div>
</div>

<div class="footer">
    <p>ROG - Republic Of Gamers</p>
    <p>沪ICP备11025349号-3 ©ASUSTeK Computer Inc. 2022</p>
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
<script src='js/particles.js' type="text/javascript"></script>
<script src='js/background.js' type="text/javascript"></script>
<script src='js/jquery.min.js' type="text/javascript"></script>
<script src='js/layer/layer.js' type="text/javascript"></script>
<script src='js/index.js' type="text/javascript"></script>
<script>
    $('.imgcode').hover(function(){
        layer.tips("看不清？点击更换", '.verify', {
            time: 6000,
            tips: [2, "#3c3c3c"]
        })
    },function(){
        layer.closeAll('tips');
    }).click(function(){
        <%--$(this).attr('src','http://www.webxml.com.cn/WebServices/ValidateCodeWebService.asmx/cnValidateImage?byString=<%=produce()%>');--%>
        history.go(0);
    });
    $("#remember-me").click(function(){
        var n = document.getElementById("remember-me").checked;
        if(n){
            $(".zt").show();
        }else{
            $(".zt").hide();
        }
    });
    $(function() {
        $("#xxx").click(function () {
            $(".eject").fadeOut(1000);
        });
    });
    $(function() {
        $(".eject").fadeIn(500).css('display','flex');
    });
</script>
</body>
</html>
