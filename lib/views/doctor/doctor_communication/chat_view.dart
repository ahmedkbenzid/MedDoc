import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/models/message.dart';
import 'package:flutter_application_1/services/chat_service.dart';

class ChatView extends StatefulWidget {
  final String patientId;
  final String patientName;

  const ChatView({
    super.key,
    required this.patientId,
    required this.patientName,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatService _chatService = ChatService();
  final TextEditingController _controller = TextEditingController();
  late Future<List<Message>> _messagesFuture;

  // UUID du docteur
  final String doctorId = '11111111-1111-1111-1111-111111111111';

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    _messagesFuture = _chatService.getMessages(widget.patientId);
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    await _chatService.sendMessage(
      patientId: widget.patientId,
      patientName: widget.patientName,
      content: text,
    );

    _controller.clear();
    setState(() {
      _loadMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patientName),
        backgroundColor: AppColors.blueColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Message>>(
              future: _messagesFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final messages = snapshot.data!;
                if (messages.isEmpty) return const Center(child: Text("Aucun message"));

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isDoctor = msg.doctorId == doctorId;

                    return Align(
                      alignment: isDoctor ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDoctor ? AppColors.blueColor : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          msg.content,
                          style: TextStyle(color: isDoctor ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Écrire un message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: AppColors.blueColor,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
