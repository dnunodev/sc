import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scientific_copilot_genai/GENERAL_CLASSES/color_class.dart';

class UserPromptAttach extends StatelessWidget {
  final VoidCallback onAttachPressed;

  UserPromptAttach({super.key, required this.onAttachPressed});

  //Colors class instance
  final colorClass = ColorClass();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAttachPressed, // Llamamos la función cuando se presione
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: colorClass.grey),
          color: colorClass.background,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(13),
            bottomRight: Radius.circular(13),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.attach_file, color: colorClass.black, size: 20),
              const SizedBox(width: 5),
              Text(
                "Attach",
                style: GoogleFonts.getFont(
                  "Outfit",
                  fontSize: 15,
                  color: colorClass.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
