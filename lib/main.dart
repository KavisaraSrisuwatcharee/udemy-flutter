import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void answerQuestion() {
    print('Answer chosen!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('My first app'),
      ),
      body: Column(
        children: [
          Text('Question'),
          RaisedButton(child: Text('ANSWER 1'), onPressed: answerQuestion),
          RaisedButton(
              child: Text('ANSWER 2'),
              onPressed: () => print('Answer chosen 2 !')),
          RaisedButton(
              child: Text('ANSWER 3'),
              onPressed: () {
                print('Answer chosen 3 !');
              }),
          RaisedButton(child: Text('ANSWER 4'), onPressed: answerQuestion)
        ],
      ),
    ));
  }
}
