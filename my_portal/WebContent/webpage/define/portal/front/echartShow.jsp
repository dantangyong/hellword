<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head lang="zh-cn">
    <meta charset="UTF-8">
    <!--2 viewport-->
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <!--3、x-ua-compatible-->
    <meta http-equiv="x-ua-compatible" content="IE=edge">
    <title>大屏展示</title>
    <!--4、引入两个兼容文件-->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <!--6、引入 bootstrap.css-->
    <link rel="stylesheet" href="${ctxStatic }/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic }/css/largeScreen.min.css">
</head>


<body>
    <div class="container-fluid">
        <h2 class="title-head text-center">
            西南科技大学数据可视化决策系统 <br>
            <img src="${ctxStatic }/portal/images/border.png">
        </h2>
        <div class="row">
            <div class="col-sm-3">
                <div class="row">
                    <div class="col-xs-12">
                        <div id="left1"></div>
                        <div id="left2"></div>
                        <div id="left3"></div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="row">
                    <div class="col-xs-12">
                        <div id="center1"></div>
                        <div id="center2">

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="row">
                    <div class="col-xs-12">
                        <div id="right1"></div>
                        <div id="right2"></div>
                        <div id="right3"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- <div class="back-to-vr">
        <a href="#">
            <span class="glyphicon glyphicon-arrow-right"></span>
            进入校园VR
        </a>
    </div>  -->
