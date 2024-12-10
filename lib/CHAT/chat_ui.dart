import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/chat_controller.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/chat_body.dart';
import 'package:scientific_copilot_genai/CHAT/USER_PROMPT/user_prompt.dart';
import 'package:scientific_copilot_genai/CHAT/WORKFLOW/DROP_DOWN/drop_down.dart';
import 'package:scientific_copilot_genai/CHAT/USER_PROMPT/ATTACH/image_attachment_manager.dart';

class ChatUi extends StatefulWidget {
  const ChatUi({super.key});

  @override
  State<ChatUi> createState() => _ChatUiState();
}

class _ChatUiState extends State<ChatUi> {
  final ImageAttachmentManager imageManager = ImageAttachmentManager();

  Future<void> _pickImages() async {
    await imageManager.pickImages();
    setState(() {});
  }

  void _sendMessage(BuildContext context) async {
    final chatController = context.read<ChatController>();
    
    String message = chatController.textController.text.trim();
    if (message.isNotEmpty) {
      // Convert Uint8List to List<int>
      List<List<int>> imageFiles = imageManager.images.map((img) => img.toList()).toList();

      await chatController.sendMessage(
        context, 
        message, 
        imageFiles,
        onBotResponded: () {
          // Once the bot responds, clear all images and update UI
          imageManager.clearAllImages();
          setState(() {});
        },
      );
      
      // Clear the text input field after sending
      chatController.textController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const DropDown(),
            const ChatBody(),
            UserPrompt(
              onAttachPressed: _pickImages,
              attachmentManager: imageManager,
              onBotResponded: () {
                // If you need additional actions here after the bot responds
                // you can handle them as well, but it's also handled in _sendMessage.
              },
            ),
            // If you need a separate send button (instead of an Enter key press),
            // you can uncomment and use:
            // ElevatedButton(
            //   onPressed: () => _sendMessage(context),
            //   child: const Text("Send"),
            // ),
          ],
        ),
      ),
    );
  }
}
