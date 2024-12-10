import 'package:flutter/material.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/chat_controller.dart';
import 'package:scientific_copilot_genai/CHAT/USER_PROMPT/ATTACH/image_attachment_manager.dart';

class SendIcon extends StatelessWidget {
  final ChatController chatController;
  final VoidCallback onBotResponded;
  final ImageAttachmentManager imageManager; // Add this to get the current images

  const SendIcon({
    super.key,
    required this.chatController,
    required this.onBotResponded,
    required this.imageManager,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!chatController.inResponse) {
          String message = chatController.textController.text.trim();
          if (message.isNotEmpty) {
            // Convert Uint8List images to List<int> before sending
            List<List<int>> imageFiles = imageManager.images.map((img) => img.toList()).toList();

            chatController.sendMessage(
              context, 
              message, 
              imageFiles,
              onBotResponded: onBotResponded,
            );
            chatController.textController.clear();
            chatController.scrollToEnd();
          }
        }
      },
      icon: Icon(
        chatController.inResponse ? Icons.pause : Icons.send_rounded,
        color: Colors.black,
        size: 20,
      ),
    );
  }
}
