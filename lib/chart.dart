import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  int joyCount, angerCount,neutralCount , sadnessCount, fearCount;
  PieChartSample2(this.joyCount,this.angerCount,this.neutralCount,this.sadnessCount,this.fearCount);
  @override
  State<StatefulWidget> createState() => PieChart2State(joyCount,angerCount,neutralCount , sadnessCount, fearCount);
}

class PieChart2State extends State {
  int touchedIndex = -1;
  int joyCount, angerCount,neutralCount , sadnessCount, fearCount;
  PieChart2State(this.joyCount,this.angerCount,this.neutralCount,this.sadnessCount,this.fearCount);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(joyCount,angerCount,neutralCount,sadnessCount,fearCount)),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Color(0xFFF66D44),
                  text: 'Joy',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xFFFEAE65),
                  text: 'Anger',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xFFAADEA7),
                  text: 'Neutral',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xFF64C2A6),
                  text: 'Sadness',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xFF2D87BB),
                  text: 'Fear',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(int joyCount, int angerCount, int neutralCount, int sadnessCount, int fearCount) {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 15.0;
      final radius = isTouched ? 60.0 : 50.0;
      int total = joyCount + angerCount + neutralCount + sadnessCount + fearCount;
      switch (i) {
        case 0:
          return PieChartSectionData(
           // color: const Color(0xff0293ee),
           // color: Color(0xFF0F2C67),
            color: Color(0xFFF66D44),
            value: joyCount.toDouble(),
            title: '${((joyCount * 100 )/(total)).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
           // color: const Color(0xfff8b250),
            //  color: Color(0xFFCD1818),
            color: Color(0xFFFEAE65),
            value: angerCount.toDouble(),
            title: '${((angerCount * 100 )/(total)).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            // color: const Color(0xff845bef),
          //  color: Color(0xFFF3950D),
            color: Color(0xFFAADEA7),
            value: neutralCount.toDouble(),
            title: '${((neutralCount * 100 )/(total)).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
          //  color: const Color(0xff13d38e),
          //     color: Color(0xFFF4E185),
           // color: Colors.green,
            color: Color(0xFF64C2A6),
            value: sadnessCount.toDouble(),
            title: '${((sadnessCount * 100)/(total) ).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
         //   color: Colors.orange,
           // color: Colors.green,
           //  color: Color(0xFFF4E185),
            color: Color(0xFF2D87BB),
            value: fearCount.toDouble(),
            title: '${((fearCount * 100 )/(total)).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}