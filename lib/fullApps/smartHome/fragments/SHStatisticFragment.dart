import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/smartHome/model/SHModel.dart';
import 'package:prokit_flutter/fullApps/smartHome/utils/SHColors.dart';
import 'package:prokit_flutter/fullApps/smartHome/utils/SHDataProvider.dart';

class SHStatisticFragment extends StatefulWidget {
  static String tag = '/SHStatisticFragment';
  List<Color> availableColors = [
    purple,
    yellow,
    mediumSlateBlue,
    orange,
    orchid,
    violet,
  ];

  @override
  SHStatisticFragmentState createState() => SHStatisticFragmentState();
}

class SHStatisticFragmentState extends State<SHStatisticFragment> {
  late List<ExpenseData> chartData;
  List<SHModel> statisticList = getStatisticList();
  List<Color> graphContainerColor = [Color(0xFF3B3340), Color(0xFF3C3441), Color(0xFF29313E), Color(0xFF2B354E)];
  final Color barBackgroundColor = SHScaffoldDarkColor;
  final Duration animDuration = Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    chartData = getChartData();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SHScaffoldDarkColor,
      appBar: AppBar(
        title: Text("Statistic", style: boldTextStyle(color: white)),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: SHScaffoldDarkColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Power Consume", style: boldTextStyle(size: 22, color: white)),
                16.height,
                Container(
                  height: 300,
                  width: context.width(),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: radius(16),
                    gradient: LinearGradient(colors: graphContainerColor),
                  ),
                  padding: EdgeInsets.all(24),
                  child: BarChart(
                    isPlaying ? randomData() : mainBarData(),
                    swapAnimationDuration: animDuration,
                  ),
                ),
                28.height,
                Text("Most Used", style: boldTextStyle(size: 22, color: white)).paddingLeft(8),
              ],
            ).paddingAll(8),
            16.height,
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
              separatorBuilder: (_, i) => Divider(color: gray),
              shrinkWrap: true,
              reverse: true,
              itemCount: statisticList.length,
              itemBuilder: (_, index) {
                SHModel data = statisticList[index];
                return Container(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Image.asset(data.img.validate(), fit: BoxFit.cover, height: 20, width: 20, color: white),
                      16.width,
                      Text(data.name!, style: boldTextStyle(color: white)).expand(),
                      Text(data.subtitle!, style: secondaryTextStyle()),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = salmon,
    double width = 24,
    List<int>? showTooltips,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 2 : y,
          gradient: LinearGradient(colors: [barColor, mediumSlateBlue]),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          width: width,
          backDrawRodData: BackgroundBarChartRodData(show: true, fromY: 0, toY: 80, color: barBackgroundColor),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    return List.generate(
      7,
      (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 22, isTouched: i == touchedIndex, barColor: SHScaffoldDarkColor);
          case 1:
            return makeGroupData(1, 30, isTouched: i == touchedIndex, barColor: SHScaffoldDarkColor);
          case 2:
            return makeGroupData(2, 18, isTouched: i == touchedIndex, barColor: SHScaffoldDarkColor);
          case 3:
            return makeGroupData(3, 40, isTouched: i == touchedIndex, barColor: SHScaffoldDarkColor);
          case 4:
            return makeGroupData(4, 80, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 10, isTouched: i == touchedIndex, barColor: SHScaffoldDarkColor);
          case 6:
            return makeGroupData(6, 35, isTouched: i == touchedIndex, barColor: SHScaffoldDarkColor);

          default:
            return throw Error();
        }
      },
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => grey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '15';
                  break;
                case 1:
                  weekDay = '11 ';
                  break;
                case 2:
                  weekDay = '12';
                  break;
                case 3:
                  weekDay = '13';
                  break;
                case 4:
                  weekDay = '14';
                  break;
                case 5:
                  weekDay = '15';
                  break;
                case 6:
                  weekDay = '16';
                  break;

                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                boldTextStyle(),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: TextStyle(
                      color: yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (flTouchEvent, barTouchResponse) {
          setState(() {
            if (barTouchResponse?.spot != null) {
              touchedIndex = barTouchResponse!.spot!.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              TextStyle style = primaryTextStyle(size: 14, color: white);
              String text = '';
              if (value == 0) {
                text = 'All Time';
              } else if (value == 6) {
                text = '2,000 W';
              }
              return Text(text, style: style);
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              TextStyle style = secondaryTextStyle();
              String text;
              switch (value.toInt()) {
                case 0:
                  text = '10';
                  break;
                case 1:
                  text = '11';
                  break;
                case 2:
                  text = '12';
                  break;
                case 3:
                  text = '13';
                  break;
                case 4:
                  text = '14';
                  break;
                case 5:
                  text = '15';
                  break;
                case 6:
                  text = '16';
                  break;
                default:
                  return SizedBox();
              }

              return Text(text, style: style);
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(),
      minY: 5,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              TextStyle style = secondaryTextStyle(color: grey);
              String text;
              switch (value.toInt()) {
                case 0:
                  text = '10';
                  break;
                case 1:
                  text = '11';
                  break;
                case 2:
                  text = '12';
                  break;
                case 3:
                  text = '13';
                  break;
                case 4:
                  text = '14';
                  break;
                case 5:
                  text = '15';
                  break;
                case 6:
                  text = '16';
                  break;
                default:
                  return SizedBox();
              }

              return Text(text, style: style);
            },
          ),
        ),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(animDuration + Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}
