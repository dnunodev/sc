import 'package:flutter/material.dart';

class WorkflowClass extends ChangeNotifier {
  // Variables de estado
  String selectedValue = 'Multi Agents Workflow';
  final List<Map<String, String>> options = [
    {'title': 'Multi Agents Workflow', 'description': 'RA, CA, OA and AA'},
    {'title': 'Sequential Agents Workflow', 'description': 'RA, CA, OA and AA'},
    {'title': 'Regulatory Agent Workflow', 'description': 'Only Regulatory Agent'},
    {'title': 'Chemistry Agent Workflow', 'description': 'Only Chemistry Agent'},
    {'title': 'Application Agent Workflow', 'description': 'Only Application Agent'},
    {'title': 'Operations Agent Workflow', 'description': 'Only Operations Agent'},
  ];

  // Método para actualizar selectedValue
  void updateSelectedValue(String newValue) {
    selectedValue = newValue;
    notifyListeners(); // Notifica a los listeners para que reconstruyan los widgets
  }
}
