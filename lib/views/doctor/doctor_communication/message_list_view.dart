import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'chat_view.dart';
import 'package:flutter_application_1/services/chat_service.dart';

class MessageListView extends StatefulWidget {
  const MessageListView({super.key});

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  late final ChatService _chatService;
  late Future<List<Map<String, dynamic>>> _messagesFuture;

  @override
  void initState() {
    super.initState();
    _chatService = ChatService();
    _loadMessages();
  }

  void _loadMessages() {
    _messagesFuture = _chatService.getPatientsLastMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(
          title: "Messages",
          color: AppColors.whiteColor,
          size: 18,
        ),
        backgroundColor: AppColors.blueColor,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _messagesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final messages = snapshot.data!;
          if (messages.isEmpty) {
            return const Center(child: Text("Aucun message pour le moment"));
          }

          // Afficher chaque patient avec son dernier message
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];
              final createdAt = msg['created_at'] != null
                  ? DateTime.parse(msg['created_at'])
                  : null;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: AppStyles.bold(title: msg['patient_name'] ?? "Patient"),
                  subtitle: AppStyles.normal(title: msg['content'] ?? ""),
                  trailing: createdAt != null
                      ? Text(
                          '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}')
                      : null,
                  onTap: () {
                    // Ouvre le chat avec ce patient
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatView(
                          patientId: msg['patient_id'],
                          patientName: msg['patient_name'] ?? "Patient",
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
