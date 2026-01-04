import 'dart:math';

import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/views/doctor/doctor_appointment/agenda_view.dart';
import 'package:flutter_application_1/views/doctor/doctor_appointment/appointment_request_view.dart';
import 'package:flutter_application_1/views/doctor/doctor_profile/profile_view.dart';
import 'package:flutter_application_1/views/doctor/doctor_communication/message_list_view.dart';
import 'package:flutter_application_1/views/doctor/patient_records/patient_list_view.dart';
import 'package:flutter_application_1/views/doctor_profile_view/doctor_profile_view.dart';
import 'package:flutter_application_1/views/settings_view/settings_view.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_1/views/doctor/reminders/reminders_view.dart';
import 'package:flutter_application_1/views/doctor/statistics/stats_dashbord_view.dart';
import 'package:fl_chart/fl_chart.dart';

class DocHome extends StatefulWidget {
  const DocHome({super.key});

  @override
  State<DocHome> createState() => _DocHomeState();
}

class _DocHomeState extends State<DocHome> {
  int selectedIndex = 0;

  // Liste des écrans disponibles
  final List<Widget> screenList = [
    const DoctorHomeView(),
    AgendaView(),
    AppointmentRequestView(),
    const MessageListView(),
    const RemindersView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList. elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white. withOpacity(0.5),
        selectedItemColor: AppColors.whiteColor,
        selectedLabelStyle: TextStyle(color: AppColors.whiteColor),
        selectedIconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.blueColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items:  const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Agenda"),
          BottomNavigationBarItem(icon: Icon(Icons.request_page), label: "Requests"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Reminders"),
          BottomNavigationBarItem(icon: Icon(Icons. settings), label: "Settings"),
        ],
      ),
    );
  }
}

// Doctor Home View
class DoctorHomeView extends StatefulWidget {
  const DoctorHomeView({super.key});

  @override
  State<DoctorHomeView> createState() => _DoctorHomeViewState();
}

class _DoctorHomeViewState extends State<DoctorHomeView> {
  final AuthService _authService = AuthService();
  String doctorName = "Dr.  ";
  
  // Mock data for the chart
  final List<double> weeklyAppointments = [18, 22, 15, 24, 20, 12, 16];
  final List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  void initState() {
    super.initState();
    _loadDoctorName();
  }

