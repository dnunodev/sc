import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/chat_controller.dart';
import 'package:scientific_copilot_genai/CHAT/WORKFLOW/workflow_class.dart';
import 'package:scientific_copilot_genai/CHAT/chat_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WorkflowClass()),
        ChangeNotifierProvider(create: (context) => ChatController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChatUi(),
    );
  }
}