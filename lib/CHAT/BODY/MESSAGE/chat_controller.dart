import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:scientific_copilot_genai/CHAT/BODY/MESSAGE/chat_message_class.dart';
import 'package:scientific_copilot_genai/CHAT/WORKFLOW/workflow_class.dart';

class ChatController with ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final List<ChatMessageClass> messages = [];
  bool inResponse = false;

  ChatController() {
    _initializeMessages();
  }

  void _initializeMessages() {
    // Initial bot message
    messages.add(ChatMessageClass(
      text: 'Welcome to GenAI PoC Agent! How can I assist you today?',
      sender: 'bot',
      workflow: 'General',
      images: [],
    ));
  }

  final Map<String, Map<String, String>> workflowEndpoints = {
    "Multi Agents Workflow": {
      "url": "http://3.91.44.180:3000/api/v1/prediction/a2bb25c9-7497-47c3-b221-633172944487",
      "authorization": "Bearer gRU22ntpb4mWZ2r6rpuxMlJ9qQDefHHm7qK8qDSHDxI",
    },
    "Sequential Agents Workflow": {
      "url": "http://3.91.44.180:3000/api/v1/prediction/46f434c6-1d20-4fcb-b0f2-4f4bbeb7e154",
      "authorization": "Bearer gRU22ntpb4mWZ2r6rpuxMlJ9qQDefHHm7qK8qDSHDxI",
    },
    "Regulatory Agent Workflow": {
      "url": "http://3.91.44.180:3000/api/v1/prediction/b6a5aad5-1825-40c4-8d5d-4831b97d462f",
      "authorization": "Bearer gRU22ntpb4mWZ2r6rpuxMlJ9qQDefHHm7qK8qDSHDxI",
    },
    "Chemistry Agent Workflow": {
      "url": "http://3.91.44.180:3000/api/v1/prediction/2997ac0d-0361-4416-b00d-8427b1d3feda",
      "authorization": "Bearer gRU22ntpb4mWZ2r6rpuxMlJ9qQDefHHm7qK8qDSHDxI",
    },
    "Application Agent Workflow": {
      "url": "http://3.91.44.180:3000/api/v1/prediction/de4acf1a-e6fd-4e05-9996-14a0b7b00804",
      "authorization": "Bearer gRU22ntpb4mWZ2r6rpuxMlJ9qQDefHHm7qK8qDSHDxI",
    },
    "Operations Agent Workflow": {
      "url": "http://3.91.44.180:3000/api/v1/prediction/0c0b1227-fd36-4c83-9dc4-8d1a70f06ea8",
      "authorization": "Bearer gRU22ntpb4mWZ2r6rpuxMlJ9qQDefHHm7qK8qDSHDxI",
    },
  };

  /// Sends a message to the bot and waits for a response. 
  /// Once the bot responds, `onBotResponded` is called (if provided) so you can clear images.
  Future<void> sendMessage(
    BuildContext context, 
    String message, 
    List<List<int>> imageFiles, 
    {VoidCallback? onBotResponded}
  ) async {
    if (inResponse) return;
    inResponse = true;
    notifyListeners();
    
    // Get the selected workflow from WorkflowClass
    final workflowState = Provider.of<WorkflowClass>(context, listen: false);
    final selectedWorkflow = workflowState.selectedValue;

    // Convert images to Uint8List
    final imagesUint8List = imageFiles.map((bytes) => Uint8List.fromList(bytes)).toList();

    final userMessage = ChatMessageClass(
      text: message,
      sender: 'user',
      workflow: '',
      images: imagesUint8List,
    );
    messages.add(userMessage);

    final botMessage = ChatMessageClass(
      text: '',
      sender: 'bot',
      workflow: selectedWorkflow,
      images: [],
    );
    messages.add(botMessage);
    notifyListeners();

    try {
      final workflowConfig = workflowEndpoints[selectedWorkflow];
      if (workflowConfig == null) {
        throw Exception("Invalid workflow selected");
      }

      final apiUrl = workflowConfig["url"]!;
      final authorization = workflowConfig["authorization"]!;
      final headers = {
        'Authorization': authorization,
        'Content-Type': 'application/json',
      };

      final imageUploads = imageFiles.map((bytes) {
        final base64Image = base64Encode(bytes);
        return {
          'data': 'data:image/png;base64,$base64Image',
          'type': 'file',
          'name': 'user_image.png',
          'mime': 'image/png',
        };
      }).toList();

      final payload = {
        'question': message,
        'overrideConfig': {'returnSourceDocuments': true},
        'uploads': imageUploads,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final responseText = responseJson['text'] ?? "No response text available";
        botMessage.text = responseText;
      } else {
        botMessage.text = "Error in server response";
      }
    } catch (e) {
      botMessage.text = "Error sending message: ${e.toString()}";
    } finally {
      inResponse = false;
      notifyListeners();
      scrollToEnd();
      // Call the callback after the bot responded
      if (onBotResponded != null) {
        onBotResponded();
      }
    }
  }

  void scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