<script src="${ctxStatic }/js/jquery.min.js"></script>
<script src="${ctxStatic }/js/bootstrap.min.js"></script>
<script src="${ctxStatic }/js/echarts.min.js"></script>
<script src="${ctxStatic }/js/worldcloud3.min.js"></script>
<script src="${ctxStatic }/js/china.js"></script>
<script type="text/javascript">

 $(function(){
		//////////////////////////////////////////////myChartLeft1/////////////////////////////////////////////////
		var myChartLeft1 = echarts.init(document.getElementById('left1'));
		var optionLeft1 = {
				    title: {
				      text: '科研获奖级别',
				      subtext: 'Level of the scientific research award',
				      left: 'left',
				      top: 0,
				      textStyle: {
				        color: '#fff'
				      }
				    },
				    tooltip: {
				      position: function (point, params, dom, rect, size) {
				        return [point[0], '10%'];
				      },
				      trigger: 'item',
				      formatter: "{a} <br/>{b} : {c} ({d}%)",
				    },

				    visualMap: {
				      show: false,
				      min: 10080,
				      max: 50000,
				      inRange: {
				        colorLightness: [0, 1]
				      }
				    },
				    labelLine: {
				      normal: {
				        show: false
				      },
				      emphasis: {
				        show: true
				      }
				    },
				    legend: {
				      orient: 'vertical',
				      itemWidth: 14,
				      itemHeight: 14,
				      itemGap: 10,
				      x: '1%',
				      y: '30%',
				      borderRadius: 0,
				      textStyle: {
				        fontSize: 12,
				        color: '#fff'
				      },
				      data: []
				    	  //['国家奖占比', '部级奖占比', '省级奖占比', '地市奖占比', '学校奖占比', '其他占比']
				      
				    },
				    series: [
				      {
				        name: '获奖分析',
				        type: 'pie',
				        radius: '55%',
				        center: ['60%', '55%'],
				        data:  [
// 				          {value: 33512, name: '国家奖占比', itemStyle: {normal: {color: '#079CB9'}}},
// 				          {value: 31041, name: '部级奖占比', itemStyle: {normal: {color: '#0479D8'}}},
// 				          {value: 27444, name: '省级奖占比', itemStyle: {normal: {color: '#6930C0'}}},
// 				          {value: 23564, name: '地市奖占比', itemStyle: {normal: {color: '#3B3E7C'}}},
// 				          {value: 23564, name: '学校奖占比', itemStyle: {normal: {color: '#4689CD'}}},
// 				          {value: 23564, name: '其他占比', itemStyle: {normal: {color: '#3D4145'}}}
				        ].sort(function (a, b) {
				          return a.value - b.value;
				        }),
				        roseType: 'radius',
				        label: {
				          normal: {
				            show: true,
				            formatter: '({d}%)'
				          },
				          emphasis: {
				            show: true
				          }
				        },
				        labelLine: {
				          normal: {
				            lineStyle: {
				              color: 'rgb(255, 255, 255)'
				            },
				            smooth: 0.2,
				            length: 10,
				          }
				        },
				        animationType: 'scale',
				        animationEasing: 'elasticOut',
				        animationDelay: function (idx) {
				          return Math.random() * 200;
				        }
				      }
				    ]
				  };
				 myChartLeft1.setOption(optionLeft1);
	 
		$.ajax({
			url:"${ctx}/cms/index/showResearchs",
			type:"post",
			success:function(data){
				//获取ajax返回的legend数据
				var legendList = data.body.legend;
				//封装前台需要动态获取legend的数据
				var legendData = [];
				for(var key in legendList){
					legendData.push(legendList[key].legend);
				}
				//console.log(legendData);
				//封装前台需要动态获取series的数据
				var seriesList = data.body.series;
				var seriesData = [];
				for(var key in seriesList){
					seriesData.push(seriesList[key].series);
				}
				//console.log(seriesData);
				
				//动态填入数据
				myChartLeft1.setOption({
					
					legend:{
						data:legendData
					},
					
					series:[{
						 data:[
							 {value: seriesData[0], name: legendData[0], itemStyle: {normal: {color: '#079CB9'}}},
				          	 {value: seriesData[1], name: legendData[1], itemStyle: {normal: {color: '#0479D8'}}},
				          	 {value: seriesData[2], name: legendData[2], itemStyle: {normal: {color: '#6930C0'}}},
				          	 {value: seriesData[3], name: legendData[3], itemStyle: {normal: {color: '#3B3E7C'}}},
				          	 {value: seriesData[4], name: legendData[4], itemStyle: {normal: {color: '#4689CD'}}},
				          	 {value: seriesData[5], name: legendData[5], itemStyle: {normal: {color: '#3D4145'}}}
				          	] 
				   }]
						  
			   })
			}
		});
	
		///////////////////////////////myChartLeft2//////////////////////////////////////////////////////////////////
		var myChartLeft2 = echarts.init(document.getElementById('left2'));
		var optionLeft2 = {
			    title: {
			      text: '教职工学历统计',
			      subtext: 'The staff education statistics',
			      textStyle: {
			        color: '#fff'
			      }
			    },
			    tooltip: {
			      trigger: 'axis',
			      axisPointer: {
			        type: 'shadow',
			      }
			    },
			    grid: {
			      x: 30,
			      y: 60,
			      x2: '12%',
			      y2: 30,
			      borderWidth: 1
			    },
			    legend: {
			      data: [],
			      //['大专', '本科', '硕士', '博士', '博士后'],
			      orient: 'vertical',
			      itemWidth: 14,
			      itemHeight: 14,
			      itemGap: 10,
			      x: 'right',
			      y: '16%',
			      textStyle: {
			        fontSize: 12,
			        color: '#fff'
			      }
			    },
			    toolbox: {
			      show: true,
			    },
			    calculable: true,
			    xAxis: [
			      {
			        splitLine: {
			          show: false
			        },
			        axisLabel: {
			          textStyle: {
			            color: '#fff',
			            fontSize: '12'
			          }
			        },
			        width: '50%',
			        type: 'category',
			        data: [],
			        //['25~30岁', '35~50岁', '50~65岁'],
			        axisLine: {
			          lineStyle: {
			            color: '#292627',
			            width: 1,
			          }
			        },
			      }
			    ],
			    yAxis: [
			      {
			        splitLine: {
			          show: true,
			          lineStyle: {
			            color: '#292627',
			            width: 1,
			            type: 'solid'
			
			          }
			        },
			        axisLabel: {
			          textStyle: {
			            color: '#fff',
			            fontSize: '12'
			          }
			        },
			        bottom: 0,
			        type: 'value',
			        axisLine: {
			          lineStyle: {
			            color: '#292627',
			            width: 1,
			          }
			        }
			      }
			    ],
			    series: [
			
			      {
			        name: '',
			        	//'大专',
			        type: 'bar',
			        data: [],
			        	//[200, 50, 100],
			        barWidth: 10,
			        itemStyle: {normal: {color: '#079CB9'}}
			      },
			      {
			        name: '',
			        //'本科',
			        type: 'bar',
			        barWidth: 10,
			        data: [],
			     	   //[300, 150, 20,],
			        itemStyle: {normal: {color: '#0479D8'}}
			      },
			      {
			        name: '',
			        //'硕士',
			        type: 'bar',
			        barWidth: 10,
			        data:[], 
			           //[10, 50, 60,],
			        itemStyle: {normal: {color: '#6930C0'}}
			      },
			      {
			        name: '',
			        //'博士',
			        type: 'bar',
			        barWidth: 10,
			        data:[], 
			        	//[6, 20, 10,],
			        itemStyle: {normal: {color: '#3B3E7C'}}
			      },
			      {
			        name: '',
			        //'博士后',
			        type: 'bar',
			        barWidth: 10,
			        data: [],
			        	//[3, 15, 20,],
			        itemStyle: {normal: {color: '#4689CD'}}
			      }
			    ]
			  };
		  myChartLeft2.setOption(optionLeft2);
		 //使用ajax动态获取数据并填充到Echarts中	
		  $.ajax({
	 		url:"${ctx}/cms/index/showEducation",
	 		type:"post",
	 		success:function(data){
	 			//console.log(data);
	 			var legendList = data.body.legend;
	 			var legendData = [];
	 			for(var key in legendList){
	 				legendData.push(legendList[key].legend);
	 			}
	 			//console.log(legendData);//获取到legend的数据
				
	 			var xAxisList = data.body.xAxis;
	 			var xAxisData = [];
	 			for(var key in xAxisList){
	 				xAxisData.push(xAxisList[key].xAxis);
	 			}
	 			//console.log(xAxisData);//获取到xAsix中的数据
		
	  			var seriesList = data.body.series;
	  			var educationDataKey=[];
	  			var educationDataValue=[];
	  			
	  			//console.log(seriesList); 
	 			for(var key in seriesList){
	 				//console.log(key);
	 				//console.log(seriesList[key]);
	 				educationDataKey.push(key);
	 				educationDataValue.push(seriesList[key]);
	 			}
				//console.log(educationDataKey);//series中的name数据
				//console.log(educationDataValue);//series中的data数据
				
				//动态载入数据
				myChartLeft2.setOption({
					
					legend:{
						data:legendData
					},
					xAxis: [{
						data: xAxisData
					}],
					series: [
						
					      {
					        name: educationDataKey[0],
					        data: educationDataValue[0],
					      },
					      {
						    name: educationDataKey[1],
						    data: educationDataValue[1],
					      },
					      {
						    name: educationDataKey[2],
						    data: educationDataValue[2],
					      },
					      {
						    name: educationDataKey[3],
						    data: educationDataValue[3],
					      },
					      {
						    name: educationDataKey[4],
						    data: educationDataValue[4],
					      }
					    ],
			   })

	 		}
	 	});
			
       ////////////////////////////////////myChartLeft3///////////////////////////////////////////////////////////////////	
		var myChartLeft3 = echarts.init(document.getElementById('left3'));
		var optionLeft3 = {
			    title: {
			      text: '教职工职称统计',
			      textStyle: {
			        color: '#fff'
			      },
			      subtext: 'Teachers title statistics'
			    },
			    tooltip: {
			      trigger: 'item',
			      formatter: "{a} <br/>{b} : {c}人",
			      position: function (point, params, dom, rect, size) {
			        return [point[0], '10%'];
			      }
			    },
			    legend: {
			      data: [],
			    	  //['讲师', '副教授', '助教', '教授', '博导'],
			      x: 'center',
			      y: 'bottom',
			      itemWidth: 14,
			      itemHeight: 14,
			      gap: 10,
			      textStyle: {
			        color: '#fff',
			      }
			    },
			    calculable: true,
			    series: [
			      {
			        name: '职称统计',
			        type: 'funnel',
			        left: 'center',
			        top: 60,
			        //x2: 80,
			        bottom: 35,
			        width: '45%',
			        // height: {totalHeight} - y - y2,
			        min: 0,
			        max: 100,
			        minSize: '0%',
			        maxSize: '100%',
			        sort: 'descending',
			        gap: 0,
			        label: {
			          normal: {
			            show: true,
			            position: 'right',
			            fontSize: 12,
			          },
			          emphasis: {
			            textStyle: {
			              fontSize: 20
			            }
			          }
			        },
			        labelLine: {
			          normal: {
			            length: 40,
			            lineStyle: {
			              width: 1,
			              type: 'solid',
			            }
			          }
			        },
			        itemStyle: {
			          normal: {
			            borderColor: 'transparent',
			            borderWidth: 1,
			          }
			        },
			        data: [
					/*{value: 60, name: '讲师', itemStyle: {normal: {color: '#19A2C2'}}},
			          {value: 40, name: '副教授', itemStyle: {normal: {color: '#21BDD3'}}},
			          {value: 20, name: '助教', itemStyle: {normal: {color: '#2EE6EE'}}},
			          {value: 80, name: '教授', itemStyle: {normal: {color: '#118BB2'}}},
			          {value: 100, name: '博导', itemStyle: {normal: {color: '#06699C'}}} */
			        ]
			      }
			    ]
			  };
		  	myChartLeft3.setOption(optionLeft3);
		      
			$.ajax({
				url:"${ctx}/cms/index/showTeachers",
				type:"post",
				success:function(data){
					var legendList = data.body.legend;
					var legendData = [];
					for(var key in legendList){
						legendData.push(legendList[key].legend);
					}
					//console.log(legendData);
					
					var seriesList = data.body.series;
					var seriesData = [];
					for(var key in seriesList){
						seriesData.push(seriesList[key].series);
					}
					//console.log(seriesData);
					
					//动态载入数据
					myChartLeft3.setOption({
						
						legend:{
							data:legendData
						},
						series: [
						      {
						        data: [
							          {value: seriesData[0], name: legendData[0], itemStyle: {normal: {color: '#19A2C2'}}},
							          {value: seriesData[1], name: legendData[1], itemStyle: {normal: {color: '#21BDD3'}}},
							          {value: seriesData[2], name: legendData[2], itemStyle: {normal: {color: '#2EE6EE'}}},
							          {value: seriesData[3], name: legendData[3], itemStyle: {normal: {color: '#118BB2'}}},
							          {value: seriesData[4], name:legendData[4], itemStyle: {normal: {color: '#06699C'}}}
						        ],
						      }
						    ],
				   })
				}
			});
/////////////////////////////////////////////////myChartCenter2/////////////////////////////////////////////////////////
		var myChartCenter2 = echarts.init(document.getElementById('center2'));
		var optionCenter2 = {
		    title: {
		      text: '就业率',
		      subtext: 'Employment rate',
		      textStyle: {
		        color: '#fff'
		      }
		    },
		    tooltip: {
		      trigger: 'axis',
		      axisPointer: {
		        type: 'line',
		      }
		    },
		    legend: {
		      itemWidth: 20,
		      itemHeight: 10,
		      itemGap: 13,
		      data: [],
		      //['男生', '女生'],
		      right: '4%',
		      textStyle: {
		        fontSize: 12,
		        color: '#F1F1F3'
		      }
		    },
		    grid: {
		      left: '3%',
		      right: '4%',
		      bottom: '3%',
		      containLabel: true
		    },
		    xAxis: [{
		      type: 'category',
		      boundaryGap: false,
		      axisLine: {
		        lineStyle: {
		          color: '#292627'
		        }
		      },
		      axisLabel: {
		        textStyle: {
		          color: '#fff',
		          fontSize: '12'
		        }
		      },
		      data: [],
		      //['2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017'],
		    }],
		    yAxis: [{
		      type: 'value',
		      axisTick: {
		        show: false
		      },
		      axisLine: {
		        lineStyle: {
		          color: '#292627'
		        }
		      },
		      axisLabel: {
		        textStyle: {
		          color: '#fff',
		          fontSize: '12'
		        }
		      },
		      splitLine: {
		        lineStyle: {
		          color: '#292627'
		        }
		      }
		    }],
		    series: [{
		      name: '',
		      //'男生',
		      type: 'line',
		      smooth: false,
		      symbol: 'circle',
		      symbolSize: 5,
		      showSymbol: true,
		      lineStyle: {
		        normal: {
		          color: '#319AE7',
		          width: 1
		        }
		      },
		      areaStyle: {
		        normal: {
		          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
		            offset: 0,
		            color: 'rgba(137, 189, 27, 0.3)'
		          }, {
		            offset: 0.8,
		            color: 'rgba(137, 189, 27, 0)'
		          }], false),
		          shadowColor: 'rgba(0, 0, 0, 0.1)',
		          shadowBlur: 10
		        }
		      },
		      itemStyle: {
		        normal: {
		          color: 'rgb(40,174,246)',
		          borderColor: 'rgba(40,174,246,0.27)',
		          borderWidth: 12
		        }
		      },
		      data: [],
		      //[400, 600, 440, 90, 500, 180, 260, 450]
		    }, {
		      name: '',
		      //'女生',
		      type: 'line',
		      smooth: false,
		      symbol: 'circle',
		      symbolSize: 5,
		      showSymbol: true,
		      lineStyle: {
		        normal: {
		          width: 1,
		          color: '#9166DB',
		        }
		      },
		      areaStyle: {
		        normal: {
		          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
		            offset: 0,
		            color: 'rgba(101,32,128, 1)'
		          }, {
		            offset: 1,
		            color: 'rgba(0, 136, 212, 0)'
		          }], false),
		          shadowColor: 'rgba(0, 0, 0, 0.1)',
		          shadowBlur: 10
		        }
		      },
		      itemStyle: {
		        normal: {
		          color: 'rgb(166,112,243)',
		          borderColor: 'rgba(166,112,243,0.2)',
		          borderWidth: 12
		
		        }
		      },
		      data: [],
		      //[350, 320, 300, 240, 350, 460, 280, 400],
		    }]
		  };
		  myChartCenter2.setOption(optionCenter2);
		
		  //动态加载数据
		  $.ajax({
		 		url:"${ctx}/cms/index/showRate",
		 		type:"post",
		 		success:function(data){
		 			//console.log(data);
		 			var legendList = data.body.legend;
		 			var legendData = [];
		 			for(var key in legendList){
		 				legendData.push(legendList[key].legend);
		 			}
		 			//console.log(legendData);
					
		 			var xAxisList = data.body.xAxis;
		 			var xAxisData = [];
		 			for(var key in xAxisList){
		 				xAxisData.push(xAxisList[key].xAxis);
		 			}
		 			//console.log(xAxisData);
					//拆分Map集合为数组，再动态取值
		  			var seriesList = data.body.series;
		  			//console.log(seriesList); 
		 			var rateDataKey=[];
		  			var rateDataValue=[];
		  			for(var key in seriesList){
		  				rateDataKey.push(key);
		  				rateDataValue.push(seriesList[key]);
		  			}
		 			//console.log(rateDataKey);
		 			//console.log(rateDataValue);
		  			
		  			//动态加载数据
		  			myChartCenter2.setOption({
						legend:{
							data:legendData
						},
						xAxis: [{
							data: xAxisData
						}],
						series: [{
						    name:rateDataKey[0],
							data:rateDataValue[0],
						},{
						    name:rateDataKey[1],
							data:rateDataValue[1],
						}],
				   })
		 		}
		 	});
