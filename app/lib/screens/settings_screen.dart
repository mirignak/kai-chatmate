// 주제, 난이도 설정 화면
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text('Topic & Situation', style: titleStyle),
                    Expanded(
                      child: Card(
                        child: SizedBox.expand(),
                      ),
                    ),
                    Divider(),
                    Text('Level', style: titleStyle),
                    Expanded(
                      child: Card(
                        child: SizedBox.expand(),
                      ),
                    ),
                  ],
                ))));
  }
}
