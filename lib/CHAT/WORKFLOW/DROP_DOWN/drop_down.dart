import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scientific_copilot_genai/CHAT/WORKFLOW/CARD_FLOW/card_flow.dart';
import 'package:scientific_copilot_genai/CHAT/WORKFLOW/workflow_class.dart';
import 'package:scientific_copilot_genai/GENERAL_CLASSES/color_class.dart';

class DropDown extends StatelessWidget {
  const DropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final workflowState = Provider.of<WorkflowClass>(context);
    final colorClass = ColorClass();

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: colorClass.grey),
          ),
          child: CardFlow(
            options: workflowState.options,
            selectedValue: workflowState.selectedValue,
            onSelectedChange: (newValue) {
              if (newValue != null) {
                workflowState.updateSelectedValue(newValue);
              }
            },
          ),
        ),
      ),
    );
  }
}
