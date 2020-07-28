import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text('Select A Language'),
        ),
        body: LanguageSelectWidget(),
      ),
    );
  }
}

class LanguageSelectWidget extends StatefulWidget {
  @override
  _LanguageSelectWidgetState createState() => _LanguageSelectWidgetState();
}

class _LanguageSelectWidgetState extends State<LanguageSelectWidget> {
  String selected;

  _getSelectedLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      selected = preferences.getString('selectedLanguage') ?? 'English';
    });
  }

  @override
  void initState() {
    _getSelectedLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
      child: Stack(
        children: <Widget>[
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 40.0,
            children: _languages
                .map((language) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: (selected == language)
                              ? Colors.redAccent
                              : Colors.lightBlueAccent[100].withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.0,
                          ),
                        ),
                        child: RawMaterialButton(
                          shape: CircleBorder(),
                          onPressed: () {
                            setState(() {
                              selected = language;
                            });
                          },
                          child: Center(
                            child: Text(
                              language,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              child: Icon(
                Icons.navigate_next,
                size: 30.0,
              ),
              onPressed: () {
                addToSF(selected);
              },
            ),
          )
        ],
      ),
    );
  }
}

void addToSF(String language) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('selectedLanguage', language);
  print(preferences);
}

List<String> _languages = [
  'English',
  'Hindi',
  'Punjabi',
  'Nepali',
  'Gujrati',
  'Bengali',
  'Sanskrit',
  'Japanese',
  'Mandarin',
];
