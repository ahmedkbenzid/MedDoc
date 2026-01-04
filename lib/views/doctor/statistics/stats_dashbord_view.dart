import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:fl_chart/fl_chart.dart'; // package pour les graphiques

class StatsDashboardView extends StatelessWidget {
  const StatsDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final appointments = [24, 30, 18, 20, 25, 15, 28]; // rendez-vous par jour
    final absences = [2, 1, 3, 0, 2, 1, 0]; // absences par jour
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(
          title: "Statistics Dashboard",
          color: AppColors.whiteColor,
          size: 18,
        ),
        backgroundColor: AppColors.blueColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.bold(
              title: "Weekly Appointments",
              color: AppColors.textColor,
              size: 16,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 40,
                  barGroups: List.generate(appointments.length, (index) {
                    return BarChartGroupData(x: index, barRods: [
                      BarChartRodData(
                        toY: appointments[index].toDouble(),
                        color: AppColors.blueColor,
                        width: 18,
                      ),
                    ]);
                  }),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          final idx = value.toInt();
                          if (idx < 0 || idx >= days.length) return const SizedBox();
                          return Text(days[idx]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            20.heightBox,
            AppStyles.bold(
              title: "Weekly Absences",
              color: AppColors.textColor,
              size: 16,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 5,
                  barGroups: List.generate(absences.length, (index) {
                    return BarChartGroupData(x: index, barRods: [
                      BarChartRodData(
                        toY: absences[index].toDouble(),
                        color: Colors.redAccent,
                        width: 18,
                      ),
                    ]);
                  }),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          final idx = value.toInt();
                          if (idx < 0 || idx >= days.length) return const SizedBox();
                          return Text(days[idx]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