//////////////////////////////////////////////////////myRight1///////////////////////////////////////////////////
		var myRight1 = echarts.init(document.getElementById('right1'));
		var optionRight1 = {
		    title: {
		      text: '师生比',
		      subtext: 'Teacher-student ratio',
		      textStyle: {
		        color: '#fff'
		      }
		    },
		    tooltip: {
		      trigger: 'axis',
		      axisPointer: {
		        type: 'shadow'
		      }
		    },
		    legend: {
		      data: [],
		      //['学生', '老师'],
		      itemWidth: 14,
		      itemHeight: 14,
		      textStyle: {
		        color: '#fff'
		      }
		    },
		    grid: {
		      left: '3%',
		      right: '4%',
		      bottom: '3%',
		      containLabel: true
		    },
		    xAxis: {
		      type: 'value',
		      boundaryGap: [0, 0.01],
		      axisLabel: {
		        textStyle: {color: '#fff'}
		      },
		      splitLine: {
		        show: false
		      },
		    },
		    yAxis: {
		      type: 'category',
		      data: [],
		     // ['四川大学', '西南交通大学', '西南石油大学', '成都体育学院', '成都大学'],
		      axisLabel: {
		        textStyle: {color: '#fff'}
		      }
		    },
		
		    series: [
		      {
		        name: '',
		        //'学生',
		        type: 'bar',
		        data: [],
		        //[35874, 28203, 13489, 19034, 20000],
		        itemStyle: {
		          normal: {
		            color: '#319AE7',
		          },
		        },
		        label: {
		          normal: {
		            show: true,
		            position: 'right',
		            color: '#fff'
		          }
		        },
		      },
		      {
		        name: '',
		        //'老师',
		        type: 'bar',
		        data: [],
		        //[1000, 900, 3438, 6000, 2000],
		        label: {
		          normal: {
		            show: true,
		            position: 'right',
		            color: '#fff'
		          }
		        },
		        itemStyle: {
		          normal: {
		            color: '#9166DB',
		          }
		        },
		      },
		    ]
		  };
		  myRight1.setOption(optionRight1);
		
			
		 $.ajax({
		 		url:"${ctx}/cms/index/showTeacherStudent",
		 		type:"post",
		 		success:function(data){
		 			//console.log(data);
		 			var legendList = data.body.legend;
		 			var legendData = [];
		 			for(var key in legendList){
		 				legendData.push(legendList[key].legend);
		 			}
		 			//console.log(legendData);
					
		 			var yAxisList = data.body.yAxis;
		 			var yAxisData = [];
		 			for(var key in yAxisList){
		 				yAxisData.push(yAxisList[key].yAxis);
		 			}
		 			//console.log(yAxisData);
		 			//拆分Map集合为数组，再动态取值
		  			var seriesList = data.body.series;
		  			//console.log(seriesList); 
		  			var teacherStudentKey=[];
		  			var teacherStudentValue=[];
		  			for(var key in seriesList){
		  				teacherStudentKey.push(key);
		  				teacherStudentValue.push(seriesList[key]);
		  			}
		  			//console.log(teacherStudentKey);
		  			//console.log(teacherStudentValue);
		  			
		  			//动态加载数据
		  			myRight1.setOption({
						legend:{
							data:legendData
						},
						yAxis: [{
							data: yAxisData
						}],
 						series: [{
						    name:teacherStudentKey[0],
							data:teacherStudentValue[0],
						},{
						    name:teacherStudentKey[1],
							data:teacherStudentValue[1],
						}], 
				   })
		 		}
		 });

