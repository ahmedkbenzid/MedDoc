import 'package:flutter_application_1/consts/consts.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: AppStrings.termConditions,
          size: AppSizes.size18,
          color: AppColors.whiteColor,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets. all(16),
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            20.heightBox,
            AppStyles.bold(
              title: "Terms and Conditions",
              size: AppSizes.size22,
              color: AppColors. blueColor,
            ),
            10.heightBox,
            AppStyles.normal(
              title: "Last updated: January 4, 2026",
              color: AppColors. textColor.withOpacity(0.6),
              size: AppSizes.size12,
            ),
            20.heightBox,
            _buildSection(
              title: "1. Acceptance of Terms",
              content: 
                  "By accessing and using MedDoc, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to these terms, please do not use this application.",
            ),
            _buildSection(
              title: "2. Medical Disclaimer",
              content: 
                  "MedDoc is designed to facilitate communication between healthcare providers and patients. It is not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.",
            ),
            _buildSection(
              title: "3. User Responsibilities",
              content:
                  "Users are responsible for maintaining the confidentiality of their account credentials.  You agree to provide accurate and complete information when creating your account and to update this information as necessary.",
            ),
            _buildSection(
              title: "4. Privacy and Data Protection",
              content: 
                  "We take your privacy seriously. All personal health information is encrypted and stored securely. We comply with applicable data protection laws and regulations.  Your data will not be shared with third parties without your explicit consent, except as required by law.",
            ),
            _buildSection(
              title: "5. Appointment Management",
              content:
                  "While we strive to provide accurate appointment scheduling, it is the responsibility of both patients and doctors to confirm appointments. MedDoc is not liable for missed appointments or scheduling conflicts.",
            ),
            _buildSection(
              title: "6. Limitation of Liability",
              content:
                  "MedDoc shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use or inability to use the application.",
            ),
            _buildSection(
              title: "7. Changes to Terms",
              content: 
                  "We reserve the right to modify these terms at any time. Users will be notified of any significant changes.  Continued use of the application after such modifications constitutes acceptance of the updated terms.",
            ),
            _buildSection(
              title: "8. Contact Information",
              content:
                  "For questions about these Terms and Conditions, please contact us at support@meddoc.com",
            ),
            30.heightBox,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.blueColor. withOpacity(0.1),
                borderRadius: BorderRadius. circular(12),
                border: Border.all(color: AppColors.blueColor. withOpacity(0.3)),
              ),
              child:  AppStyles.normal(
                title: 
                    "By using MedDoc, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.",
                color: AppColors.textColor,
                size: AppSizes.size14,
              ),
            ),
            20.heightBox,
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppStyles.bold(
            title: title,
            size: AppSizes.size16,
            color: AppColors.textColor,
          ),
          8.heightBox,
          AppStyles.normal(
            title: content,
            color: AppColors.textColor.withOpacity(0.8),
            size: AppSizes.size14,
          ),
        ],
      ),
    );
  }
}