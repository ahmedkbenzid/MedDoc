class ChatMessage {
  final String text;
  final bool isDoctor;

  ChatMessage({
    required this.text,
    required this.isDoctor,
  });
}

class ChatService {
  // Stockage temporaire en mémoire (PAS base de données)
  static final Map<String, List<ChatMessage>> _messages = {};

  // Récupérer les messages d’un patient
  static List<ChatMessage> getMessages(String patientName) {
    return _messages[patientName] ?? [];
  }

  // Envoyer un message
  static void sendMessage(String patientName, ChatMessage message) {
    _messages.putIfAbsent(patientName, () => []);
    _messages[patientName]!.add(message);
  }

  // Initialiser une conversation (message patient fictif)
  static void initConversation(String patientName) {
    if (!_messages.containsKey(patientName)) {
      _messages[patientName] = [
        ChatMessage(
          text: "Bonjour docteur, j’ai une question.",
          isDoctor: false,
        ),
      ];
    }
  }
}
