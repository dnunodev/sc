import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:scientific_copilot_genai/CHAT/USER_PROMPT/ATTACH/image_attachment_manager.dart';
import 'package:scientific_copilot_genai/CHAT/USER_PROMPT/ATTACH/user_prompt_attach.dart';
import 'package:scientific_copilot_genai/CHAT/USER_PROMPT/TEXTFIELD/user_prompt_textfield.dart';
import 'package:scientific_copilot_genai/GENERAL_CLASSES/color_class.dart';
import 'package:provider/provider.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/chat_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPrompt extends StatefulWidget {
  final VoidCallback onAttachPressed;
  final ImageAttachmentManager attachmentManager;
  final VoidCallback onBotResponded; // New parameter to handle bot response

  const UserPrompt({
    super.key,
    required this.onAttachPressed,
    required this.attachmentManager,
    required this.onBotResponded, // Callback for bot response
  });

  @override
  State<UserPrompt> createState() => _UserPromptState();
}

class _UserPromptState extends State<UserPrompt> {
  final colorClass = ColorClass();

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = context.watch<ChatController>();
    final images = widget.attachmentManager.images; // Get the current images from attachment manager

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display images if available
              if (images.isNotEmpty)
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    padding: const EdgeInsets.only(left: 20),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.memory(
                                images[index],
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: InkWell(
                              onTap: () {
                                // Remove the image from attachment manager and update state
                                widget.attachmentManager.clearImageAtIndex(index);
                                setState(() {}); // Update the UI to reflect changes
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: colorClass.blue, width: 2),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // Pass the controller, and the callback to clear images on bot response
                    UserPromptTextfield(
                      controller_input: chatController.textController,
                      onBotResponded: () {
                        // Clear images after bot response
                        widget.attachmentManager.clearAllImages();
                        setState(() {}); // Update the UI to reflect the changes
                      },
                      imageManager: widget.attachmentManager, // Pass the image manager
                    ),
                    UserPromptAttach(onAttachPressed: widget.onAttachPressed),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
