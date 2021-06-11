import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:soccer/src/models/statisticsdao.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({
    Key key,
    @required this.team,
  }) : super(key: key);

  final team;

  @override
  State<StatefulWidget> createState() => PieChart2State(team);
}

class PieChart2State extends State {
  int touchedIndex;
  StatisticsDAO teamStatistics;

  PieChart2State(team){
    this.teamStatistics = team;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.0,
      child: Card(
        color: Color(0x00000000),
        child: Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch && pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(teamStatistics)),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color(0xff00c8b9),
                      size: 10,
                    ),
                    Text('Win',style: TextStyle(fontSize: 12),),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color(0xff654dd6),
                      size: 10,
                    ),
                    Text('Loss',style: TextStyle(fontSize: 12),),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color(0xff008cdb),
                      size: 12,
                    ),
                    Text('Draw' ,style: TextStyle(fontSize: 12),),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.black,
                    elevation: 5,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      width: 95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(child: Text('Goals for', overflow: TextOverflow.clip, style: TextStyle(color: Colors.white.withOpacity(0.6)))),
                          Text(
                            '${teamStatistics.intGoalsFor}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.black,
                    elevation: 5,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      width: 95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(child: Text('Difference', overflow: TextOverflow.clip, style: TextStyle(color: Colors.white.withOpacity(0.6)))),
                          Text(
                            '${teamStatistics.intGoalDifference}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.black,
                    elevation: 5,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      width: 95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(child: Text('Goals against', overflow: TextOverflow.clip, style: TextStyle(color: Colors.white.withOpacity(0.6)))),
                          Text(
                            '${teamStatistics.intGoalsAgainst}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.black,
                    elevation: 5,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      width: 95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(child: Text('Points', overflow: TextOverflow.clip, style: TextStyle(color: Colors.white.withOpacity(0.6)))),
                          Text(
                            '${teamStatistics.intPoints}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(StatisticsDAO teamStatistics) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff00c8b9),
            value: double.parse(teamStatistics.intWin),
            title: teamStatistics.intWin,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff654dd6),
            value: double.parse(teamStatistics.intLoss),
            title: teamStatistics.intLoss,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff008cdb),
            value: double.parse(teamStatistics.intDraw),
            title: teamStatistics.intDraw,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}