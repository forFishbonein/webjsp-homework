/*原理：*/
$(function(){
    /*提升timer的作用域*/
    var timer = null;
    /*获取li的宽度*/
    var liW = $(".banner ul li:first").innerWidth();
    /*
    （1）用来计数，表示当前的选中圆点是第几个
    （2）用来管理给第几个span添加class.on
    */
    var n = 0;
    /*获取li的个数*/
    var liN = $(".banner ul li").length; /*不能加括号，length是属性*/
    /*设置一个定时器*/
    timer = setInterval(function () {
        play();
    },3000);/*后面的参数是周期时间*/

    /*鼠标经过轮播区域时，轮播暂停，鼠标离开时，轮播继续*/
    $(".banner").hover(function () {
        /*鼠标放上来时，清楚timer定时器*/
        clearInterval(timer);
    },function () {
        timer = setInterval(function () {
            play();
        },2000);
    })

    /*点击向右箭头的效果*/
    $(".next").click(function () {
        play();
    })

    /*点击向左箭头的效果*/
    $(".prev").click(function () {
        rollbackplay();
    })


    /*切换动画：封装成play函数*/
    function play() {
        /*
        * 1.先将ul向左移动一个li的长度（整个里面所有的li会跟着移动，但是显示窗口是不变的）（这时会显示第二个图片），然后将一个li从队头带出去
        * 2.在执行1之后（动画移动），将ul的left值回归（让原来的第二个变成现在的第一个，再将第一个li带回来到队列末尾）（最终结果为li的第一个到了最后一个）
        * */
        /*让ul形成动画队列*/
        /*让ul每次向左移动一个li的距离*/
        $(".banner ul").animate({left:-liW},function () {
            /*将当前的left值置为0，将li添加到队列末尾，链式编程*/
            /*此时this就是banner下的ul*/
            $(this).css("left",0).find("li:first").appendTo(this);
        }); /*第二个参数为回调函数*/
        n++; /*计数*/
        if(n>liN-1){/*一共有五个，当过了第五个时就要重新开始计数了，给第一个(0)加class*/
            n = 0;
        }
        /*eq() 方法返回被选元素中带有指定索引号的元素*/
        /*siblings()方法代表被选中元素的兄弟元素，也就是兄弟元素都去除class类*/
        $(".banner .num span").eq(n).addClass("on").siblings().removeClass("on");
    }


    /*往回切换的动画*/
    function rollbackplay() {
        /*
        * 1.先将ul向左移动一个li的宽度，同时，将最后的一个li追加到ul最前面（最终结果为li的最后一个到了最前面）
        * 2.执行动画，ul的left值变为0（形成向右移动的效果）
        */
        /*谁点击的这个，这个this就指的是谁*/
        /*此时的this指的是.prev，所以不能用this*/
        $(".banner ul").css("left",-liW).find("li:last").prependTo(".banner ul");
        $(".banner ul").animate({left:0});
        n--;
        if (n<0){
            n = liN-1;
        }
        $(".banner .num span").eq(n).addClass("on").siblings().removeClass("on");
    }

    /*
    * 点击span进行切换的实现：
    * 当前的span的index值就是我们存储的n的值
    * 点击span时，得到想要到达的span的index值
    * 1.判断得到的index值是大于还是小于n
    * 如果小于n，就通过for循环执行n到index的次数（不包括index,要++）的向左循环切换效果
    * 如果大于n，就通过for循环执行n到index的次数（不包括index,要--）的向右循环切换效果
    * 2.将index赋值给n，更新当前所在的span位置n，给当前span加上class
    */
    $(".banner .num span").each(function (index) { /*用each遍历,得到元素的索引index*/
        $(this).click(function () {
            if(n < index){
                for(var i = n;i < index;i++){ /*切换index-n次*/
                    /*切换要很快，只间隔100毫秒*/
                    $(".banner ul").animate({left:-liW},100,function () {
                        $(this).css("left",0).find("li:first").appendTo(this);
                    })
                }
            }else if (n > index){
                for(var i = n;i > index;i--){
                    $(".banner ul").css("left",-liW).find("li:last").prependTo(".banner ul");
                    $(".banner ul").animate({left:0});
                }
            }
            n = index; /*将当前所在span的n值更新*/
            $(".banner .num span").eq(n).addClass("on").siblings().removeClass("on"); /*设置圆圈效果*/
        })
    })
    $(".items2").hover(function () {
        /*淡入淡出*/
        $(this).find(".block").fadeOut();
        $(this).find(".button").fadeIn();
    },function () {
        $(this).find(".block").fadeIn();
        $(this).find(".button").fadeOut();
    })
})