/////////////////////////////////////////////////myRight3////////////////////////////////////////////////////////////
		var myRight3 = echarts.init(document.getElementById('right3'));
		var optionRight3 = {
		    title: {
		      text: '学院排名',
		      subtext: 'Academy rank',
		      x: 'left',
		      textStyle: {
		        color: '#fff'
		      }
		
		    },
		    tooltip: { //提示框组件
		      trigger: 'axis',
		      formatter: '{b}<br />{a0}: {c0}<br />排名: {c}',
		      axisPointer: {
		        type: 'shadow',
		        label: {
		          backgroundColor: '#6a7985'
		        }
		      },
		      textStyle: {
		        color: '#fff',
		        fontStyle: 'normal',
		        fontFamily: '微软雅黑',
		        fontSize: 12,
		      }
		    },
		    xAxis: [
		      {
		        type: 'category',
		        boundaryGap: false,//坐标轴两边留白
		        data:[],
		        //['通信学院', '艺术学院', '英语学院', '计算机学院', '工程学院'],
		        axisLabel: { //坐标轴刻度标签的相关设置。
		          interval: 0,//设置为 1，表示『隔一个标签显示一个标签』
		          margin: 5,
		          textStyle: {
		            color: '#fff',
		            fontStyle: 'normal',
		            fontFamily: '微软雅黑',
		            fontSize: 12,
		          }
		        },
		        axisTick: {//坐标轴刻度相关设置。
		          show: false,
		        },
		        axisLine: {//坐标轴轴线相关设置
		          lineStyle: {
		            color: '#fff',
		            opacity: 0.2
		          }
		        },
		        splitLine: { //坐标轴在 grid 区域中的分隔线。
		          show: false,
		        }
		      }
		    ],
		    yAxis: [
		      {
		        type: 'value',
		        splitNumber: 5,
		        axisLabel: {
		          textStyle: {
		            color: '#a8aab0',
		            fontStyle: 'normal',
		            fontFamily: '微软雅黑',
		            fontSize: 12,
		          }
		        },
		        axisLine: {
		          show: false
		        },
		        axisTick: {
		          show: false
		        },
		        splitLine: {
		          show: true,
		          lineStyle: {
		            color: ['#fff'],
		            opacity: 0.06
		          }
		        }
		
		      }
		    ],
		    grid: {
		      x: '10%',
		      y: 70,
		      x2: '10%',
		      y2: '10%',
		    },
		    series: [
		      {
		        name: '分数',
		        type: 'bar',
		        data: [],
		        //[100, 90, 80, 70, 60, 50],
		        barWidth: 10,
		        barGap: 20,//柱间距离
		        label: {//图形上的文本标签
		          normal: {
		            show: true,
		            position: 'top',
		            textStyle: {
		              color: '#fff',
		              fontStyle: 'normal',
		              fontFamily: '微软雅黑',
		              fontSize: 12,
		            },
		          },
		        },
		        itemStyle: {//图形样式
		          normal: {
		            barBorderRadius: [5, 5, 0, 0],
		            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
		              offset: 1, color: 'rgba(127, 128, 225, 0.7)'
		            }, {
		              offset: 0.9, color: 'rgba(72, 73, 181, 0.7)'
		            }, {
		              offset: 0.31, color: 'rgba(0, 208, 208, 0.7)'
		            }, {
		              offset: 0.15, color: 'rgba(0, 208, 208, 0.7)'
		            }, {
		              offset: 0, color: 'rgba(104, 253, 255, 0.7)'
		            }], false),
		          },
		        },
		      },
		    ]
		  };
		  myRight3.setOption(optionRight3);
		 //动态加载数据
		 $.ajax({
				url:"${ctx}/cms/index/showAcademyrank",
				type:"post",
				success:function(data){
					var legendList = data.body.legend;
					var xAxisData = [];
					for(var key in legendList){
						xAxisData.push(legendList[key].xAxis);
					}
					//console.log(xAxisData);
					
					var seriesList = data.body.series;
					var seriesData = [];
					for(var key in seriesList){
						seriesData.push(seriesList[key].data);
					}
					//console.log(seriesData);
					
					//动态加载数据
					myRight3.setOption({

						xAxis: [{
							data: xAxisData
						}],
 						series: [{
							data:seriesData,
						}], 
				   })
					
				}
			});
