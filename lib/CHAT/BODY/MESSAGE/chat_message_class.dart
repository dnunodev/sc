import 'dart:typed_data';

class ChatMessageClass {
  String text;
  final String sender;
  final String workflow;
  List<Uint8List>? images; // Cambiamos a Uint8List para mayor claridad
  final String? prompt; // <-- Added this line to include the prompt

  ChatMessageClass({
    required this.text,
    required this.sender,
    this.workflow = '',
    this.images,
    this.prompt,

  });
}
