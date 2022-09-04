// ignore_for_file: prefer_const_constructors, unnecessary_new, deprecated_member_use
import "package:flutter/material.dart";
import 'package:marquee/marquee.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAppHome(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyAppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyappHomeState();
  }
}

class _MyappHomeState extends State<MyAppHome> {
  String userName = "";
  int typedCharLength = 0;
  String lorem =
      "                                             Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris venenatis orci vel commodo commodo. Vestibulum volutpat accumsan dui. Nulla vitae magna eu nulla bibendum ullamcorper quis eu nulla. Proin nisi sapien, vehicula sit amet eleifend et, tincidunt eget dui. Duis interdum ante eget cursus auctor. Nam non risus quis neque dapibus dictum sed eu nulla. Vestibulum sodales arcu eu turpis tempus iaculis. Aenean orci orci, blandit sed pellentesque et, aliquet id ex. Nam id tincidunt tellus. Nam mi urna, sagittis non dolor tincidunt, viverra iaculis ex. Mauris eget pharetra nulla.Donec facilisis convallis luctus. Quisque eu nunc nibh. Donec quis lobortis risus. Donec eu lectus sed metus vestibulum interdum vel feugiat erat. Quisque gravida sodales libero. Phasellus elementum nisl ex, at eleifend leo condimentum vitae. Integer a odio elit. Curabitur eget felis sit amet lacus euismod tincidunt non id sapien. Quisque sem odio, blandit sit amet neque quis, venenatis viverra nibh. Etiam maximus lectus ipsum, quis elementum eros accumsan nec. Phasellus nec dui vitae mi consequat commodo nec nec lacus. Nam at laoreet dolor. Praesent ac ipsum tincidunt, mattis nisi vel, viverra nisl. Nunc euismod ex congue, fringilla dolor sed, tincidunt metus. Mauris posuere nisl mi, sed mollis dui vehicula ac"
          .toLowerCase()
          .replaceAll(",", "")
          .replaceAll(".", "");
  int step = 0;
  late int lastTypedAt;

  void updateLastTypedAt() {
    // ignore: unnecessary_this
    this.lastTypedAt = DateTime.now().millisecondsSinceEpoch;
  }

  void onType(String value) {
    updateLastTypedAt();
    String trimmedValue = lorem.trimLeft();
    setState(() {
      if (trimmedValue.indexOf(value) != 0) {
        step = 2;
      } else {
        typedCharLength = value.length;
      }
    });
  }

  void onuserNametype(String value) {
    setState(() {
    userName = value;  
    });
    
  }

  void resetGame() {
    setState(() {
      typedCharLength = 0;
      step = 0;
    });
  }

  void onStartClick() {
    setState(() {
      // ignore: unnecessary_this
      updateLastTypedAt();
      step++;
    });
    // ignore: unused_local_variable
    var timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      int now = DateTime.now().millisecondsSinceEpoch;
      //GAME OVER
      setState(() {
        if (step == 1 && now - lastTypedAt > 4000) {
          step++;
        }
        if (step != 1) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var shownWidget;

    if (step == 0) {
      shownWidget = <Widget>[
        Text("Oyuna hoşgeldin! Coronadan kaçmaya hazır mısın?"),
        // ignore: avoid_unnecessary_containers
        Container(
          padding:  EdgeInsets.all(20),
          child: TextField(
            onChanged: onuserNametype,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'İsmin nedir klavye delikanlısı? ',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: RaisedButton(
            onPressed: userName.length == 0 ? null :onStartClick,
            child: Text("BAŞLA!"),
          ),
        ),
      ];
    } else if (step == 1) {
      shownWidget = <Widget>[
        Text("$typedCharLength"),
        // ignore: sized_box_for_whitespace
        Container(
          height: 40,
          child: Marquee(
            text: lorem,
            style: TextStyle(fontSize: 24, letterSpacing: 2),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 75,
            startPadding: 0,
            accelerationDuration: Duration(seconds: 15),
            accelerationCurve: Curves.ease,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 32),
          // ignore: unnecessary_const
          child: TextField(
            autofocus: true,
            onChanged: onType,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Yaz bakalım',
            ),
          ),
        )
      ];
    } else {
      shownWidget = <Widget>[
        Text("Coronadan kaçamadın, skorun: $typedCharLength"),
        RaisedButton(
          onPressed: resetGame,
          child: Text("Yeniden dene!"),
        )
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Klavye Delikanlısı"),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: shownWidget,
        ),
      ),
    );
  }
}
