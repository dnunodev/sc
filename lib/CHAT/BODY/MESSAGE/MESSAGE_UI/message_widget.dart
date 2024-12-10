import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/MESSAGE_UI/message_buble.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/chat_message_class.dart';

class MessageWidget extends StatelessWidget {
  final ChatMessageClass message;
  final bool isLastMessage;
  final VoidCallback onActionPressed;

  const MessageWidget({
    super.key,
    required this.message,
    required this.isLastMessage,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUserMessage = message.sender == 'user';

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUserMessage) ...[
              _profile(user: false),
              const SizedBox(width: 10),
            ],
            MessageBubble(
              message: message,
              isUserMessage: isUserMessage,
              onActionPressed: onActionPressed,
            ),
            if (isUserMessage) ...[
              const SizedBox(width: 10),
              _profile(user: true),
            ],
          ],
        ),
      ),
    );
  }

  Widget _profile({required bool user}) {
    // Replicando el perfil del código original:
    // Para el bot: ícono de rayo en fondo background (0xfff9fafc)
    // Para el usuario: ícono de cuenta en fondo gris claro
    Color background = const Color(0xfff9fafc);

    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: user ? Colors.grey.shade100 : background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(
          user ? Icons.account_circle_sharp : Icons.offline_bolt,
          size: 25,
          color: Colors.black,
        ),
      ),
    );
  }
}
