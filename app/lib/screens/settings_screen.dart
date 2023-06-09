// 주제, 난이도 설정 화면
import 'dart:convert';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLevel = ''; // 선택된 Level을 저장할 변수
  int codeValue = 0; // 코드값을 저장할 변수
  List<String> selectedSubjects = [];

  TextStyle titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  List<Map<String, dynamic>> subjectList = [];

  @override
  void initState() {
    super.initState();
    selectedSubjects = [];
    loadSituationsData().then((data) {
      setState(() {
        subjectList = data;
      });
    });
  }

  Future<List<Map<String, dynamic>>> loadSituationsData() async {
    final situationsData = await DefaultAssetBundle.of(context)
        .loadString('assets/situations.json');
    final situationsJson = json.decode(situationsData);

    return List<Map<String, dynamic>>.from(situationsJson['topics']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text('Level', style: titleStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio<String>(
                          value: '1',
                          groupValue: selectedLevel,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLevel = newValue!;
                              codeValue = 1;
                            });
                          },
                        ),
                        Text('Beginner'),
                        Radio<String>(
                          value: '2',
                          groupValue: selectedLevel,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLevel = newValue!;
                              codeValue = 2;
                            });
                          },
                        ),
                        Text('Intermediate'),
                        Radio<String>(
                          value: '3',
                          groupValue: selectedLevel,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLevel = newValue!;
                              codeValue = 3;
                            });
                          },
                        ),
                        Text('Advanced'),
                      ],
                    ),
                    Divider(),
                    Text('Topic & Situation', style: titleStyle),
                    Expanded(
                      child: ListView.builder(
                        itemCount: subjectList.length,
                        itemBuilder: (context, index) {
                          final subject = subjectList[index];
                          final subjectId = subject['id'];
                          final subjectName = subject['subject'];

                          return CheckboxListTile(
                            title: Text(subjectName),
                            value: selectedSubjects.contains(subjectId),
                            onChanged: (bool? newValue) {
                              setState(() {
                                if (newValue!) {
                                  selectedSubjects.add(subjectId);
                                } else {
                                  selectedSubjects.remove(subjectId);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ))));
  }
}
