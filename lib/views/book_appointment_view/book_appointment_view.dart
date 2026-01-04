import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:flutter_application_1/views/appointment_details_view/appointment_details_view.dart';
import 'package:get/get.dart';
import 'dart:math';

class BookAppointmentView extends StatefulWidget {
  final String docName;
  final String docSpeciality;
  final String docImage;
  final String docRating;

  const BookAppointmentView({
    super.key,
    required this.docName,
    required this.docSpeciality,
    this.docImage = '',
    required this.docRating,
  });

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  int selectedDay = 23;
  String selectedTime = '02:00 PM';
  late final String _distance;
  
  final List<Map<String, dynamic>> days = [
    {'day': 'Mon', 'date': 21, 'fullDay': 'Monday'},
    {'day': 'Tue', 'date': 22, 'fullDay': 'Tuesday'},
    {'day': 'Wed', 'date': 23, 'fullDay': 'Wednesday'},
    {'day': 'Thu', 'date': 24, 'fullDay': 'Thursday'},
    {'day': 'Fri', 'date': 25, 'fullDay': 'Friday'},
    {'day': 'Sat', 'date': 26, 'fullDay': 'Saturday'},
  ];
  
  String getSelectedDayName() {
    final selectedDayData = days.firstWhere(
      (day) => day['date'] == selectedDay,
      orElse: () => {'day': 'Wed', 'date': 23, 'fullDay': 'Wednesday'},
    );
    return selectedDayData['fullDay'] as String;
  }

  final List<String> timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '07:00 PM',
    '08:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    // Générer une distance aléatoire basée sur le nom du docteur
    final random = Random(widget.docName.hashCode);
    final distanceInMeters = 100 + random.nextInt(4900);
    if (distanceInMeters >= 1000) {
      _distance = '${(distanceInMeters / 1000).toStringAsFixed(1)} km away';
    } else {
      _distance = '$distanceInMeters m away';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => Get.back(),
        ),
        title: AppStyles.bold(
          title: "Doctor Detail",
          size: AppSizes.size18,
          color: AppColors.textColor,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Info Card
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.blueColor.withOpacity(0.1),
                    backgroundImage: widget.docImage.isNotEmpty 
                        ? AssetImage(widget.docImage) as ImageProvider
                        : null,
                    child: widget.docImage.isEmpty
                        ? Icon(Icons.person, size: 40, color: AppColors.blueColor)
                        : null,
                  ),
                  16.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppStyles.bold(
                          title: widget.docName,
                          size: AppSizes.size18,
                        ),
                        4.heightBox,
                        AppStyles.normal(
                          title: widget.docSpeciality,
                          color: AppColors.textColor.withOpacity(0.6),
                          size: AppSizes.size14,
                        ),
                        8.heightBox,
                        Row(
                          children: [
                            Icon(Icons.star, color: AppColors.blueColor, size: 18),
                            4.widthBox,
                            AppStyles.bold(title: widget.docRating, size: AppSizes.size14),
                            16.widthBox,
                            Icon(Icons.location_on, 
                              color: AppColors.textColor.withOpacity(0.6), 
                              size: 18,
                            ),
                            4.widthBox,
                            AppStyles.normal(
                              title: _distance,
                              color: AppColors.textColor.withOpacity(0.6),
                              size: AppSizes.size12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              24.heightBox,
              
              // About Section
              AppStyles.bold(title: "About", size: AppSizes.size16),
              8.heightBox,
              AppStyles.normal(
                title: "Dr. ${widget.docName} is a highly skilled ${widget.docSpeciality} with over 10 years of experience in providing exceptional medical care to patients. Known for compassionate approach and dedication to patient well-being.",
                color: AppColors.textColor.withOpacity(0.6),
                size: AppSizes.size14,
              ),
              GestureDetector(
                onTap: () {},
                child: AppStyles.bold(
                  title: "Read more",
                  color: AppColors.blueColor,
                  size: AppSizes.size14,
                ),
              ),
              24.heightBox,
              
              // Date Selection
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blueColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: days.map((day) {
                      final isSelected = selectedDay == day['date'];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDay = day['date'];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.blueColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                AppStyles.normal(
                                  title: day['day'],
                                  color: isSelected 
                                    ? AppColors.whiteColor 
                                    : AppColors.textColor.withOpacity(0.6),
                                  size: AppSizes.size12,
                                ),
                                4.heightBox,
                                AppStyles.bold(
                                  title: day['date'].toString(),
                                  color: isSelected 
                                    ? AppColors.whiteColor 
                                    : AppColors.textColor,
                                  size: AppSizes.size18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              24.heightBox,
              
              // Time Selection
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: timeSlots.map((time) {
                  final isSelected = selectedTime == time;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.blueColor : Colors.transparent,
                        border: Border.all(
                          color: isSelected 
                            ? AppColors.blueColor 
                            : AppColors.textColor.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: AppStyles.normal(
                        title: time,
                        color: isSelected 
                          ? AppColors.whiteColor 
                          : AppColors.textColor,
                        size: AppSizes.size14,
                      ),
                    ),
                  );
                }).toList(),
              ),
              24.heightBox,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blueColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                color: AppColors.blueColor,
              ),
            ),
            16.widthBox,
            Expanded(
              child: CustomButton(
                buttonText: "Book Appointment",
                onTap: () {
                  Get.to(() => AppointmentDetailsView(
                    docName: widget.docName,
                    docSpeciality: widget.docSpeciality,
                    docImage: widget.docImage,
                    selectedDate: '${getSelectedDayName()}, Jun $selectedDay, 2021 | $selectedTime',
                    selectedDay: selectedDay,
                    selectedTime: selectedTime,
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}