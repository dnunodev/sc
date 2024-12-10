import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scientific_copilot_genai/CHAT/USER_PROMPT/TEXTFIELD/send_icon.dart';
import 'package:scientific_copilot_genai/GENERAL_CLASSES/color_class.dart';
import 'package:provider/provider.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/chat_controller.dart';
import 'package:scientific_copilot_genai/CHAT/USER_PROMPT/ATTACH/image_attachment_manager.dart';

class UserPromptTextfield extends StatelessWidget {
  final TextEditingController controller_input;
  final VoidCallback onBotResponded; // Callback to run once bot responds
  final ImageAttachmentManager imageManager; // Add the image manager to access images

  UserPromptTextfield({
    super.key,
    required this.controller_input,
    required this.onBotResponded,
    required this.imageManager,
  });

  final colorClass = ColorClass();

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = context.watch<ChatController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller_input,
              style: GoogleFonts.getFont("Outfit", fontSize: 16, color: colorClass.black),
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Message GenAI",
                hintStyle: GoogleFonts.getFont("Outfit", fontSize: 16, color: colorClass.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          // Pass the onBotResponded callback and imageManager to SendIcon
          SendIcon(
            chatController: chatController,
            onBotResponded: onBotResponded,
            imageManager: imageManager,
          ),
        ],
      ),
    );
  }
}
