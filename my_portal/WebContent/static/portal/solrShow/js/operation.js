/**
 * Created by mhout on 2017/7/11.
 */
$(function(){
    $(".readonly-rate").raty({
        readOnly:true,
        number : 5,//星星个数
        path : '/mht_portal/static/portal/images',//图片路径
        starOn : 'yellowStar-s.png',
        starOff : 'grayStar-s.png',
        starHalf:'halfStar.png',
        hints : ['很差','一般','不错','很好','满意'],
        score: function() {
            return $(this).attr('data-score');
        }
    });
    $(".rate").raty({
        number : 5,//星星个数
        path : '/mht_portal/static/portal/images',//图片路径
        starOn : 'yellowStar.png',
        starOff : 'grayStar.png',
        target : '.title',//
        hints : ['很差','一般','不错','很好','满意'],
        score: function() {
            return $(this).attr('data-score');
        }
    });
    var wow = new WOW({
        boxClass: 'wow',
        animateClass: 'animated',
        offset: 0,
        mobile: true,
        live: true
    });
    wow.init();
    $(".tab-content").on("click",".service-item",function () {
        $('#myModal').modal('show');
    });
    $("button:contains('评价')").click(function () {
        $("#show-star").show();
    });
    $(".btn-pages").on("click","button",function () {
        $(this).addClass("active").siblings("button").removeClass("active");
    });
});