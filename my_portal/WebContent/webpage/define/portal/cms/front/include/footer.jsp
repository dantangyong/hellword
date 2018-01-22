<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<style>
	#footer{
	    height: 100px;
	    background-color: #fff;
	    padding: 20px;
	    width: 100%;
	    text-align: center;
	    display: none;
	    margin-top:60px;
	    border-top:1px solid #e0dada;
	}
	#footer p{
	     font-size: 14px;
	}
	#footer p:first-child{
	     padding-bottom:10px;
	}
</style>
<footer class="container" id="footer">
    <div class="rollIn" data-wow-duration=".8s" data-wow-delay="3.5s">
        <p>${fns:getTagManage().edition} </p>
        <p>${fns:getTagManage().contactWays} </p>
    </div>
</footer>
<script type="text/javascript">
$(document).ready(function() {                                                                                                                                                                                                                                                                                                                                                                                                                                                     
	$(window).scroll(function() {
	    if ($(document).scrollTop() >= $(document).height() - $(window).height()) {
	    	$("#footer").css("display","block");
	    }
	  });
});
</script>
