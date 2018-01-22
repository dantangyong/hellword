
	var geoCoordMap = {
		"成都市": [104.065735, 30.659462],
		"资阳市": [104.641917, 30.122211],		
		"巴中市": [106.753669, 31.858809],
		"雅安市": [103.001033, 29.987722],
		"达州市": [107.502262, 31.209484],
		"广安市": [106.633369, 30.456398],
		"宜宾市": [104.630825, 28.760189],
		"眉山市": [103.831788, 30.048318],
		"南充市": [106.082974, 30.795281],
		"乐山市": [103.761263, 29.582024],
		"内江市": [105.066138, 29.58708],
		"遂宁市": [105.571331, 30.513311],
		"广元市": [105.829757, 32.433668],
		"绵阳市": [104.741722, 31.46402],
		"德阳市": [104.398651, 31.127991],
		"泸州市": [105.443348, 28.889138],
		"攀枝花市": [101.716007, 26.580446],
		"凉山彝族自治州": [102.258746, 27.886762],
		"甘孜藏族自治州": [101.963815, 30.050663],
		"阿坝藏族羌族自治州": [102.221374, 31.899792]
	};
	
	var data = [{
		name: "成都市",
		value: 257
	}, {
		name: "资阳市",
		value: 133
	}, {
		name: "巴中市",
		value: 191
	}, {
		name: "雅安市",
		value: 171
	}, {
		name: "达州市",
		value: 143
	}, {
		name: "广安市",
		value: 114
	}, {
		name: "宜宾市",
		value: 101
	}, {
		name: "眉山市",
		value: 79
	}, {
		name: "南充市",
		value: 194
	}, {
		name: "乐山市",
		value: 91
	}, {
		name: "内江市",
		value: 225
	}, {
		name: "遂宁市",
		value: 143
	}, {
		name: "广元市",
		value: 115
	}, {
		name: "绵阳市",
		value: 201
	}, {
		name: "德阳市",
		value: 211
	}, {
		name: "泸州市",
		value: 174
	}, {
		name: "攀枝花市",
		value: 181
	}, {
		name: "自贡市",
		value: 143
	}, {
		name: "凉山彝族自治州",
		value: 34
	}, {
		name: "甘孜藏族自治州",
		value: 25
	}, {
		name: "阿坝藏族羌族自治州",
		value: 17
	}];
	
	var color = ['#ff3333', 'orange', 'yellow','lime','aqua']
	
	function formtVData(geoData, data, srcNam) {
        var tGeoDt = [];
        for (var i = 0, len = data.length; i < len; i++) {
            var tNam = data[i].name
            tGeoDt.push({
				name: tNam,
				value: geoData[tNam],
				"itemStyle": {
					"normal": {
						"color": color[i%5]
					}
				}
			});
        }
        return tGeoDt;
    }
	
	echarts.registerMap('sichuan', sichuanJson);//hennanJson名称取自henan.js里的var  henanJson变量名
	var myChart1 = echarts.init(document.getElementById('center'));
	var option1 = {
		title: {			
			text: '四川省教育综合管理情况',			
			left: 'center',
			textStyle:{
				color : '#FFFFFF',
				fontSize : '40',
				fontFamily : '宋体'
			}
		},
		tooltip:{
			formatter : function(params){
				for(var i = 0; i < data.length; i++ ){
					if(data[i].name == params.name){
						return "中学学校数量:"+ data[i].value*41+"<br/>"+"小学学校数量:"+ data[i].value*23;
					}
				}			
			}
		},
		geo: {
			map: 'sichuan',
			label: {
				emphasis: {
					show: false,
				}
			},
			roam: true,			
			itemStyle: {
				normal: {
					areaColor: '#0099ff',
					borderColor: '#000',
					borderWidth : 1.5,
					opacity : 0.3
				},
				emphasis: {
					areaColor: '#2a333d'
				}
			}
		},
		series: [
		{
			type: 'effectScatter',
			coordinateSystem: 'geo',
			zlevel: 2,
			rippleEffect: {
                brushType: 'stroke',
                period: 5,
                scale: 6
            },
			label: {
                normal: {
                    show: true,
                    position: 'top',
                    formatter: '{b}'
                }
            },
			symbolSize: 20,
			itemStyle: {
				normal: {
					color: '#0D6695',
					borderColor: 'gold'
				}
			},
			data: formtVData(geoCoordMap, data, '成都')
		}]
	};
	myChart1.setOption(option1);