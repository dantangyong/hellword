
	var myChart2 = echarts.init(document.getElementById('left1'));
	var option2 = option = {
		
		title: {			
			text: '全省学生分析',
			subtext: 'Analyze the students of the province',			
			left: 'center',
			textStyle:{
				color : '#ffcc66',
				fontSize : '20',
				fontFamily : '宋体'
			}
		},
		series: [{
			type: 'pie',
			radius: ['35%', '55%'],
			silent: true,
			data: [{
				value: 1,
				itemStyle: {
					normal: {
						color: '#050f58',
						borderColor: '#162abb',
						borderWidth: 2,
						shadowBlur: 50,
						shadowColor: 'rgba(21,41,185,.75)'
					}
				}
			}]
		}, {
			type: 'pie',
			radius: ['36%', '50%'],
			silent: true,
			label: {
				normal: {
					show: false,
				}
			},
			data: [{
				value: 1,
				itemStyle: {
					normal: {
						color: '#050f58',
						shadowBlur: 50,
						shadowColor: 'rgba(21,41,185,.75)'
					}
				}
			}]
		}, {
			name: '占比',
			type: 'pie',
			radius: ['36%', '50%'],
			hoverAnimation: false,

			data: [{
				value: 10,
				name: "学前学生占比",
				itemStyle: {
					normal: {
						label: {
							show: true,
							textStyle: {
								fontSize: 15,
								fontWeight: "bold"
							},
							position: "center"
						},
						color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
							offset: 0,
							color: 'rgba(5,193,255,1)'
						}, {
							offset: 1,
							color: 'rgba(15,15,90,1)'
						}])
					}
				},
				label: {
					normal: {
						position: 'outside',
						textStyle: {
							color: '#fff',
							fontSize: 14
						},
						formatter: '{b}: {c}%\n\n人数:1231234 '
					}
				},
				labelLine: {
					normal: {
						show: true,
						length: 10,
						length2: 15,
						smooth: false,
						lineStyle: {
							width: 1,
							color: "#2141b5"
						}
					}
				}
			}, {
				value: 30,
				name: "高校学生占比",
				itemStyle: {
					normal: {
						label: {
							show: true,
							textStyle: {
								fontSize: 15,
								fontWeight: "bold"
							},
							position: "center"
						},
						color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
							offset: 0,
							color: 'rgba(23,210,272,1)'
						}, {
							offset: 1,
							color: 'rgba(11,123,190,1)'
						}])
					}
				},
				label: {
					normal: {
						position: 'outside',
						textStyle: {
							color: '#fff',
							fontSize: 14
						},
						formatter: '{b}: {c}%\n\n人数:2631234 '
					}
				},
				labelLine: {
					normal: {
						show: true,
						length: 10,
						length2: 15,
						smooth: false,
						lineStyle: {
							width: 1,
							color: "#2141b5"
						}
					}
				}
			},{
				value: 40,
				name: "中小学学生占比",
				itemStyle: {
					normal: {
						label: {
							show: true,
							textStyle: {
								fontSize: 15,
								fontWeight: "bold"
							},
							position: "center"
						},
						color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
							offset: 0,
							color: 'rgba(55,112,255,1)'
						}, {
							offset: 1,
							color: 'rgba(54,151,60,1)'
						}])
					}
				},
				label: {
					normal: {
						position: 'outside',
						textStyle: {
							color: '#fff',
							fontSize: 14
						},
						formatter: '{b}: {c}%\n\n人数:3453452 '
					}
				},
				labelLine: {
					normal: {
						show: true,
						length: 10,
						length2: 15,
						smooth: false,
						lineStyle: {
							width: 1,
							color: "#2141b5"
						}
					}
				}
			},{
				value: 20,
				name: "中职学生占比",
				itemStyle: {
					normal: {
						label: {
							show: true,
							textStyle: {
								fontSize: 15,
								fontWeight: "bold"
							},
							position: "center"
						},
						color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
							offset: 0,
							color: 'rgba(5,15,88,1)'
						}, {
							offset: 1,
							color: 'rgba(235,122,255,1)'
						}])
					}
				},
				label: {
					normal: {
						position: 'outside',
						textStyle: {
							color: '#fff',
							fontSize: 14
						},
						formatter: '{b}: {c}%\n\n人数:4345435 '
					}
				},
				labelLine: {
					normal: {
						show: true,
						length: 10,
						length2: 15,
						smooth: false,
						lineStyle: {
							width: 1,
							color: "#2141b5"
						}
					}
				}
			}]
		}, {
			name: '',
			type: 'pie',
			clockWise: true,
			hoverAnimation: false,
			radius: [200, 200],
			label: {
				normal: {
					position: 'center'
				}
			},
			data: [{
				value: 0,
				label: {
					normal: {
						formatter: '12718271',
						textStyle: {
							color: '#fe8b53',
							fontSize: 25,
							fontWeight: 'bold'
						}
					}
				}
			}, {
				tooltip: {
					show: false
				},
				label: {
					normal: {
						formatter: '\n学生总数',
						textStyle: {
							color: '#bbeaf9',
							fontSize: 14
						}
					}
				}
			}]
		}]
	};
	myChart2.setOption(option2);