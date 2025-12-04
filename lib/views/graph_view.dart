import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class GraphView extends StatelessWidget {
  const GraphView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDark ? Colors.white : Colors.black;
    Color cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: Text("Weekly Analytics",
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Average Activity",
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      const SizedBox(height: 5),
                      Text("Level 3.2",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: textColor)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.show_chart,
                        color: Colors.blue, size: 30),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text("Activity Overview",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
            const SizedBox(height: 20),
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                      show: true,
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const style = TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12);
                                List<String> days = [
                                  'Mon',
                                  'Tue',
                                  'Wed',
                                  'Thu',
                                  'Fri',
                                  'Sat',
                                  'Sun'
                                ];
                                if (value.toInt() < days.length) {
                                  return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      space: 8,
                                      child: Text(days[value.toInt()],
                                          style: style));
                                }
                                return const SizedBox();
                              }))),
                  barGroups: [
                    _makeBar(0, 3, Colors.blue),
                    _makeBar(1, 1, Colors.blue.shade300),
                    _makeBar(2, 4, Colors.purple),
                    _makeBar(3, 2, Colors.blue),
                    _makeBar(4, 5, Colors.blueAccent),
                    _makeBar(5, 3, Colors.blue),
                    _makeBar(6, 4, Colors.purpleAccent),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text("Daily Breakdown",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
            const SizedBox(height: 10),
            _buildStatRow(
                "Monday", "3.0 Level", Colors.blue, cardColor, textColor),
            _buildStatRow("Tuesday", "1.0 Level", Colors.blue.shade300,
                cardColor, textColor),
            _buildStatRow(
                "Wednesday", "4.0 Level", Colors.purple, cardColor, textColor),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeBar(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 20,
          borderRadius: BorderRadius.circular(6),
          backDrawRodData: BackgroundBarChartRodData(
              show: true, toY: 6, color: Colors.grey.withOpacity(0.05)),
        ),
      ],
    );
  }

  Widget _buildStatRow(
      String day, String score, Color color, Color bgColor, Color textColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 15),
              Text(day,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: textColor)),
            ],
          ),
          Text(score,
              style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }
}
