import 'package:flutter/material.dart';

class SpeechInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          onPressed: () {
            // Start listening for speech input
          },
          child: Icon(Icons.mic),
        ),
        SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            // Stop listening for speech input
          },
          child: Icon(Icons.stop),
        ),
      ],
    );
  }
}
