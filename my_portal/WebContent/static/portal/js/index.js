/**
 * Created by mhout on 2017/7/21.
 */
$(function () {
    //鼠标滑动显示浮动窗口
    $(".hover-show").mouseenter(function () {
        $(".hover-window").show(500).mouseleave(function () {
            $(this).hide(500);
        })
    });
    $(".myApplication").mouseenter(function () {
    	  if($(".appContainer:has(a)").length==0){
    		  return;
    	  }
            $(".appContainer").show(500).mouseleave(function () {
                 $(this).hide(500);
            })
    });
// 换肤栏显示隐藏效果
    $(".change-skin").click(function() {
        $("#show-skin").slideDown();
        $("#wrap-skin").show().click(function (e) {
            if(e.target.id==="wrap-skin"){
                $(this).slideUp().children("#show-skin").slideUp()
            }
        });
    });
    $(".skin-up").click(function () {
        $("#wrap-skin").slideUp().children().slideUp();
    });
    $("#opacity").html('透明度:0%');
    $("#range").change(function () {
        var alpha=$(this).val();
        $("#opacity").html('透明度:'+alpha+'%');
        $(".wrap-box").css("background","rgba(0,0,0,"+alpha/100+")");
    });
});