////////////////////////////////////////////myRight2///////////////////////////////////////////////////
		var myRight2 = echarts.init(document.getElementById('right2'));
		var  optionRight2 = {
		    title: {
		      text: '校园搜搜搜',
		      subtext: 'Hot search',
		      x: 'left',
		      textStyle: {
		        color: '#fff'
		      }
		    },
		    tooltip: {
		      show: true
		    },
		    series: [{
		      width: '100%',
		      height: '100%',
		      left: 0,
		      top: 60,
		      name: '热门搜索',
		      type: 'wordCloud',
		      gap: 20,
		      sizeRange: [12, 30],
		      rotationRange: [0, 30, 60, 90, -45],
		      autoSize: {
		        enable: true,
		        minSize: 10
		      },
		      textStyle: {
		        normal: {
		          color: function () {
		            return 'rgb(' + [
		              Math.round(Math.random() * 160),
		              Math.round(Math.random() * 160),
		              Math.round(Math.random() * 160)
		            ].join(',') + ')';
		          }
		        },
		        emphasis: {
		          shadowBlur: 10,
		          shadowColor: '#333'
		        }
		      },
		      data: [{
		        name: "Jayfee",
		        value: 666
		      }, {
		        name: "Nancy",
		        value: 520
		      }]
		    }]
		  };

		  	$.ajax({
				url:"${ctx}/cms/index/showHotSearch",
				type:"post",
				success:function(data){
					var seriesList = data.body.data;
					//console.log(seriesList);
 					var seriesData = [];
					for(var key in seriesList){
						seriesData.push({name:key,value:seriesList[key]});
					} 
					//console.log(seriesData); 
					
					//动态加载数据
		  			optionRight2.series[0].data = seriesData;
				    myRight2.on('click', function (params) {
				    //alert((params.name));
				    window.open('https://www.baidu.com/s?wd=' + encodeURIComponent(params.name));
				
				   });
				   myRight2.setOption(optionRight2);
				}
			});
		  

}); 
	

 
  var renderItem = {
  //renderLeft1: renderLeft1,
  //renderLeft2: renderLeft2,
  //renderLeft3: renderLeft3,
  renderMap: renderMap,
  //renderCenter2: renderCenter2,
  //renderRight1: renderRight1,
  //renderRight2: renderRight2,
  //renderRight3: renderRight3,
};
/*左侧第一个饼图*/
/*  var myChartLeft1 = echarts.init(document.getElementById('left1'));
function renderLeft1() {
	debugger;
	var legendDataLeft1=$("#legendDataLeft1").val();
	var seriesDataLeft1=$("#seriesDataLeft1").val();
  var optionLeft1 = {
    title: {
      text: '科研获奖级别',
      subtext: 'Level of the scientific research award',
      left: 'left',
      top: 0,
      textStyle: {
        color: '#fff'
      }
    },
    tooltip: {
      position: function (point, params, dom, rect, size) {
        return [point[0], '10%'];
      },
      trigger: 'item',
      formatter: "{a} <br/>{b} : {c} ({d}%)",
    },

    visualMap: {
      show: false,
      min: 10080,
      max: 50000,
      inRange: {
        colorLightness: [0, 1]
      }
    },
    labelLine: {
      normal: {
        show: false
      },
      emphasis: {
        show: true
      }
    },
    legend: {
      orient: 'vertical',
      itemWidth: 14,
      itemHeight: 14,
      itemGap: 10,
      x: '1%',
      y: '30%',
      borderRadius: 0,
      textStyle: {
        fontSize: 12,
        color: '#fff'
      },
      data: ['国家奖占比', '部级奖占比', '省级奖占比', '地市奖占比', '学校奖占比', '其他占比']
    },
    series: [
      {
        name: '获奖分析',
        type: 'pie',
        radius: '55%',
        center: ['60%', '55%'],
        data: [
          {value: 33512, name: '国家奖占比', itemStyle: {normal: {color: '#079CB9'}}},
          {value: 31041, name: '部级奖占比', itemStyle: {normal: {color: '#0479D8'}}},
          {value: 27444, name: '省级奖占比', itemStyle: {normal: {color: '#6930C0'}}},
          {value: 23564, name: '地市奖占比', itemStyle: {normal: {color: '#3B3E7C'}}},
          {value: 23564, name: '学校奖占比', itemStyle: {normal: {color: '#4689CD'}}},
          {value: 23564, name: '其他占比', itemStyle: {normal: {color: '#3D4145'}}}
        ].sort(function (a, b) {
          return a.value - b.value;
        }),
        roseType: 'radius',
        label: {
          normal: {
            show: true,
            formatter: '({d}%)'
          },
          emphasis: {
            show: true
          }
        },
        labelLine: {
          normal: {
            lineStyle: {
              color: 'rgb(255, 255, 255)'
            },
            smooth: 0.2,
            length: 10,
          }
        },
        animationType: 'scale',
        animationEasing: 'elasticOut',
        animationDelay: function (idx) {
          return Math.random() * 200;
        }
      }
    ]
  };
  myChartLeft1.setOption(optionLeft1);
  
} */

/*左侧第二个柱状图*/
/* var myChartLeft2 = echarts.init(document.getElementById('left2'));
function renderLeft2() {
  var optionLeft2 = {
    title: {
      text: '教职工学历统计',
      subtext: 'The staff education statistics',
      textStyle: {
        color: '#fff'
      }
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'shadow',
      }
    },
    grid: {
      x: 30,
      y: 60,
      x2: '12%',
      y2: 30,
      borderWidth: 1
    },
    legend: {
      data: ['大专', '本科', '硕士', '博士', '博士后'],
      orient: 'vertical',
      itemWidth: 14,
      itemHeight: 14,
      itemGap: 10,
      x: 'right',
      y: '16%',
      textStyle: {
        fontSize: 12,
        color: '#fff'
      }
    },
    toolbox: {
      show: true,
    },
    calculable: true,
    xAxis: [
      {
        splitLine: {
          show: false
        },
        axisLabel: {
          textStyle: {
            color: '#fff',
            fontSize: '12'
          }
        },
        width: '50%',
        type: 'category',
        data: ['25~30岁', '35~50岁', '50~65岁'],
        axisLine: {
          lineStyle: {
            color: '#292627',
            width: 1,
          }
        },
      }
    ],
    yAxis: [
      {
        splitLine: {
          show: true,
          lineStyle: {
            color: '#292627',
            width: 1,
            type: 'solid'

          }
        },
        axisLabel: {
          textStyle: {
            color: '#fff',
            fontSize: '12'
          }
        },
        bottom: 0,
        type: 'value',
        axisLine: {
          lineStyle: {
            color: '#292627',
            width: 1,
          }
        }
      }
    ],
    series: [

      {
        name: '大专',
        type: 'bar',
        data: [200, 50, 100],
        barWidth: 10,
        itemStyle: {normal: {color: '#079CB9'}}
      },
      {
        name: '本科',
        type: 'bar',
        barWidth: 10,
        data: [300, 150, 20,],
        itemStyle: {normal: {color: '#0479D8'}}
      },
      {
        name: '硕士',
        type: 'bar',
        barWidth: 10,
        data: [10, 50, 60,],
        itemStyle: {normal: {color: '#6930C0'}}
      },
      {
        name: '博士',
        type: 'bar',
        barWidth: 10,
        data: [6, 20, 10,],
        itemStyle: {normal: {color: '#3B3E7C'}}
      },
      {
        name: '博士后',
        type: 'bar',
        barWidth: 10,
        data: [3, 15, 20,],
        itemStyle: {normal: {color: '#4689CD'}}
      }
    ]
  };
  myChartLeft2.setOption(optionLeft2);
} */

/*左侧第三个漏斗图*/
/* var myChartLeft3 = echarts.init(document.getElementById('left3'));
function renderLeft3() {
  optionLeft3 = {
    title: {
      text: '教职工职称统计',
      textStyle: {
        color: '#fff'
      },
      subtext: 'Teachers title statistics'
    },
    tooltip: {
      trigger: 'item',
      formatter: "{a} <br/>{b} : {c}人",
      position: function (point, params, dom, rect, size) {
        return [point[0], '10%'];
      }
    },
    legend: {
      data: ['讲师', '副教授', '助教', '教授', '博导'],
      x: 'center',
      y: 'bottom',
      itemWidth: 14,
      itemHeight: 14,
      gap: 10,
      textStyle: {
        color: '#fff',
      }
    },
    calculable: true,
    series: [
      {
        name: '职称统计',
        type: 'funnel',
        left: 'center',
        top: 60,
        //x2: 80,
        bottom: 35,
        width: '45%',
        // height: {totalHeight} - y - y2,
        min: 0,
        max: 100,
        minSize: '0%',
        maxSize: '100%',
        sort: 'descending',
        gap: 0,
        label: {
          normal: {
            show: true,
            position: 'right',
            fontSize: 12,
          },
          emphasis: {
            textStyle: {
              fontSize: 20
            }
          }
        },
        labelLine: {
          normal: {
            length: 40,
            lineStyle: {
              width: 1,
              type: 'solid',
            }
          }
        },
        itemStyle: {
          normal: {
            borderColor: 'transparent',
            borderWidth: 1,
          }
        },
        data: [
          {value: 60, name: '讲师', itemStyle: {normal: {color: '#19A2C2'}}},
          {value: 40, name: '副教授', itemStyle: {normal: {color: '#21BDD3'}}},
          {value: 20, name: '助教', itemStyle: {normal: {color: '#2EE6EE'}}},
          {value: 80, name: '教授', itemStyle: {normal: {color: '#118BB2'}}},
          {value: 100, name: '博导', itemStyle: {normal: {color: '#06699C'}}}
        ]
      }
    ]
  };
  myChartLeft3.setOption(optionLeft3);
} */