  void _loadDoctorName() {
    User? currentUser = _authService.getCurrentUser();
    if (currentUser != null) {
      setState(() {
        String fullName = currentUser.userMetadata?['full_name'] ??  "";
        doctorName = fullName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(
          title: "Doctor Dashboard",
          color:  AppColors.whiteColor,
          size: AppSizes.size18,
        ),
        backgroundColor:  AppColors.blueColor,
        actions: [
          // Notification Badge
          Stack(
            children:  [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RemindersView()),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets. all(4),
                  decoration: BoxDecoration(
                    color:  Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors. white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Add refresh logic here
          await Future.delayed(const Duration(seconds: 1));
          setState(() {});
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enhanced Welcome Section
              _buildWelcomeCard(),
              20.heightBox,

              // Quick Action Buttons
              _buildQuickActions(),
              20.heightBox,

              // Enhanced Quick Stats with better visual hierarchy
              _buildQuickStats(),
              20.heightBox,

              // Weekly Overview Chart
              _buildWeeklyOverviewChart(),
              20.heightBox,

              // Upcoming Appointments Section
              _buildSectionHeader(
                title: "Upcoming Appointments",
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AgendaView()),
                  );
                },
              ),
              10.heightBox,
              _buildUpcomingAppointments(),
              20.heightBox,

              // Recent Activities
              _buildSectionHeader(
                title: "Recent Activities",
                onViewAll: () {},
              ),
              10.heightBox,
              _buildRecentActivities(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.blueColor, AppColors.blueColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueColor. withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 30,
                  child: Image.asset(AppAssets.imgSignup),
                ),
              ),
              15.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStyles.bold(
                      title: "Welcome back! ",
                      color: AppColors.whiteColor. withOpacity(0.9),
                      size: AppSizes.size14,
                    ),
                    5.heightBox,
                    AppStyles.bold(
                      title: "Dr. $doctorName",
                      color: AppColors.whiteColor,
                      size: AppSizes.size18,
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.person, color: AppColors.blueColor),
                        10.widthBox,
                        const Text("My Profile"),
                      ],
                    ),
                    onTap: () {
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DoctorProfileView(
                              doc: {
                                'docName': doctorName,
                                'docRating': (Random().nextDouble() * 2 + 3)
                                    .toStringAsFixed(1),
                              },
                              showBookingButton: false,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                  PopupMenuItem(
                    child: Row(
                      children:  [
                        Icon(Icons. folder, color: AppColors.blueColor),
                        10.widthBox,
                        const Text("Patient Records"),
                      ],
                    ),
                    onTap: () {
                      Future. delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:  (_) => const PatientListView(),
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          15.heightBox,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white. withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child:  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wb_sunny_outlined, color: Colors.white, size: 16),
                8.widthBox,
                AppStyles.normal(
                  title: _getGreeting(),
                  color: AppColors.whiteColor,
                  size: AppSizes.size12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning! ";
    if (hour < 17) return "Good Afternoon! ";
    return "Good Evening! ";
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionButton(
            icon: Icons.calendar_today,
            label: "Agenda",
            color: Colors.blue,
            onTap: () {
              Navigator. push(
                context,
                MaterialPageRoute(builder: (_) => AgendaView()),
              );
            },
          ),
        ),
        10.widthBox,
        Expanded(
          child: _buildQuickActionButton(
            icon: Icons.request_page,
            label: "Requests",
            color: Colors. orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AppointmentRequestView()),
              );
            },
          ),
        ),
        10.widthBox,
        Expanded(
          child: _buildQuickActionButton(
            icon: Icons.message,
            label: "Messages",
            color: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MessageListView()),
              );
            },
          ),
        ),
        10.widthBox,
        Expanded(
          child: _buildQuickActionButton(
            icon: Icons.bar_chart,
            label: "Statistics",
            color: Colors. purple,
            onTap:  () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StatsDashboardView()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap:  onTap,
      child:  Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color. withOpacity(0.1),
          borderRadius: BorderRadius. circular(12),
          border: Border.all(color: color. withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            8.heightBox,
            AppStyles.normal(
              title: label,
              color: color,
              size: 11,
              alignment: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.event_available,
                title: "4",
                subtitle: "Today's\nAppointments",
                color: Colors.blue,
                trend: "+12%",
                trendUp: true,
              ),
            ),
            10.widthBox,
            Expanded(
              child: _buildStatCard(
                icon: Icons.people_outline,
                title: "342",
                subtitle: "Total\nPatients",
                color: Colors.green,
                trend: "+8%",
                trendUp: true,
              ),
            ),
          ],
        ),
        10.heightBox,
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.calendar_month,
                title: "16",
                subtitle: "This Week",
                color: Colors.orange,
                trend: "+5%",
                trendUp: true,
              ),
            ),
            10.widthBox,
            Expanded(
              child:  _buildStatCard(
                icon: Icons.cancel_outlined,
                title: "2",
                subtitle: "Cancelled",
                color: Colors.red,
                trend: "-3%",
                trendUp: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required String trend,
    required bool trendUp,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius. circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color. withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:  Icon(icon, color: color, size: 24),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: trendUp
                      ? Colors.green. withOpacity(0.1)
                      : Colors.red. withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(
                      trendUp ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 10,
                      color: trendUp ? Colors.green : Colors. red,
                    ),
                    2.widthBox,
                    Text(
                      trend,
                      style: TextStyle(
                        fontSize: 10,
                        color: trendUp ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.heightBox,
          AppStyles.bold(
            title: title,
            color: AppColors.textColor,
            size: 24,
          ),
          4.heightBox,
          AppStyles.normal(
            title: subtitle,
            color: AppColors.textColor. withOpacity(0.6),
            size: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyOverviewChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles. bold(
                    title: "Weekly Overview",
                    color: AppColors.textColor,
                    size: 16,
                  ),
                  4.heightBox,
                  AppStyles.normal(
                    title: "Last 7 days performance",
                    color: AppColors.textColor.withOpacity(0.6),
                    size: 12,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const StatsDashboardView(),
                    ),
                  );
                },
                child: Text("View Details"),
              ),
            ],
          ),
          20.heightBox,
          SizedBox(
            height: 150,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 30,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.black87,
                    tooltipPadding: const EdgeInsets. all(8),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${weekDays[group.x.toInt()]}\n${rod.toY.toInt()} appointments',
                        const TextStyle(
                          color:  Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                barGroups: List.generate(weeklyAppointments.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods:  [
                      BarChartRodData(
                        toY: weeklyAppointments[index],
                        gradient: LinearGradient(
                          colors: [
                            AppColors.blueColor. withOpacity(0.7),
                            AppColors.blueColor,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        width: 16,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles:  SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles:  SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles:  true,
                      reservedSize: 28,
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
                        if (idx < 0 || idx >= weekDays.length) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            weekDays[idx],
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
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onViewAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppStyles.bold(
          title: title,
          color: AppColors.textColor,
          size: 18,
        ),
        TextButton(
          onPressed: onViewAll,
          child: Row(
            children: [
              Text(
                "View All",
                style: TextStyle(
                  color: AppColors.blueColor,
                  fontSize: 14,
                ),
              ),
              4.widthBox,
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppColors.blueColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingAppointments() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3, // Show only first 3
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets. only(bottom: 12),
          padding: const EdgeInsets. all(16),
          decoration:  BoxDecoration(
            color:  Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow:  [
              BoxShadow(
                color: Colors.black. withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.blueColor, width: 2),
                ),
                child: CircleAvatar(
                  radius: 25,
                  child: Image.asset(AppAssets.imgSignup),
                ),
              ),
              12.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStyles.bold(
                      title: "Patient ${index + 1}",
                      size: 15,
                      color: AppColors.textColor,
                    ),
                    6.heightBox,
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size:  14,
                          color: AppColors.textColor.withOpacity(0.6),
                        ),
                        4.widthBox,
                        AppStyles.normal(
                          title: "10:${(index + 1) * 10} AM",
                          color: AppColors.textColor.withOpacity(0.6),
                          size: 13,
                        ),
                        12.widthBox,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Confirmed",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.blueColor. withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size:  16,
                  color: AppColors.blueColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecentActivities() {
    final activities = [
      {
        "icon": Icons.person_add,
        "title": "New patient registered",
        "subtitle": "John Doe - 2 hours ago",
        "color": Colors.blue,
      },
      {
        "icon": Icons. event_available,
        "title": "Appointment completed",
        "subtitle": "Jane Smith - 3 hours ago",
        "color": Colors.green,
      },
      {
        "icon":  Icons.cancel,
        "title": "Appointment cancelled",
        "subtitle": "Mike Johnson - 5 hours ago",
        "color": Colors.red,
      },
    ];

    return ListView. builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities. length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets. all(10),
                decoration: BoxDecoration(
                  color: (activity["color"] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius. circular(10),
                ),
                child:  Icon(
                  activity["icon"] as IconData,
                  color: activity["color"] as Color,
                  size: 24,
                ),
              ),
              12.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStyles. bold(
                      title: activity["title"] as String,
                      size: 14,
                      color: AppColors.textColor,
                    ),
                    4.heightBox,
                    AppStyles.normal(
                      title: activity["subtitle"] as String,
                      color: AppColors. textColor.withOpacity(0.6),
                      size: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}