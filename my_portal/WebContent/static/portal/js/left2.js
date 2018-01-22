
	var myChart3 = echarts.init(document.getElementById('left2'));
	var option3 = {
    

    title: {
        text: '全省教师分析',
		subtext: 'Analyze the teacher of the province',
        left: 'center',
        top: 20,
        textStyle: {
            color: '#88B8FF'
        }
    },

    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },

    visualMap: {
        show: false,
        min: 10080,
        max: 50000,
        inRange: {
            colorLightness: [0, 1]
        }
    },
    series : [
        {
            name:'全省教师分析',			
            type:'pie',
            radius : '55%',
            center: ['50%', '50%'],
            data:[
                {value:33512, name:'高校教师占比'},
                {value:31041, name:'学前教师占比'},
                {value:27444, name:'中小学教师占比'},
                {value:23564, name:'中职学生占比'}
            ].sort(function (a, b) { return a.value - b.value; }),
            roseType: 'radius',
            label: {
                normal: {
                    textStyle: {
                        color: '#fff'
                    }
                }
            },
            labelLine: {
                normal: {
                    lineStyle: {
                        color: 'rgba(255, 255, 255, 0.3)'
                    },
                    smooth: 0.2,
                    length: 10,
                    length2: 20
                }
            },
            itemStyle: {
                normal: {
                    color: '#c23531',
                    shadowBlur: 200,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
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
	myChart3.setOption(option3);