/*中间地图*/
var myChartCenter1 = echarts.init(document.getElementById('center1'));
function renderMap() {
  var geoCoordMap = {
    '上海': [121.4648, 31.2891],
    '东莞': [113.8953, 22.901],
    '东营': [118.7073, 37.5513],
    '中山': [113.4229, 22.478],
    '临汾': [111.4783, 36.1615],
    '临沂': [118.3118, 35.2936],
    '丹东': [124.541, 40.4242],
    '丽水': [119.5642, 28.1854],
    '乌鲁木齐': [87.9236, 43.5883],
    '佛山': [112.8955, 23.1097],
    '保定': [115.0488, 39.0948],
    '兰州': [103.5901, 36.3043],
    '包头': [110.3467, 41.4899],
    '北京': [116.4551, 40.2539],
    '北海': [109.314, 21.6211],
    '南京': [118.8062, 31.9208],
    '南宁': [108.479, 23.1152],
    '南昌': [116.0046, 28.6633],
    '南通': [121.1023, 32.1625],
    '厦门': [118.1689, 24.6478],
    '台州': [121.1353, 28.6688],
    '合肥': [117.29, 32.0581],
    '呼和浩特': [111.4124, 40.4901],
    '咸阳': [108.4131, 34.8706],
    '哈尔滨': [127.9688, 45.368],
    '唐山': [118.4766, 39.6826],
    '嘉兴': [120.9155, 30.6354],
    '大同': [113.7854, 39.8035],
    '大连': [122.2229, 39.4409],
    '天津': [117.4219, 39.4189],
    '太原': [112.3352, 37.9413],
    '威海': [121.9482, 37.1393],
    '宁波': [121.5967, 29.6466],
    '宝鸡': [107.1826, 34.3433],
    '宿迁': [118.5535, 33.7775],
    '常州': [119.4543, 31.5582],
    '广州': [113.5107, 23.2196],
    '廊坊': [116.521, 39.0509],
    '延安': [109.1052, 36.4252],
    '张家口': [115.1477, 40.8527],
    '徐州': [117.5208, 34.3268],
    '德州': [116.6858, 37.2107],
    '惠州': [114.6204, 23.1647],
    '成都': [103.9526, 30.7617],
    '扬州': [119.4653, 32.8162],
    '承德': [117.5757, 41.4075],
    '拉萨': [91.1865, 30.1465],
    '无锡': [120.3442, 31.5527],
    '日照': [119.2786, 35.5023],
    '昆明': [102.9199, 25.4663],
    '杭州': [119.5313, 29.8773],
    '枣庄': [117.323, 34.8926],
    '柳州': [109.3799, 24.9774],
    '株洲': [113.5327, 27.0319],
    '武汉': [114.3896, 30.6628],
    '汕头': [117.1692, 23.3405],
    '江门': [112.6318, 22.1484],
    '沈阳': [123.1238, 42.1216],
    '沧州': [116.8286, 38.2104],
    '河源': [114.917, 23.9722],
    '泉州': [118.3228, 25.1147],
    '泰安': [117.0264, 36.0516],
    '泰州': [120.0586, 32.5525],
    '济南': [117.1582, 36.8701],
    '济宁': [116.8286, 35.3375],
    '海口': [110.3893, 19.8516],
    '淄博': [118.0371, 36.6064],
    '淮安': [118.927, 33.4039],
    '深圳': [114.5435, 22.5439],
    '清远': [112.9175, 24.3292],
    '温州': [120.498, 27.8119],
    '渭南': [109.7864, 35.0299],
    '湖州': [119.8608, 30.7782],
    '湘潭': [112.5439, 27.7075],
    '滨州': [117.8174, 37.4963],
    '潍坊': [119.0918, 36.524],
    '烟台': [120.7397, 37.5128],
    '玉溪': [101.9312, 23.8898],
    '珠海': [113.7305, 22.1155],
    '盐城': [120.2234, 33.5577],
    '盘锦': [121.9482, 41.0449],
    '石家庄': [114.4995, 38.1006],
    '福州': [119.4543, 25.9222],
    '秦皇岛': [119.2126, 40.0232],
    '绍兴': [120.564, 29.7565],
    '聊城': [115.9167, 36.4032],
    '肇庆': [112.1265, 23.5822],
    '舟山': [122.2559, 30.2234],
    '苏州': [120.6519, 31.3989],
    '莱芜': [117.6526, 36.2714],
    '菏泽': [115.6201, 35.2057],
    '营口': [122.4316, 40.4297],
    '葫芦岛': [120.1575, 40.578],
    '衡水': [115.8838, 37.7161],
    '衢州': [118.6853, 28.8666],
    '西宁': [101.4038, 36.8207],
    '西安': [109.1162, 34.2004],
    '贵阳': [106.6992, 26.7682],
    '连云港': [119.1248, 34.552],
    '邢台': [114.8071, 37.2821],
    '邯郸': [114.4775, 36.535],
    '郑州': [113.4668, 34.6234],
    '鄂尔多斯': [108.9734, 39.2487],
    '重庆': [107.7539, 30.1904],
    '金华': [120.0037, 29.1028],
    '铜川': [109.0393, 35.1947],
    '银川': [106.3586, 38.1775],
    '镇江': [119.4763, 31.9702],
    '长春': [125.8154, 44.2584],
    '长沙': [113.0823, 28.2568],
    '长治': [112.8625, 36.4746],
    '阳泉': [113.4778, 38.0951],
    '青岛': [120.4651, 36.3373],
    '韶关': [113.7964, 24.7028],
    '绵阳': [104.7252, 31.4662]
  };
  var BJData = [
    [{name: '上海', value: 10}, {name: '绵阳'}],
    [{name: '广州', value: 70}, {name: '绵阳'}],
    [{name: '哈尔滨', value: 30}, {name: '绵阳'}],
    [{name: '青岛', value: 50}, {name: '绵阳'}],
    [{name: '南昌', value: 20}, {name: '绵阳'}],
    [{name: '银川', value: 10}, {name: '绵阳'}],
    [{name: '拉萨', value: 80}, {name: '绵阳'}],
    [{name: '西安', value: 55}, {name: '绵阳'}],
    [{name: '乌鲁木齐', value: 90}, {name: '绵阳'}]
  ];
  var convertData = function (data) {
    var res = [];
    for (var i = 0; i < data.length; i++) {
      var dataItem = data[i];
      var fromCoord = geoCoordMap[dataItem[0].name];
      var toCoord = geoCoordMap[dataItem[1].name];
      if (fromCoord && toCoord) {
        res.push([
          {
            coord: fromCoord,
            value: dataItem[0].value
          },
          {
            coord: toCoord,
          }
        ]);
      }
    }
    return res;
  };
  var color = ['#ff3333', 'orange', 'yellow', 'lime', 'aqua'];
  var series = [];
  [['绵阳', BJData]].forEach(function (item, i) {
    series.push(
      {
        type: 'lines',
        zlevel: 2,
        effect: {
          show: true,
          period: 4,
          trailLength: 0.02,
          symbol: 'arrow',
          symbolSize: 5,
        },
        lineStyle: {
          normal: {
            width: 1,
            opacity: 0,
            curveness: 0
          }
        },

        data: convertData(item[1])
      },
      {
        type: 'effectScatter',
        coordinateSystem: 'geo',
        zlevel: 2,
        rippleEffect: {
          period: 4,
          brushType: 'stroke',
          scale: 4
        },
        label: {
          normal: {
            show: true,
            position: 'right',
            offset: [5, 0],
            formatter: '{b}'
          },
          emphasis: {
            show: true
          }
        },
        symbol: 'circle',
        symbolSize: function (val) {
          return 4 + val[2] / 20;
        },
        itemStyle: {
          normal: {
            show: false,
            color: '#f00'
          }
        },
        data: item[1].map(function (dataItem) {
          return {
            name: dataItem[0].name,
            value: geoCoordMap[dataItem[0].name].concat([dataItem[0].value])
          };
        }),
      },
      //被攻击点
      {
        type: 'scatter',
        coordinateSystem: 'geo',
        zlevel: 2,
        rippleEffect: {
          period: 4,
          brushType: 'stroke',
          scale: 4
        },
        label: {
          normal: {
            show: true,
            position: 'right',
//			                offset:[5, 0],

            color: '#00ffff',
            formatter: '{b}',
            textStyle: {
              color: "#00ffff"
            }
          },
          emphasis: {
            show: true
          }
        },
        symbol: 'pin',
        symbolSize: 20,
        itemStyle: {
          normal: {
            show: true,
            color: '#9966cc'
          }
        },
        data: [{
          name: item[0],
          value: geoCoordMap[item[0]].concat([100]),
        }],
      }
    );
  });
  optionCenter1 = {
    title: {
      text: '学生人流量',
      subtext: 'Students number',
      textStyle: {
        color: '#fff'
      }
    },
    tooltip: {
      trigger: 'item',
      formatter: "该地人数:{b}：{c}人",
    },
    visualMap: {
      show: false,
      min: 0,
      max: 100,
      calculable: true,
      color: ['#ff3333', 'orange', 'yellow', 'lime', 'aqua'],
      textStyle: {
        color: '#fff'
      }
    },
    geo: {
      map: 'china',
      label: {
        emphasis: {
          show: false
        }
      },
      roam: true,
      layoutCenter: ['48%', '52%'],
      layoutSize: "120%",
      itemStyle: {
        normal: {
          color: 'rgba(51, 69, 89, 0)',
          borderColor: 'rgba(100,149,237,1)'
        },
        emphasis: {
          color: 'rgba(37, 43, 61, .5)'
        }
      }
    },
    series: series
  };
  myChartCenter1.setOption(optionCenter1);
  window.onresize = myChartCenter1.resize();
}

