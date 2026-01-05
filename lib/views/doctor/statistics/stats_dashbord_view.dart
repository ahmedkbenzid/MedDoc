import 'package:flutter_application_1/consts/consts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class StatsDashboardView extends StatefulWidget {
  const StatsDashboardView({super.key});

  @override
  State<StatsDashboardView> createState() => _StatsDashboardViewState();
}

class _StatsDashboardViewState extends State<StatsDashboardView> {
  // Mock data - replace with actual data from your backend
  final appointments = [24, 30, 18, 20, 25, 15, 28];
  final absences = [2, 1, 3, 0, 2, 1, 0];
  final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  
  int touchedIndex = -1;

  // Calculate summary metrics
  int get totalAppointments => appointments.reduce((a, b) => a + b);
  int get totalAbsences => absences.reduce((a, b) => a + b);
  double get averageAppointments => totalAppointments / appointments.length;
  double get absenceRate => (totalAbsences / totalAppointments) * 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  AppStyles.bold(
          title: "Statistics Dashboard",
          color: AppColors.whiteColor,
          size: 18,
        ),
        backgroundColor: AppColors.blueColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed:  () {
              // Add date range picker
            },
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed:  () {
              // Export functionality
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Add refresh logic
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              // Summary Cards
              _buildSummaryCards(),
              24.heightBox,
              
              // Appointments Chart
              _buildChartSection(
                title: "Weekly Appointments",
                chart: _buildAppointmentsChart(),
              ),
              24.heightBox,
              
              // Absences Chart
              _buildChartSection(
                title: "Weekly Absences",
                chart: _buildAbsencesChart(),
              ),
              24.heightBox,
              
              // Appointment Rate (Pie Chart)
              _buildChartSection(
                title: "Attendance Rate",
                chart: _buildPieChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            title:  "Total Appointments",
            value: totalAppointments.toString(),
            icon: Icons.calendar_month,
            color: AppColors.blueColor,
          ),
        ),
        12.widthBox,
        Expanded(
          child: _buildSummaryCard(
            title: "Avg/Day",
            value: averageAppointments.toStringAsFixed(1),
            icon: Icons.trending_up,
            color: Colors.green,
          ),
        ),
      ],
    ).paddingOnly(bottom: 8);
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Icon(icon, color: color, size: 24),
              AppStyles.bold(
                title: value,
                color: color,
                size: 24,
              ),
            ],
          ),
          8.heightBox,
          AppStyles.normal(
            title: title,
            color: AppColors.textColor. withOpacity(0.7),
            size: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection({
    required String title,
    required Widget chart,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:  Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppStyles.bold(
            title: title,
            color: AppColors.textColor,
            size: 16,
          ),
          16.heightBox,
          chart,
        ],
      ),
    );
  }

  Widget _buildAppointmentsChart() {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 40,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.black87,
              tooltipPadding: const EdgeInsets.all(8),
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${days[group.x.toInt()]}\n${rod.toY.toInt()} appointments',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          barGroups: List.generate(appointments.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: appointments[index]. toDouble(),
                  color:  AppColors.blueColor,
                  width: 18,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.blueColor.withOpacity(0.7),
                      AppColors.blueColor,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ],
            );
          }),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles:  false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= days.length) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      days[idx],
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight. bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine:  (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Widget _buildAbsencesChart() {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 5,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor:  (group) => Colors.black87,
              tooltipPadding: const EdgeInsets.all(8),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${days[group.x.toInt()]}\n${rod.toY.toInt()} absences',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          barGroups: List.generate(absences. length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: absences[index].toDouble(),
                  color: Colors.redAccent,
                  width: 18,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.redAccent.withOpacity(0.7),
                      Colors.redAccent,
                    ],
                    begin:  Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ],
            );
          }),
          titlesData: FlTitlesData(
            show:  true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles:  SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value. toInt().toString(),
                    style: const TextStyle(fontSize:  10),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final idx = value. toInt();
                  if (idx < 0 || idx >= days.length) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      days[idx],
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey. withOpacity(0.2),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return SizedBox(
      height:  200,
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius:  40,
                sections: [
                  PieChartSectionData(
                    value:  totalAppointments. toDouble(),
                    title: '${(100 - absenceRate).toStringAsFixed(1)}%',
                    color: Colors.green,
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight. bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: totalAbsences.toDouble(),
                    title: '${absenceRate.toStringAsFixed(1)}%',
                    color: Colors.redAccent,
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize:  12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          16.widthBox,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLegendItem("Attended", Colors.green, totalAppointments),
              8.heightBox,
              _buildLegendItem("Absent", Colors.redAccent, totalAbsences),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, int value) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        8.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.normal(
              title: label,
              color: AppColors.textColor,
              size: 12,
            ),
            AppStyles.bold(
              title: value.toString(),
              color: AppColors. textColor,
              size: 14,
            ),
          ],
        ),
      ],
    );
  }
}