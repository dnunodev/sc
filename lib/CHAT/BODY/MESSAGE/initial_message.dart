// initial_message.dart
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/chat_message_class.dart';
import 'dart:typed_data';

final List<Map<String, dynamic>> _messages = [
  {
    'text': 'Welcome to GenAI PoC Agent! How can I assist you today?',
    'sender': 'bot',
    'documents': [],
    'workflow': ""
  }
];

final List<ChatMessageClass> initialChatMessages = _messages.map((message) {
  // Aquí no tenemos imágenes, solo devolvemos una lista vacía de Uint8List
  return ChatMessageClass(
    text: message['text'] as String,
    sender: message['sender'] as String,
    workflow: message['workflow'] as String? ?? "",
    images: <Uint8List>[], // sin imágenes
  );
}).toList();
