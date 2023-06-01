import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Text('English Chat with GPT'),
            SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/speech');
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue.shade900),
                minimumSize: MaterialStateProperty.all(Size(300, 80)),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              ),
              child: Text('Start Conversation'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: Text('Settings'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/report');
              },
              child: Text('Report'),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
