import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class TestResultsView extends StatelessWidget {
  final String testType;

  const TestResultsView({super.key, required this.testType});

  @override
  Widget build(BuildContext context) {
    final testResults = List.generate(
      5,
      (index) => {
        'date': '2026-01-${(index + 1).toString().padLeft(2, '0')}',
        'testName': '$testType - Test ${index + 1}',
        'status': index % 2 == 0 ? 'Normal' : 'Pending Review',
        'doctor': ['Ahmed', 'Sarah', 'John', 'Emily', 'Michael'][index],
      },
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: "$testType Results",
          size: AppSizes.size18,
          color: AppColors.whiteColor,
        ),
      ),
      body: testResults.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 80,
                    color: AppColors.textColor.withOpacity(0.3),
                  ),
                  20.heightBox,
                  AppStyles.normal(
                    title: "No test results available",
                    color: AppColors.textColor.withOpacity(0.6),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: testResults.length,
              itemBuilder: (context, index) {
                final result = testResults[index];
                final isNormal = result['status'] == 'Normal';

                return GestureDetector(
                  onTap: () => _showTestDetailDialog(context, result),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.bgDarkColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isNormal
                            ? Colors.green.withOpacity(0.3)
                            : Colors.orange.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isNormal
                                ? Colors.green.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isNormal
                                ? Icons.check_circle
                                : Icons.pending,
                            color:
                                isNormal ? Colors.green : Colors.orange,
                            size: 30,
                          ),
                        ),
                        16.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppStyles.bold(
                                title: result['testName'] ?? '',
                                size: AppSizes.size14,
                                color: AppColors.textColor,
                              ),
                              6.heightBox,
                              AppStyles.normal(
                                title: "Date: ${result['date']}",
                                size: AppSizes.size12,
                                color: AppColors.textColor.withOpacity(0.6),
                              ),
                              4.heightBox,
                              AppStyles.normal(
                                title: "Doctor: ${result['doctor']}",
                                size: AppSizes.size12,
                                color: AppColors.textColor.withOpacity(0.6),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: isNormal
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: AppStyles.normal(
                                title: result['status'] ?? '',
                                size: AppSizes.size12,
                                color: isNormal
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                            8.heightBox,
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: AppColors.blueColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showTestDetailDialog(
    BuildContext context, Map<String, String> result) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 420,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppStyles.bold(
                    title: result['testName'] ?? '',
                    size: AppSizes.size16,
                  ),
                  const SizedBox(height: 16),

                  _buildDetailRow("Date", result['date'] ?? ''),
                  _buildDetailRow("Status", result['status'] ?? ''),
                  _buildDetailRow("Doctor", result['doctor'] ?? ''),

                  const SizedBox(height: 20),

                  AppStyles.normal(
                    title:
                        "Detailed results and interpretations will be available here.",
                    size: AppSizes.size12,
                    color: AppColors.textColor.withOpacity(0.7),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Downloading test result..."),
                            ),
                          );
                        },
                        child: const Text("Download PDF"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}


  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          AppStyles.bold(title: "$label: ", size: AppSizes.size14),
          Expanded(
            child: AppStyles.normal(title: value, size: AppSizes.size14),
          ),
        ],
      ),
    );
  }
}
