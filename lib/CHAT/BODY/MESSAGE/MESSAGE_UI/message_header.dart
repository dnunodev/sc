import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/MESSAGE_UI/score_modal.dart';

class MessageHeader extends StatelessWidget {
  final String workflowName;
  final String response; // Response to be displayed in the modal
  final String question; // Question to be displayed in the modal

  const MessageHeader({
    super.key,
    required this.workflowName,
    required this.response,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          workflowName,
          style: GoogleFonts.getFont(
            "Raleway",
            color: Colors.black.withOpacity(0.4),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: () => _openScoreModal(context),
          icon: const Icon(Icons.rate_review, color: Colors.black, size: 20),
        ),
      ],
    );
  }

  /// **Opens the scoring modal using the static method from ScoreModal**
  void _openScoreModal(BuildContext context) {
    ScoreModal.show(
      context, 
      workflowName, 
      response, 
      question,
    );
  }
}
