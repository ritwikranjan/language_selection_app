import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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
  String selected = 'English';

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
                .map((language) => FlatButton(
                      onPressed: () {
                        setState(() {
                          selected = language;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: (selected == language)
                              ? Colors.redAccent
                              : Colors.lightBlueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            language,
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
                addStringToSF(selected);
              },
            ),
          )
        ],
      ),
    );
  }
}

addStringToSF(String language) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('selectedLanguage', language);
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
