import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardFlow extends StatelessWidget {
  final List<Map<String, String>> options;
  final String selectedValue;
  final ValueChanged<String?> onSelectedChange;

  const CardFlow({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelectedChange,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedValue,
        icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 24),
        isExpanded: true,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(15),
        items: options.map((option) {
          return DropdownMenuItem<String>(
            value: option['title'],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  option['title']!,
                  style: GoogleFonts.getFont(
                    "Raleway",
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  option['description']!,
                  style: GoogleFonts.getFont(
                    "Outfit",
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: onSelectedChange,
      ),
    );
  }
}
