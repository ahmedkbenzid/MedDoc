import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'chat_view.dart';
import 'package:flutter_application_1/services/chat_service.dart';


class MessageListView extends StatelessWidget {
  const MessageListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock messages list
    final messages = List.generate(
      5,
      (index) => {
        'patient': 'Patient ${index + 1}',
        'lastMessage': 'Hello doctor, I have a question...',
        'time': '10:${index + 1}0 AM',
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(
            title: "Messages",
            color: AppColors.whiteColor,
            size: 18),
        backgroundColor: AppColors.blueColor,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: AppStyles.bold(title: msg['patient']!),
              subtitle: AppStyles.normal(title: msg['lastMessage']!),
              trailing: Text(msg['time']!),
              onTap: () {
                final patientName = msg['patient']!;
                ChatService.initConversation(patientName);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChatView(patientName: patientName),


                  ),
                );
                
              },
            ),
          );
        },
      ),
    );
  }
}
