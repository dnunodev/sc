import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/MESSAGE_UI/message_header.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/chat_message_class.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessageClass message;
  final bool isUserMessage;
  final VoidCallback onActionPressed;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isUserMessage,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];

    // Mostrar el encabezado solo para mensajes del bot con workflow definido
    if (!isUserMessage && message.workflow.isNotEmpty) {
      content.add(
        MessageHeader(
          workflowName: message.workflow.isEmpty ? "General" : message.workflow,
          response: message.text, 
          question: message.prompt ?? "No question provided", // Handle null prompts gracefully
        ),

      );
    }

    // Añadir el texto del mensaje
    if (isUserMessage) {
      // Mensaje del usuario: SelectableText estilo Outfit
      content.add(
        SelectableText(
          message.text,
          style: GoogleFonts.getFont(
            "Outfit",
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    } else {
      // Mensaje del bot: MarkdownBody con los mismos estilos del código original
      content.add(
        MarkdownBody(
          data: message.text,
          selectable: true,
          styleSheet: MarkdownStyleSheet(
            p: GoogleFonts.getFont(
              "Outfit",
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            h1: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            h2: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            h3: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            h4: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            h5: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            h6: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            blockquote: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            code: TextStyle(
              backgroundColor: Colors.grey.shade200,
              fontFamily: 'monospace',
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    // Si es mensaje del usuario y tiene imágenes, mostrarlas debajo
    if (isUserMessage && message.images != null && message.images!.isNotEmpty) {
      content.add(
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: message.images!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(
                    message.images![index],
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    // Colores y estilo del contenedor del mensaje tal como el original
    final backgroundColor = isUserMessage ? Colors.grey.shade100 : Colors.white;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content,
        ),
      ),
    );
  }
}