/*中间就业率图*/
/* var myChartCenter2 = echarts.init(document.getElementById('center2'));
function renderCenter2() {
  var optionCenter2 = {
    title: {
      text: '就业率',
      subtext: 'Employment rate',
      textStyle: {
        color: '#fff'
      }
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'line',
      }
    },
    legend: {
      itemWidth: 20,
      itemHeight: 10,
      itemGap: 13,
      data: ['男生', '女生'],
      right: '4%',
      textStyle: {
        fontSize: 12,
        color: '#F1F1F3'
      }
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true
    },
    xAxis: [{
      type: 'category',
      boundaryGap: false,
      axisLine: {
        lineStyle: {
          color: '#292627'
        }
      },
      axisLabel: {
        textStyle: {
          color: '#fff',
          fontSize: '12'
        }
      },
      data: ['2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017'],
    }],
    yAxis: [{
      type: 'value',
      axisTick: {
        show: false
      },
      axisLine: {
        lineStyle: {
          color: '#292627'
        }
      },
      axisLabel: {
        textStyle: {
          color: '#fff',
          fontSize: '12'
        }
      },
      splitLine: {
        lineStyle: {
          color: '#292627'
        }
      }
    }],
    series: [{
      name: '男生',
      type: 'line',
      smooth: false,
      symbol: 'circle',
      symbolSize: 5,
      showSymbol: true,
      lineStyle: {
        normal: {
          color: '#319AE7',
          width: 1
        }
      },
      areaStyle: {
        normal: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
            offset: 0,
            color: 'rgba(137, 189, 27, 0.3)'
          }, {
            offset: 0.8,
            color: 'rgba(137, 189, 27, 0)'
          }], false),
          shadowColor: 'rgba(0, 0, 0, 0.1)',
          shadowBlur: 10
        }
      },
      itemStyle: {
        normal: {
          color: 'rgb(40,174,246)',
          borderColor: 'rgba(40,174,246,0.27)',
          borderWidth: 12
        }
      },
      data: [400, 600, 440, 90, 500, 180, 260, 450]
    }, {
      name: '女生',
      type: 'line',
      smooth: false,
      symbol: 'circle',
      symbolSize: 5,
      showSymbol: true,
      lineStyle: {
        normal: {
          width: 1,
          color: '#9166DB',
        }
      },
      areaStyle: {
        normal: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
            offset: 0,
            color: 'rgba(101,32,128, 1)'
          }, {
            offset: 1,
            color: 'rgba(0, 136, 212, 0)'
          }], false),
          shadowColor: 'rgba(0, 0, 0, 0.1)',
          shadowBlur: 10
        }
      },
      itemStyle: {
        normal: {
          color: 'rgb(166,112,243)',
          borderColor: 'rgba(166,112,243,0.2)',
          borderWidth: 12

        }
      },
      data: [350, 320, 300, 240, 350, 460, 280, 400],
    }]
  };
  myChartCenter2.setOption(optionCenter2);
}
 */
/*右边第一个柱状图*/
/* var myRight1 = echarts.init(document.getElementById('right1'));
function renderRight1() {
  var optionRight1 = {
    title: {
      text: '师生比',
      subtext: 'Teacher-student ratio',
      textStyle: {
        color: '#fff'
      }
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'shadow'
      }
    },
    legend: {
      data: ['学生', '老师'],
      itemWidth: 14,
      itemHeight: 14,
      textStyle: {
        color: '#fff'
      }
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true
    },
    xAxis: {
      type: 'value',
      boundaryGap: [0, 0.01],
      axisLabel: {
        textStyle: {color: '#fff'}
      },
      splitLine: {
        show: false
      },
    },
    yAxis: {
      type: 'category',
      data: ['四川大学', '西南交通大学', '西南石油大学', '成都体育学院', '成都大学'],
      axisLabel: {
        textStyle: {color: '#fff'}
      }
    },

    series: [
      {
        name: '学生',
        type: 'bar',
        data: [35874, 28203, 13489, 19034, 20000],
        itemStyle: {
          normal: {
            color: '#319AE7',
          },
        },
        label: {
          normal: {
            show: true,
            position: 'right',
            color: '#fff'
          }
        },
      },
      {
        name: '老师',
        type: 'bar',
        data: [1000, 900, 3438, 6000, 2000],
        label: {
          normal: {
            show: true,
            position: 'right',
            color: '#fff'
          }
        },
        itemStyle: {
          normal: {
            color: '#9166DB',
          }
        },
      },
    ]
  };
  myRight1.setOption(optionRight1);
}
 */
