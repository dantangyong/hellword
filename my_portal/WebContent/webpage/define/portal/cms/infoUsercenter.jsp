<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head lang="zh-cn">
    <meta charset="UTF-8">
    <!--2 viewport-->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <!--3、x-ua-compatible-->
    <meta http-equiv="x-ua-compatible" content="IE=edge">
    <title>个人中心</title>
    <!--4、引入两个兼容文件-->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <!--6、引入 bootstrap.css-->
    <link rel="stylesheet" href="${ctxStatic }/portal/solrShow/css/bootstrap.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/css/infoUsercenter.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/solrShow/css/animate.css">
    <link rel="stylesheet" href="${ctxStatic }/portal/solrShow/css/jalendar.css">
</head>
<body>
	<!--导航栏-->
	<%@ include file="/webpage/define/portal/cms/front/include/navigation.jsp"%>
    <div class="container-fluid">
        <div class="row">
            <div class="co-xs-12">
                <div class="wrap-img">
                    <img src="${ctxStatic}/portal/images/usercenter-back.png">
                    <div class="user-info">
                        <div class="wrap-user pull-left dropdown-toggle" data-toggle="dropdown">
                            <img src="${ctxStatic}/portal/images/user-logo.png">
                        </div>
                        <div class="wrap-content pull-right">
                            <h4 class="text-center">${fns:getUser().name }</h4>
                            <p>
                                <span>学号：</span> <span>${fns:getUser().no }</span>
                                <br>
                                	您有 <a href="#" class="toDo"> 8 </a>条待办事项
                            </p>
                            <p><span>学院：</span> 信息工程学院</p>
                        </div>
                        <ul class="dropdown-menu edit-info">
                            <li>
                                <a href="#">
                                    <span class="glyphicon glyphicon-user"></span> 修改头像
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li><a href="#">
                                <span class="glyphicon glyphicon-lock"></span> 修改密码
                            </a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row top-distance">
            <div class="col-xs-12">
                <ul class="horizontal-nav">
                    <li class="active" >
                        <a href="#courseTable" data-toggle="tab">
                            <span class="glyphicon glyphicon-list-alt"></span>
                            课程表
                        </a>
                    </li>
                    <li>
                        <a href="#dayPlan" data-toggle="tab">
                            <span class="glyphicon glyphicon-calendar"></span>
                             日程安排
                        </a>
                    </li>
                    <li>
                        <a href="#to-do-things" data-toggle="tab">
                        <span class="glyphicon glyphicon-book"></span>
                        待办事项
                        </a>
                    </li>
                    <li>
                        <a href="#myCollection" data-toggle="tab">
                            <span class="glyphicon glyphicon-heart"></span>
                             我的收藏
                        </a>
                    </li>
                    <li>
                        <a href="#processTrace" data-toggle="tab">
                            <span class="glyphicon glyphicon-screenshot"></span>
                             流程跟踪
                        </a>
                    </li>
                    <li>
                        <a href="#personal-data" data-toggle="tab">
                            <span class="glyphicon glyphicon-info-sign"></span>
                             个人数据
                        </a>
                    </li>
                </ul>
            </div>
            <div class="col-xs-12">
                <div class="row tab-content">
                    <div class="col-xs-12 tab-pane active" id="courseTable">
                       <h2 class="text-center">课程表</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>周一</th>
                                        <th>周二</th>
                                        <th>周三</th>
                                        <th>周四</th>
                                        <th>周五</th>
                                        <th>周六</th>
                                        <th>周日</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td class="success">大学英语 <br>(7教201) <br> 钟敏</td>
                                        <td></td>
                                        <td class="danger" rowspan="2">高等数学 <br> (4教302) 高虎</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td></td>
                                        <td></td>
                                        <td class="warning">博弈论 <br> (3教 102)</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td class="info">大学语文 <br>(5教101) <br> 王雪</td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td class="danger">
                                            张老师
                                            <br>
                                            7教201上课
                                        </td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>6</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>7</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>8</td>
                                        <td></td>
                                        <td></td>
                                        <td class="warning" rowspan="2">大学体育 <br> (操场1)</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>9</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>10</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>11</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>12</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-xs-12 tab-pane" id="dayPlan">
                        <div id="calendar" class="jalendar mid">
                        </div>
                    </div>
                    <div class="col-xs-12 tab-pane" id="to-do-things">
                        <div class="panel panel-default pull-left wow rotateInDownLeft" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="panel-body">
                                <p class="text-left">
                                   张三发起的转正申请  <a href="#" class="pull-right">去处理</a>
                                </p>
                            </div>
                            <div class="panel-footer">
                                <span>7/25</span> <span class="pull-right">11:38</span>
                            </div>
                        </div>
                        <div class="panel panel-default pull-left wow rotateInDownLeft" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="panel-body">
                                <p class="text-left">
                                    张三发起的转正申请  <a href="#" class="pull-right">去处理</a>
                                </p>
                            </div>
                            <div class="panel-footer">
                                <span>7/25</span> <span class="pull-right">11:38</span>
                            </div>
                        </div>
                        <div class="panel panel-default pull-left wow rotateInDownLeft" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="panel-body">
                                <p class="text-left">
                                    张三发起的转正申请  <a href="#" class="pull-right">去处理</a>
                                </p>
                            </div>
                            <div class="panel-footer">
                                <span>7/25</span> <span class="pull-right">11:38</span>
                            </div>
                        </div>
                        <div class="panel panel-default pull-left wow rotateInDownLeft" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="panel-body">
                                <p class="text-left">
                                    张三发起的转正申请  <a href="#" class="pull-right">去处理</a>
                                </p>
                            </div>
                            <div class="panel-footer">
                                <span>7/25</span> <span class="pull-right">11:38</span>
                            </div>
                        </div>
                        <div class="panel panel-default pull-left wow rotateInDownLeft" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="panel-body">
                                <p class="text-left">
                                    张三发起的转正申请  <a href="#" class="pull-right">去处理</a>
                                </p>
                            </div>
                            <div class="panel-footer">
                                <span>7/25</span> <span class="pull-right">11:38</span>
                            </div>
                        </div>
                        <div class="panel panel-default pull-left wow rotateInDownLeft" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="panel-body">
                                <p class="text-left">
                                    张三发起的转正申请  <a href="#" class="pull-right">去处理</a>
                                </p>
                            </div>
                            <div class="panel-footer">
                                <span>7/25</span> <span class="pull-right">11:38</span>
                            </div>
                        </div>
                        <div class="panel panel-default pull-left wow rotateInDownLeft" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="panel-body">
                                <p class="text-left">
                                    张三发起的转正申请  <a href="#" class="pull-right">去处理</a>
                                </p>
                            </div>
                            <div class="panel-footer">
                                <span>7/25</span> <span class="pull-right">11:38</span>
                            </div>
                        </div>
                        <div class="panel panel-default pull-left wow rotateInDownLeft" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="panel-body">
                                <p class="text-left">
                                    张三发起的转正申请  <a href="#" class="pull-right">去处理</a>
                                </p>
                            </div>
                            <div class="panel-footer">
                                <span>7/25</span> <span class="pull-right">11:38</span>
                            </div>
                        </div>
                        <div class="load">
                            <a class="btn btn-lg">
                                <img src="${ctxStatic}/portal/images/load.png">查看更多
                            </a>
                        </div>
                    </div>
                    <div class="col-xs-12 tab-pane" id="myCollection">
                        <div class="card service-item wow rotateIn" data-wow-duration=".8s" data-wow-delay=".5s">
                                <div class="card-block">
                                    <h5 class="card-title"><a href="#">大学生奖金申请</a><a href="#" class="pull-right"><img src="${ctxStatic}/portal/images/uncollected.png" alt=""></a></h5>
                                    <div class="card-text">
                                        <div class="card-img pull-left">
                                            <div class="img-left">
                                                <img src="${ctxStatic}/portal/images/card3netBar.png">
                                            </div>
                                        </div>
                                        <div class="pull-left">
                                            <h5><a href="#">服务分类</a></h5>
                                            <span class="readonly-rate" data-score="3.5"></span>
                                        </div>
                                    </div>
                                </div>
                                <p>
                                    服务简介: Lorem ipsum dolor sit Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi corpo
                                    ris impedit maiores officiis provident voluptas voluptates. Alias atque autem delectus eum i
                                    d in, magni natus odit officia, pariatur, totam voluptates.
                                </p>
                            </div>
                        <div class="card service-item wow rotateIn" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="card-block">
                                <h5 class="card-title"><a href="#">大学生奖金申请</a><a href="#" class="pull-right"><img src="${ctxStatic}/portal/images/uncollected.png" alt=""></a></h5>
                                <div class="card-text">
                                    <div class="card-img pull-left">
                                        <div class="img-left">
                                            <img src="${ctxStatic}/portal/images/card3netBar.png">
                                        </div>
                                    </div>
                                    <div class="pull-left">
                                        <h5><a href="#">服务分类</a></h5>
                                        <span class="readonly-rate" data-score="3.5"></span>
                                    </div>
                                </div>
                            </div>
                            <p>
                                服务简介: Lorem ipsum dolor sit Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi corpo
                                ris impedit maiores officiis provident voluptas voluptates. Alias atque autem delectus eum i
                                d in, magni natus odit officia, pariatur, totam voluptates.
                            </p>
                        </div>
                        <div class="card service-item wow rotateIn" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="card-block">
                                <h5 class="card-title"><a href="#">大学生奖金申请</a><a href="#" class="pull-right"><img src="${ctxStatic}/portal/images/uncollected.png" alt=""></a></h5>
                                <div class="card-text">
                                    <div class="card-img pull-left">
                                        <div class="img-left">
                                            <img src="${ctxStatic}/portal/images/card3netBar.png">
                                        </div>
                                    </div>
                                    <div class="pull-left">
                                        <h5><a href="#">服务分类</a></h5>
                                        <span class="readonly-rate" data-score="3.5"></span>
                                    </div>
                                </div>
                            </div>
                            <p>
                                服务简介: Lorem ipsum dolor sit Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi corpo
                                ris impedit maiores officiis provident voluptas voluptates. Alias atque autem delectus eum i
                                d in, magni natus odit officia, pariatur, totam voluptates.
                            </p>
                        </div>
                        <div class="card service-item wow rotateIn" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="card-block">
                                <h5 class="card-title"><a href="#">大学生奖金申请</a><a href="#" class="pull-right"><img src="${ctxStatic}/portal/images/uncollected.png" alt=""></a></h5>
                                <div class="card-text">
                                    <div class="card-img pull-left">
                                        <div class="img-left">
                                            <img src="${ctxStatic}/portal/images/card3netBar.png">
                                        </div>
                                    </div>
                                    <div class="pull-left">
                                        <h5><a href="#">服务分类</a></h5>
                                        <span class="readonly-rate" data-score="3.5"></span>
                                    </div>
                                </div>
                            </div>
                            <p>
                                服务简介: Lorem ipsum dolor sit Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi corpo
                                ris impedit maiores officiis provident voluptas voluptates. Alias atque autem delectus eum i
                                d in, magni natus odit officia, pariatur, totam voluptates.
                            </p>
                        </div>
                        <div class="card service-item wow rotateIn" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="card-block">
                                <h5 class="card-title"><a href="#">大学生奖金申请</a><a href="#" class="pull-right"><img src="${ctxStatic}/portal/images/uncollected.png" alt=""></a></h5>
                                <div class="card-text">
                                    <div class="card-img pull-left">
                                        <div class="img-left">
                                            <img src="${ctxStatic}/portal/images/card3netBar.png">
                                        </div>
                                    </div>
                                    <div class="pull-left">
                                        <h5><a href="#">服务分类</a></h5>
                                        <span class="readonly-rate" data-score="3.5"></span>
                                    </div>
                                </div>
                            </div>
                            <p>
                                服务简介: Lorem ipsum dolor sit Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi corpo
                                ris impedit maiores officiis provident voluptas voluptates. Alias atque autem delectus eum i
                                d in, magni natus odit officia, pariatur, totam voluptates.
                            </p>
                        </div>
                        <div class="card service-item wow rotateIn" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="card-block">
                                <h5 class="card-title"><a href="#">大学生奖金申请</a><a href="#" class="pull-right"><img src="${ctxStatic}/portal/images/uncollected.png" alt=""></a></h5>
                                <div class="card-text">
                                    <div class="card-img pull-left">
                                        <div class="img-left">
                                            <img src="${ctxStatic}/portal/images/card3netBar.png">
                                        </div>
                                    </div>
                                    <div class="pull-left">
                                        <h5><a href="#">服务分类</a></h5>
                                        <span class="readonly-rate" data-score="3.5"></span>
                                    </div>
                                </div>
                            </div>
                            <p>
                                服务简介: Lorem ipsum dolor sit Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi corpo
                                ris impedit maiores officiis provident voluptas voluptates. Alias atque autem delectus eum i
                                d in, magni natus odit officia, pariatur, totam voluptates.
                            </p>
                        </div>
                        <div class="card service-item wow rotateIn" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="card-block">
                                <h5 class="card-title"><a href="#">大学生奖金申请</a><a href="#" class="pull-right"><img src="${ctxStatic}/portal/images/uncollected.png" alt=""></a></h5>
                                <div class="card-text">
                                    <div class="card-img pull-left">
                                        <div class="img-left">
                                            <img src="${ctxStatic}/portal/images/card3netBar.png">
                                        </div>
                                    </div>
                                    <div class="pull-left">
                                        <h5><a href="#">服务分类</a></h5>
                                        <span class="readonly-rate" data-score="3.5"></span>
                                    </div>
                                </div>
                            </div>
                            <p>
                                服务简介: Lorem ipsum dolor sit Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi corpo
                                ris impedit maiores officiis provident voluptas voluptates. Alias atque autem delectus eum i
                                d in, magni natus odit officia, pariatur, totam voluptates.
                            </p>
                        </div>
                        <div class="card service-item wow rotateIn" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="card-block">
                                <h5 class="card-title"><a href="#">大学生奖金申请</a><a href="#" class="pull-right"><img src="${ctxStatic}/portal/images/uncollected.png" alt=""></a></h5>
                                <div class="card-text">
                                    <div class="card-img pull-left">
                                        <div class="img-left">
                                            <img src="${ctxStatic}/portal/images/card3netBar.png">
                                        </div>
                                    </div>
                                    <div class="pull-left">
                                        <h5><a href="#">服务分类</a></h5>
                                        <span class="readonly-rate" data-score="3.5"></span>
                                    </div>
                                </div>
                            </div>
                            <p>
                                服务简介: Lorem ipsum dolor sit Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi corpo
                                ris impedit maiores officiis provident voluptas voluptates. Alias atque autem delectus eum i
                                d in, magni natus odit officia, pariatur, totam voluptates.
                            </p>
                        </div>
                        <div class="card service-item wow rotateIn" data-wow-duration=".8s" data-wow-delay=".5s">
                            <div class="card-block">
                                <h5 class="card-title"><a href="#">大学生奖金申请</a><a href="#" class="pull-right"><img src="${ctxStatic}/portal/images/uncollected.png" alt=""></a></h5>
                                <div class="card-text">
                                    <div class="card-img pull-left">
                                        <div class="img-left">
                                            <img src="${ctxStatic}/portal/images/card3netBar.png">
                                        </div>
                                    </div>
                                    <div class="pull-left">
                                        <h5><a href="#">服务分类</a></h5>
                                        <span class="readonly-rate" data-score="3.5"></span>
                                    </div>
                                </div>
                            </div>
                            <p>
                                服务简介: Lorem ipsum dolor sit Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi corpo
                                ris impedit maiores officiis provident voluptas voluptates. Alias atque autem delectus eum i
                                d in, magni natus odit officia, pariatur, totam voluptates.
                            </p>
                        </div>
                        <div class="load">
                            <a class="btn btn-lg">
                                <img src="${ctxStatic}/portal/images/load.png">查看更多
                            </a>
                        </div>
                    </div>
                    <div class="col-xs-12 tab-pane" id="processTrace">
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>事项</th>
                                        <th>当前步骤</th>
                                        <th>提交时间</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-xs-12 tab-pane" id="personal-data">
                        <ul>
                            <li class="info-item">
                                <div class="wrap-info">
                                    <div class=" wrap-info-img">
                                        <img src="${ctxStatic}/portal/images/email-oc.png">
                                    </div>
                                    <div class="wrap-info-text">
                                        邮件
                                        <br>
                                        456972159@qq.com
                                    </div>
                                    <a href="#">3封未读</a>
                                </div>
                            </li>
                            <li class="info-item">
                                <div class="wrap-info">
                                    <div class=" wrap-info-img">
                                        <img src="${ctxStatic}/portal/images/card-for-all.png">
                                    </div>
                                    <div class="wrap-info-text">
                                        校园一卡通
                                    </div>
                                    <a href="#">余额 <span>50元</span></a>
                                </div>
                            </li>
                            <li class="info-item">
                                <div class="wrap-info">
                                    <div class=" wrap-info-img">
                                        <img src="${ctxStatic}/portal/images/email-oc.png">
                                    </div>
                                    <div class="wrap-info-text">
                                        邮件
                                        <br>
                                        456972159@qq.com
                                    </div>
                                    <a href="#">3封未读</a>
                                </div>
                            </li>
                            <li class="info-item">
                                <div class="wrap-info">
                                    <div class=" wrap-info-img">
                                        <img src="${ctxStatic}/portal/images/library.png">
                                    </div>
                                    <div class="wrap-info-text">
                                        图书馆
                                    </div>
                                    <a href="#">未还图书： 2本</a>
                                </div>
                            </li>
                            <li class="info-item">
                                <div class="wrap-info">
                                    <div class=" wrap-info-img">
                                        <img src="${ctxStatic}/portal/images/email-oc.png">
                                    </div>
                                    <div class="wrap-info-text">
                                        邮件
                                        <br>
                                        456972159@qq.com
                                    </div>
                                    <a href="#">3封未读</a>
                                </div>
                            </li>
                            <li class="info-item">
                                <div class="wrap-info">
                                    <div class=" wrap-info-img">
                                        <img src="${ctxStatic}/portal/images/card-for-all.png">
                                    </div>
                                    <div class="wrap-info-text">
                                        校园一卡通
                                    </div>
                                    <a href="#">余额 <span>50元</span></a>
                                </div>
                            </li>
                            <li class="info-item">
                                <div class="wrap-info">
                                    <div class=" wrap-info-img">
                                        <img src="${ctxStatic}/portal/images/email-oc.png">
                                    </div>
                                    <div class="wrap-info-text">
                                        邮件
                                        <br>
                                        456972159@qq.com
                                    </div>
                                    <a href="#">3封未读</a>
                                </div>
                            </li>
                            <li class="info-item">
                                <div class="wrap-info">
                                    <div class=" wrap-info-img">
                                        <img src="${ctxStatic}/portal/images/library.png">
                                    </div>
                                    <div class="wrap-info-text">
                                        图书馆
                                    </div>
                                    <a href="#">未还图书： 2本</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
    <div class="row">
        <div class="col-xs-12">
            <div class="modal fade myModal" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>

                            <div class="modal-title">
                                <div class="modal-title-left pull-left">
                                    <img src="${ctxStatic}/portal/images/icon.png">
                                </div>
                                <div class="modal-title-right pull-left">
                                    <h4>大学生奖学金申请</h4>
                                    <span class="readonly-rate" data-score="1"></span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-body">
                            <ul class="text-body">
                                <li>
                                    <span class="title-key">服务分类：</span>分类名称
                                </li>
                                <li>
                                    <span class="title-key">所属部门：</span>保卫处
                                </li>
                                <li>
                                    <span class="title-key">服务对象：</span>学生
                                </li>
                                <li>
                                    <span class="title-key">服务简介： </span>教书育人、服务育人、遵守职业道德，树立“一切从学生出发，一切为了学生，为了学生一切”的思想，全心全意为学生服务
                                </li>
                                <li>
                                    第一步：关心爱护学生，尊重学生人格，尊重学生家长，杜绝体罚和变相体罚学生。
                                </li>
                                <li>
                                    第二步：坚持谦虚谨慎的工作态度，虚心听取学校每位教师。
                                </li>
                                <li>
                                    第三步：严格执行课程标准。按照要求，开齐课程，开足课时，上好课程，全面加强过程管理，全面推行质量承诺。
                                </li>
                                <li>
                                    第四步：对电话、网络咨询，我们将即时答复或转办相关负责人员。
                                </li>
                                <li>
                                    第五步：对书面咨询，我们将在受理后5个工作日内给予答复，复杂问题在15个工作日内做出答复。
                                </li>
                                <li>
                                    第六步：对书面咨询，我们将在受理后5个工作日内给予答复，复杂问题在15个工作日内做出答复。
                                </li>
                                <li>
                                    第七步：对书面咨询，我们将在受理后5个工作日内给予答复，复杂问题在15个工作日内做出答复。
                                </li>
                            </ul>
                            <ul class="text-evaluate"  id="show-star">
                                <li>
                                    <span class="title-key">服务实用：</span>
                                    <span class="rate" data-score="1"></span>
                                </li>
                                <li>
                                    <span class="title-key">办事效率：</span>
                                    <span class="rate" data-score="1"></span>
                                    <span class="title"></span>
                                </li>
                                <li>
                                    <span class="title-key">服务体验：</span>
                                    <span class="rate" data-score="1"></span>
                                </li>
                            </ul>
                        </div>
                        <div class="modal-footer">
                            <div class="btn-group text-left" role="group">
                                <button type="button" class="btn">进入服务</button>
                                <button type="button" class="btn">移出</button>
                                <button type="button" class="btn">评价</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
<!--5、引入 jquery，bootstrap js-->
<script src="${ctxStatic }/portal/solrShow/js/jquery-1.11.3.js"></script>
<script src="${ctxStatic }/portal/solrShow/js/jalendar.js"></script>
<script src="${ctxStatic }/portal/solrShow/js/bootstrap.js"></script>
<script src="${ctxStatic }/portal/solrShow/js/wow.min.js"></script>
<script src="${ctxStatic }/portal/solrShow/js/infoUsercenter.js"></script>
<script src="${ctxStatic }/portal/solrShow/js/jquery.raty.min.js"></script>
<script>
    $(function () {
        $("#calendar").jalendar({
            customDay:new Date(),
            lang:"zh-cn"
        });
    });
</script>

<script>
function news(){
		window.location.href="${ctx}/cms/solr/news?pageCode=";
}
</script>
</body>
</html>