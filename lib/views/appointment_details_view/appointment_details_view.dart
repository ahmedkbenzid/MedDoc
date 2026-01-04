import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:flutter_application_1/controllers/appointment_controller.dart';
import 'package:get/get.dart';
import 'dart:math';

class AppointmentDetailsView extends StatefulWidget {
  final String docName;
  final String docSpeciality;
  final String docImage;
  final String selectedDate;
  final int selectedDay;
  final String selectedTime;

  const AppointmentDetailsView({
    super.key,
    required this.docName,
    required this.docSpeciality,
    this.docImage = '',
    required this.selectedDate,
    required this.selectedDay,
    required this.selectedTime,
  });

  @override
  State<AppointmentDetailsView> createState() => _AppointmentDetailsViewState();
}

class _AppointmentDetailsViewState extends State<AppointmentDetailsView> {
  final TextEditingController _reasonController = TextEditingController();
  String _selectedPaymentMethod = 'VISA';
  late final double _consultationFee;
  late final double _adminFee;
  late final double _discount;

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'VISA', 'icon': Icons.credit_card, 'color': Colors.blue},
    {'name': 'MasterCard', 'icon': Icons.credit_card, 'color': Colors.orange},
    {'name': 'PayPal', 'icon': Icons.payment, 'color': Colors.indigo},
    {'name': 'Cash', 'icon': Icons.money, 'color': Colors.green},
  ];

  double get _total => _consultationFee + _adminFee - _discount;

  @override
  void initState() {
    super.initState();
    // Générer des montants aléatoires basés sur le nom du docteur et la spécialité
    final random = Random(widget.docName.hashCode + widget.docSpeciality.hashCode);
    
    // Frais de consultation entre 40$ et 150$
    final baseFee = 40 + (random.nextDouble() * 110);
    _consultationFee = (baseFee / 5).round() * 5.0; // Arrondir à 5$ près
    
    // Frais administratifs entre 1$ et 5$
    _adminFee = 1.0 + random.nextInt(5);
    
    // Réduction aléatoire (30% de chance d'avoir une réduction)
    if (random.nextDouble() < 0.3) {
      final discountPercent = 5 + random.nextInt(16); // 5% à 20%
      _discount = ((_consultationFee * discountPercent / 100) / 5).round() * 5.0;
    } else {
      _discount = 0.0;
    }
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _showPaymentMethodDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Select Payment Method",
          style: TextStyle(
            fontSize: AppSizes.size16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _paymentMethods.map((method) {
            return RadioListTile<String>(
              value: method['name'],
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
                Navigator.pop(context);
              },
              title: Row(
                children: [
                  Icon(method['icon'], color: method['color'], size: 24),
                  SizedBox(width: 12),
                  Text(
                    method['name'],
                    style: TextStyle(fontSize: AppSizes.size14),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showReasonDialog() {
    final tempController = TextEditingController(text: _reasonController.text);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Reason for Visit",
          style: TextStyle(
            fontSize: AppSizes.size16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: tempController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Describe your symptoms or reason for visit...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.blueColor),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: AppColors.textColor.withOpacity(0.6),
                fontSize: AppSizes.size14,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _reasonController.text = tempController.text;
              });
              Navigator.pop(context);
            },
            child: Text(
              "Save",
              style: TextStyle(
                color: AppColors.blueColor,
                fontSize: AppSizes.size14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
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
          title: "Appointment",
          size: AppSizes.size18,
          color: AppColors.textColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Info
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
                        AppStyles.bold(title: widget.docName, size: AppSizes.size18),
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
                            AppStyles.bold(title: "4.7", size: AppSizes.size14),
                            16.widthBox,
                            Icon(Icons.location_on, 
                              color: AppColors.textColor.withOpacity(0.6), 
                              size: 18,
                            ),
                            4.widthBox,
                            AppStyles.normal(
                              title: "800m away",
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

              // Date Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppStyles.bold(title: "Date", size: AppSizes.size16),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: AppStyles.normal(
                      title: "Change",
                      color: AppColors.blueColor,
                      size: AppSizes.size14,
                    ),
                  ),
                ],
              ),
              12.heightBox,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.blueColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, 
                      color: AppColors.blueColor, 
                      size: 20,
                    ),
                    12.widthBox,
                    Expanded(
                      child: AppStyles.normal(
                        title: widget.selectedDate,
                        size: AppSizes.size14,
                      ),
                    ),
                  ],
                ),
              ),
              24.heightBox,

              // Reason Section (Editable)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppStyles.bold(title: "Reason", size: AppSizes.size16),
                  GestureDetector(
                    onTap: _showReasonDialog,
                    child: AppStyles.normal(
                      title: _reasonController.text.isEmpty ? "Add" : "Edit",
                      color: AppColors.blueColor,
                      size: AppSizes.size14,
                    ),
                  ),
                ],
              ),
              12.heightBox,
              GestureDetector(
                onTap: _showReasonDialog,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.blueColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _reasonController.text.isEmpty 
                        ? AppColors.textColor.withOpacity(0.2)
                        : AppColors.blueColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _reasonController.text.isEmpty ? Icons.edit : Icons.check_circle, 
                        color: _reasonController.text.isEmpty 
                          ? AppColors.textColor.withOpacity(0.4)
                          : AppColors.blueColor, 
                        size: 20,
                      ),
                      12.widthBox,
                      Expanded(
                        child: AppStyles.normal(
                          title: _reasonController.text.isEmpty 
                            ? "Tap to add reason for visit..."
                            : _reasonController.text,
                          color: _reasonController.text.isEmpty
                            ? AppColors.textColor.withOpacity(0.4)
                            : AppColors.textColor,
                          size: AppSizes.size14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              24.heightBox,

              // Payment Detail
              AppStyles.bold(title: "Payment Detail", size: AppSizes.size16),
              16.heightBox,
              _buildPaymentRow("Consultation", "\$${_consultationFee.toStringAsFixed(2)}"),
              12.heightBox,
              _buildPaymentRow("Admin Fee", "\$${_adminFee.toStringAsFixed(2)}"),
              12.heightBox,
              _buildPaymentRow(
                "Discount", 
                _discount > 0 ? "-\$${_discount.toStringAsFixed(2)}" : "-",
                isDiscount: true
              ),
              16.heightBox,
              Divider(color: AppColors.textColor.withOpacity(0.2)),
              12.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppStyles.bold(title: "Total", size: AppSizes.size16),
                  AppStyles.bold(
                    title: "\$${_total.toStringAsFixed(2)}",
                    size: AppSizes.size16,
                    color: AppColors.blueColor,
                  ),
                ],
              ),
              24.heightBox,

              // Payment Method (Selectable)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppStyles.bold(title: "Payment Method", size: AppSizes.size16),
                  GestureDetector(
                    onTap: _showPaymentMethodDialog,
                    child: AppStyles.normal(
                      title: "Change",
                      color: AppColors.blueColor,
                      size: AppSizes.size14,
                    ),
                  ),
                ],
              ),
              16.heightBox,
              GestureDetector(
                onTap: _showPaymentMethodDialog,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.blueColor.withOpacity(0.05),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _paymentMethods.firstWhere(
                            (m) => m['name'] == _selectedPaymentMethod
                          )['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          _paymentMethods.firstWhere(
                            (m) => m['name'] == _selectedPaymentMethod
                          )['icon'],
                          color: _paymentMethods.firstWhere(
                            (m) => m['name'] == _selectedPaymentMethod
                          )['color'],
                          size: 24,
                        ),
                      ),
                      12.widthBox,
                      Expanded(
                        child: AppStyles.bold(
                          title: _selectedPaymentMethod,
                          size: AppSizes.size14,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.textColor.withOpacity(0.4),
                      ),
                    ],
                  ),
                ),
              ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppStyles.normal(
                  title: "Total",
                  color: AppColors.textColor.withOpacity(0.6),
                  size: AppSizes.size12,
                ),
                AppStyles.bold(
                  title: "\$${_total.toStringAsFixed(2)}",
                  size: AppSizes.size20,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CustomButton(
                  buttonText: "Booking",
                  onTap: () {
                    if (_reasonController.text.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please provide a reason for your visit',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }
                    
                    // Obtenir ou créer le contrôleur
                    final AppointmentController controller = Get.isRegistered<AppointmentController>()
                        ? Get.find<AppointmentController>()
                        : Get.put(AppointmentController());
                    controller.addAppointment(
                      docName: widget.docName,
                      docSpeciality: widget.docSpeciality,
                      date: widget.selectedDate,
                      reason: _reasonController.text,
                      paymentMethod: _selectedPaymentMethod,
                      totalAmount: _total,
                    );
                    
                    Get.snackbar(
                      'Success',
                      'Appointment booked successfully with $_selectedPaymentMethod!',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    
                    Future.delayed(Duration(seconds: 1), () {
                      Get.back();
                      Get.back();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRow(String label, String amount, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppStyles.normal(
          title: label,
          color: AppColors.textColor.withOpacity(0.6),
          size: AppSizes.size14,
        ),
        AppStyles.normal(
          title: amount,
          size: AppSizes.size14,
          color: isDiscount && amount != "-" ? Colors.green : AppColors.textColor,
        ),
      ],
    );
  }
}