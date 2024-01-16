import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ai_call2.dart';

class aicall1 extends StatelessWidget {
  aicall1({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    RxString result = ''.obs;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('AI Bot'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: 'Type your question here',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(8))),
                keyboardType: TextInputType.text,
                controller: textController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  result.value =
                      await GeminiAPI.getGeminiData(textController.text);
                },
                child: const Text(
                  'generate',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Card(
                    color: Colors.grey[600],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        result.value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
