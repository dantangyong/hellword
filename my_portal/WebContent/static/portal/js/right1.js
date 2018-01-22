
	var myChart4 = echarts.init(document.getElementById('right1'));
	var option4 = {
    title: {
        text: '全省学校分析',
        subtext: 'Analyze provincial schools',
		textStyle: {
            color: '#33ff33'
        }
    },
    tooltip: {
        trigger: 'axis',
        axisPointer: {
            type: 'shadow'
        }
    },
    legend: {
        data: ['城区', '乡镇','农村'],
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
		axisLabel:{
			textStyle:{color: '#fff'}
        }
    },
    yAxis: {
        type: 'category',
        data: ['学前学校数','中小学学校数','中职学校数','高中学校数','全省学校数'],
		axisLabel:{
			textStyle:{color: '#fff'}
        }
    },
	
    series: [
        {
            name: '城区',
            type: 'bar',
            data: [15874,28203, 13489, 19034, 65874]
        },
        {
            name: '乡镇',
            type: 'bar',
            data: [5043,9325, 3438, 14000, 35043]
        },
        {
            name: '农村',
            type: 'bar',
            data: [2323,6325, 438, 10000, 18323]
        }
    ]
	};
	myChart4.setOption(option4);