/*右边第二个*/
/* var myRight2 = echarts.init(document.getElementById('right2'));
function renderRight2() {
  optionRight2 = {
    title: {
      text: '校园搜搜搜',
      subtext: 'Hot search',
      x: 'left',
      textStyle: {
        color: '#fff'
      }
    },
    tooltip: {
      show: true
    },
    series: [{
      width: '100%',
      height: '100%',
      left: 0,
      top: 60,
      name: '热门搜索',
      type: 'wordCloud',
      gap: 20,
      sizeRange: [12, 30],
      rotationRange: [0, 30, 60, 90, -45],
      autoSize: {
        enable: true,
        minSize: 10
      },
      textStyle: {
        normal: {
          color: function () {
            return 'rgb(' + [
              Math.round(Math.random() * 160),
              Math.round(Math.random() * 160),
              Math.round(Math.random() * 160)
            ].join(',') + ')';
          }
        },
        emphasis: {
          shadowBlur: 10,
          shadowColor: '#333'
        }
      },
      data: [{
        name: "Jayfee",
        value: 666
      }, {
        name: "Nancy",
        value: 520
      }]
    }]
  };

  var JosnList = [];

  JosnList.push({
    name: "Jayfee",
    value: 666
  }, {
    name: "Nancy",
    value: 520
  }, {
    name: "教育管理",
    value: "112"
  }, {
    name: "社会保障",
    value: "112"
  }, {
    name: "生活用水管理",
    value: "112"
  }, {
    name: "物业服务与管理",
    value: "112"
  }, {
    name: "分类列表",
    value: "112"
  }, {
    name: "农业生产",
    value: "112"
  }, {
    name: "二次供水问题",
    value: "112"
  }, {
    name: "城市公共设施",
    value: "92"
  }, {
    name: "拆迁政策咨询",
    value: "92"
  }, {
    name: "物业服务",
    value: "92"
  }, {
    name: "物业管理",
    value: "92"
  }, {
    name: "社会保障保险管理",
    value: "92"
  }, {
    name: "低保管理",
    value: "92"
  }, {
    name: "文娱市场管理",
    value: "72"
  }, {
    name: "城市交通秩序管理",
    value: "72"
  }, {
    name: "执法争议",
    value: "72"
  }, {
    name: "商业烟尘污染",
    value: "72"
  }, {
    name: "占道堆放",
    value: "71"
  }, {
    name: "地上设施",
    value: "71"
  }, {
    name: "水质",
    value: "71"
  }, {
    name: "无水",
    value: "71"
  }, {
    name: "供热单位影响",
    value: "141"
  }, {
    name: "人行道管理",
    value: "71"
  }, {
    name: "主网原因",
    value: "71"
  }, {
    name: "集中供热",
    value: "71"
  }, {
    name: "客运管理",
    value: "111"
  }, {
    name: "国有公交（大巴）管理",
    value: "71"
  }, {
    name: "工业粉尘污染",
    value: "71"
  }, {
    name: "生产噪声",
    value: "41"
  }, {
    name: "农村低保",
    value: "51"
  }, {
    name: "劳动争议",
    value: "41"
  }, {
    name: "劳动合同争议",
    value: "61"
  }, {
    name: "劳动报酬与福利",
    value: "141"
  }, {
    name: "医疗事故",
    value: "214"
  });
  optionRight2.series[0].data = JosnList;
  console.log(JosnList);
  myRight2.on('click', function (params) {
    //alert((params.name));
    window.open('https://www.baidu.com/s?wd=' + encodeURIComponent(params.name));

  });
  myRight2.setOption(optionRight2);
} */

/*右边第三个*/
/* var myRight3 = echarts.init(document.getElementById('right3'));
function renderRight3() {
  var optionRight3 = {
    title: {
      text: '学院排名',
      subtext: 'Academy rank',
      x: 'left',
      textStyle: {
        color: '#fff'
      }

    },
    tooltip: { //提示框组件
      trigger: 'axis',
      formatter: '{b}<br />{a0}: {c0}<br />排名: {c}',
      axisPointer: {
        type: 'shadow',
        label: {
          backgroundColor: '#6a7985'
        }
      },
      textStyle: {
        color: '#fff',
        fontStyle: 'normal',
        fontFamily: '微软雅黑',
        fontSize: 12,
      }
    },
    xAxis: [
      {
        type: 'category',
        boundaryGap: false,//坐标轴两边留白
        data: ['通信学院', '艺术学院', '英语学院', '计算机学院', '工程学院'],
        axisLabel: { //坐标轴刻度标签的相关设置。
          interval: 0,//设置为 1，表示『隔一个标签显示一个标签』
          margin: 5,
          textStyle: {
            color: '#fff',
            fontStyle: 'normal',
            fontFamily: '微软雅黑',
            fontSize: 12,
          }
        },
        axisTick: {//坐标轴刻度相关设置。
          show: false,
        },
        axisLine: {//坐标轴轴线相关设置
          lineStyle: {
            color: '#fff',
            opacity: 0.2
          }
        },
        splitLine: { //坐标轴在 grid 区域中的分隔线。
          show: false,
        }
      }
    ],
    yAxis: [
      {
        type: 'value',
        splitNumber: 5,
        axisLabel: {
          textStyle: {
            color: '#a8aab0',
            fontStyle: 'normal',
            fontFamily: '微软雅黑',
            fontSize: 12,
          }
        },
        axisLine: {
          show: false
        },
        axisTick: {
          show: false
        },
        splitLine: {
          show: true,
          lineStyle: {
            color: ['#fff'],
            opacity: 0.06
          }
        }

      }
    ],
    grid: {
      x: '10%',
      y: 70,
      x2: '10%',
      y2: '10%',
    },
    series: [
      {
        name: '分数',
        type: 'bar',
        data: [100, 90, 80, 70, 60, 50],
        barWidth: 10,
        barGap: 20,//柱间距离
        label: {//图形上的文本标签
          normal: {
            show: true,
            position: 'top',
            textStyle: {
              color: '#fff',
              fontStyle: 'normal',
              fontFamily: '微软雅黑',
              fontSize: 12,
            },
          },
        },
        itemStyle: {//图形样式
          normal: {
            barBorderRadius: [5, 5, 0, 0],
            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
              offset: 1, color: 'rgba(127, 128, 225, 0.7)'
            }, {
              offset: 0.9, color: 'rgba(72, 73, 181, 0.7)'
            }, {
              offset: 0.31, color: 'rgba(0, 208, 208, 0.7)'
            }, {
              offset: 0.15, color: 'rgba(0, 208, 208, 0.7)'
            }, {
              offset: 0, color: 'rgba(104, 253, 255, 0.7)'
            }], false),
          },
        },
      },
    ]
  };
  myRight3.setOption(optionRight3);
} */

//renderItem.renderLeft1();
//renderItem.renderLeft2();
//renderItem.renderLeft3();
renderItem.renderMap();
//renderItem.renderCenter2();
//renderItem.renderRight1();
//renderItem.renderRight2();
//renderItem.renderRight3();
window.onresize=function () {
  //myChartLeft1.resize();
  //myChartLeft2.resize();
  //myChartLeft3.resize();
  myChartCenter1.resize();
  //myChartCenter2.resize();
  //myRight1.resize();
  //myRight2.resize();
  //myRight3.resize();
};	
</script>


</body>
</html>