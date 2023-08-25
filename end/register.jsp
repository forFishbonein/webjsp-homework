<%@ page import="java.util.Random" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: Aron
  Date: 2022/5/21
  Time: 10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>玩家国度账号-注册</title>
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
            margin-bottom: 21px;
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
        String user = request.getParameter("user");
        if (user==null){
            user = "";
        }
        String password1 = request.getParameter("password1");
        if (password1==null){
            password1 = "";
        }
        String password2 = request.getParameter("password2");
        if (password2==null){
            password2 = "";
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
        try {
            con = DriverManager.getConnection(url,username,password);
        //用cookie保存用户输入信息的方法——>7天保存！！！
        // 用户邮箱
        String userem = "";
        //用户名
        String userna = "";
        //登录密码
        String pass1 = "";
        //重复密码
        String pass2 = "";
        //获取的是请求里的所有cookie组成的数组
        Cookie[] cookies = request.getCookies();
        // 如果cookies数组不为空对其进行遍历
        if (cookies != null && cookies.length > 0) {
        // 循环遍历Cookie
            for (int i = 0; i < cookies.length; i++) {
                // 获取Cookie对象
                Cookie cookie = cookies[i];
                // 将创建的cookie名与获取的cookie数组中已经存在的cookie名进行比较
                if ("em".equals(cookie.getName())) {
                    userem = cookie.getValue();
                }
                // 将创建的cookie名与获取的cookie数组中已经存在的cookie名进行比较
                if ("na".equals(cookie.getName())) {
                    //中文要解码！！
                    userna = URLDecoder.decode(cookie.getValue(), "utf-8");
                }
                if ("pass1".equals(cookie.getName())) {
                    pass1 = cookie.getValue();
                }
                if ("pass2".equals(cookie.getName())) {
                    pass2 = cookie.getValue();
                }
            }
        }
    %>
<div id="box"></div>
<div class="cent-box register-box">
    <div class="cent-box-header">
        <a href="shoplist.jsp"><h1 class="main-title hide">玩家国度</h1></a>
        <h2 class="sub-title">玩家国度 - REPUBLIC OF GAMERS</h2>
    </div>

    <div class="cont-main clearfix">
        <div class="index-tab">
            <div class="index-slide-nav">
                <a href="login.jsp">登录</a>
                <a href="register.jsp" class="active">注册</a>
                <div class="slide-bar slide-bar1"></div>
            </div>
        </div>
        <form action="#" method="post">
            <div class="login form">
                <div class="group">
                        <div class="group-ipt email">
                            <input type="email" name="email" id="email" class="ipt" value="<%=userem%>" placeholder="邮箱地址" required>
                        </div>
                        <div class="group-ipt user">
                            <input type="text" name="user" id="user" class="ipt" value="<%=userna%>" placeholder="设置用户名" required>
                        </div>
                        <div class="group-ipt password">
                            <input type="password" name="password1" id="password" class="ipt" value="<%=pass1%>" placeholder="设置登录密码" required>
                        </div>
                        <div class="group-ipt password1">
                            <input type="password" name="password2" id="password1" class="ipt" value="<%=pass2%>" placeholder="重复密码" required>
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
                            <%--设置session在取session的后面。保证了取到的session是上一次没更新过的！！这样才可以让判断是否验证码正确--%>
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
            if (!Objects.equals(email, "") && !Objects.equals(user, "") && !Objects.equals(password1, "") && !Objects.equals(password2, "")&&!Objects.equals(verify, "")&& !Objects.equals(ver, "")) {
                        Cookie eamilCookie = new Cookie("em", email);
                        Cookie userCookie = new Cookie("na", URLEncoder.encode(user, "utf-8"));
                        Cookie passCookie1 = new Cookie("pass1", password1);
                        Cookie passCookie2 = new Cookie("pass2", password2);

                        // 设置Cookie的使用路径
                        eamilCookie.setPath(request.getContextPath() + "/");
                        userCookie.setPath(request.getContextPath() + "/");
                        passCookie1.setPath(request.getContextPath() + "/");
                        passCookie2.setPath(request.getContextPath() + "/");

                        eamilCookie.setMaxAge(5 * 60); //可以保存五分钟
                        userCookie.setMaxAge(5 * 60);
                        passCookie1.setMaxAge(5 * 60);
                        passCookie2.setMaxAge(5 * 60);

                        // 输出到客户端——>必须要有，否则之前设置的Cookie.setPath白费，因为浏览器接收不到这个cookie的响应！！！
                        response.addCookie(eamilCookie);
                        response.addCookie(userCookie);
                        response.addCookie(passCookie1);
                        response.addCookie(passCookie2);

                         if (verify.equals(ver)) {
                            if (password1.equals(password2)) {
                                String sql2 = "select `email` from user";
                                pst = con.prepareStatement(sql2);
                                rs = pst.executeQuery();
                                int flag = 1;
                                while (rs.next()){
                                    if (rs.getString(1).equals(email)){
                                        flag = 2;
                                        %>
                                        <div class="eject">
                                            <span>该邮箱已被注册！</span>
                                            <button type="button" id="xxx"><i class="icon-chahao-copy iconfont"></i></button>
                                        </div>
                                        <%
                                        break;
                                    }
                                }
                                if (flag==1){
                                    String sql1 = "INSERT INTO user(`email`,`username`,`password`,`state`) VALUES (?,?,?,?)";
                                    pst = con.prepareStatement(sql1);
                                    pst.setString(1, email);
                                    pst.setString(2, user);
                                    pst.setString(3, password1);
                                    pst.setString(4,"user");
                                    int ok = pst.executeUpdate();
                                    if (ok > 0) {
                                        %>
                                        <div class="eject">
                                            <span>注册成功！</span>
                                            <button type="button" id="xxx"><i class="icon-chahao-copy iconfont"></i></button>
                                        </div>
                                        <%
                                    }
                                }
                            }else{
                                %>
                                <div class="eject">
                                    <span>两次输入的密码不一致，请重新输入！</span>
                                    <button type="button" id="xxx"><i class="icon-chahao-copy iconfont"></i></button>
                                </div>
                                <%
                            }
                        }else {
                            %>
                            <div class="eject">
                                <span>验证码输入错误，请重新输入！</span>
                                <button type="button" id="xxx"><i class="icon-chahao-copy iconfont"></i></button>
                            </div>
                            <%
                        }
                    }else {

                    }
    %>
                </div>
            </div>
            <div class="button">
                <button type="submit" class="login-btn register-btn" id="button">注册</button>
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
        // $(this).attr('src','http://zrong.me/home/index/imgcode?id=' + Math.random());
        history.go(0);
    })

    $("#remember-me").click(function(){
        var n = document.getElementById("remember-me").checked;
        if(n){
            $(".zt").show();
        }else{
            $(".zt").hide();
        }
    })
    $(function() {
        $("#xxx").click(function () {
            $(".eject").fadeOut(1000);
        });
    });
    $(function() {
        $(".eject").fadeIn(500).css('display','flex');
    });
    //重置内容的方法：将里面所有内容清空，比type=reset更为强大，type=reset只是把值还原为value里面默认的而已
    // $(function () {
    //     $("#button").click(function () {
    //         $("#fo :input").not(":button, :submit, :reset, :hidden").val("").removeAttr("checked").remove("selected");
    //     });
    // });
</script>
</body>
</html>
