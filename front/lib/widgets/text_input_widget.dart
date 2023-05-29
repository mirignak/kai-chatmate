import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: 'Enter text...',
        ),
      ),
    );
  }
}
