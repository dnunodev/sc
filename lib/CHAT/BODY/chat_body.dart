import 'package:flutter/material.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/MESSAGE_UI/message_widget.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/chat_controller.dart';
import 'package:provider/provider.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = context.watch<ChatController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chatController.scrollController.hasClients) {
        chatController.scrollToEnd();
      }
    });

    return Expanded(
      child: ListView.builder(
        controller: chatController.scrollController,
        itemCount: chatController.messages.length,
        itemBuilder: (context, index) {
          final message = chatController.messages[index];
          return MessageWidget(
            message: message,
            isLastMessage: index == chatController.messages.length - 1,
            onActionPressed: () {
              // Aquí se puede implementar la lógica para abrir el modal de scoring
            },
          );
        },
      ),
    );
  }
}
