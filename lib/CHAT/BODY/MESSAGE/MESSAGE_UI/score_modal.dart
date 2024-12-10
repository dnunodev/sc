import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ScoreModal extends StatefulWidget {
  final String workflow;
  final String response;
  final String question;

  const ScoreModal({
    super.key,
    required this.workflow,
    required this.response,
    required this.question,
  });

  @override
  State<ScoreModal> createState() => _ScoreModalState();

  /// Método para mostrar la hoja modal
  static void show(BuildContext context, String workflow, String response, String question) {
    WoltModalSheet.show(
      context: context,
      pageListBuilder: (bottomSheetContext) {
        return [
          WoltModalSheetPage(
            topBarTitle: Text(
              'Score',
              style: GoogleFonts.getFont("Outfit", fontSize: 20, color: Colors.black),
            ),
            isTopBarLayerAlwaysVisible: true,
            backgroundColor: Colors.white,
            trailingNavBarWidget: IconButton(
              padding: const EdgeInsets.all(20),
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () => Navigator.of(bottomSheetContext).pop(),
            ),
            child: ScoreModal(
              workflow: workflow,
              response: response,
              question: question,
            ),
          ),
        ];
      },
    );
  }
}

class _ScoreModalState extends State<ScoreModal> {
  bool showResponse = false;
  bool badResponse = false;
  bool regularResponse = false;
  bool goodResponse = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSeeResponseToggle(),
            _buildResponseContent(),
            const SizedBox(height: 10),
            _buildScoreTitle(),
            const SizedBox(height: 10),
            _buildScoreOptions(),
            const SizedBox(height: 20),
            _buildCommentBox(),
            const SizedBox(height: 20),
            _buildFooterButtons(),
          ],
        ),
      ),
    );
  }

  /// **Toggle para ver/ocultar la respuesta**
  Widget _buildSeeResponseToggle() {
    return InkWell(
      onTap: () {
        setState(() {
          showResponse = !showResponse;
        });
      },
      child: Row(
        children: [
          Text(
            showResponse ? "Hide answer" : "See answer",
            style: GoogleFonts.getFont(
              "Raleway",
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            showResponse ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  /// **Mostrar el contenido de la respuesta**
  Widget _buildResponseContent() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      height: showResponse ? 200 : 0,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100,
          ),
          child: MarkdownBody(
            data: widget.response,
            selectable: true,
            styleSheet: MarkdownStyleSheet(
              p: GoogleFonts.getFont(
                "Outfit",
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **Título de la sección de calificación**
  Widget _buildScoreTitle() {
    return Text(
      "* Choose the Answer Score",
      style: GoogleFonts.getFont(
        "Outfit",
        fontSize: 15,
        color: Colors.red,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// **Opciones para puntuar la respuesta**
  Widget _buildScoreOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildScoreOption("Bad", badResponse, () {
          setState(() {
            badResponse = true;
            regularResponse = false;
            goodResponse = false;
          });
        }),
        _buildScoreOption("Regular", regularResponse, () {
          setState(() {
            badResponse = false;
            regularResponse = true;
            goodResponse = false;
          });
        }),
        _buildScoreOption("Good", goodResponse, () {
          setState(() {
            badResponse = false;
            regularResponse = false;
            goodResponse = true;
          });
        }),
      ],
    );
  }

  /// **Opción individual de puntuación**
  Widget _buildScoreOption(String label, bool isSelected, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.getFont(
              "Outfit",
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  /// **Caja de comentarios**
  Widget _buildCommentBox() {
    return TextField(
      controller: _commentController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Comment (optional)',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  /// **Botones de pie de página**
  Widget _buildFooterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildFooterButton("Cancel", Colors.redAccent, () {
          Navigator.pop(context);
        }),
        const SizedBox(width: 10),
        _buildFooterButton("Send", Colors.blueAccent, () {
          final feedbackData = {
            'workflow': widget.workflow,
            'response': widget.response,
            'question': widget.question,
            'grading': badResponse ? "Bad" : regularResponse ? "Regular" : goodResponse ? "Good" : 'Not Graded',
            'comment': _commentController.text,
          };

          print("Feedback Data: $feedbackData");

          Navigator.pop(context);
        }),
      ],
    );
  }

  /// **Botón de pie de página reutilizable**
  Widget _buildFooterButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        label,
        style: GoogleFonts.getFont("Outfit", fontSize: 15, color: Colors.white),
      ),
    );
  }
}
