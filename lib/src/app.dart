import 'dart:convert';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' show get;
import 'package:programmingfactsandjokes/src/model/DataModel.dart';
import 'package:programmingfactsandjokes/src/util/ad_mob.dart';
import 'package:programmingfactsandjokes/src/widgets/jokes_widget.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class App extends StatefulWidget {
  @override
  AppState createState() => AppState(); // returning instance of widget state
}

class AppState extends State<App> {
  ProgressDialog pr;
  int counter = 0;
  List<JokesAndFacts> jokesFactsList = [];
  List<InterviewQuestions> questionList = [];
  int _selectedIndex = 0;
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchType("jokes");
    });
    FirebaseAdMob.instance.initialize(appId: AdMob.appId);
    //Change appId With Admob Id
    _bannerAd = AdMob().createBannerAd()
      ..load()
      ..show(
          anchorType: AnchorType.top,
          anchorOffset: 25, //kToolbarHeight,
          horizontalCenterOffset: 0.0);

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  Widget build(context) {
    pr = new ProgressDialog(context);

//    pr.style(message: "Loading content");

    return Scaffold(
      appBar: topAppBar,
      body: JokesWidget(jokesFactsList, questionList, _selectedIndex),
      bottomNavigationBar: makeBottom(),
    );
  }

  final topAppBar = AppBar(
    brightness: Brightness.dark,
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    title: Text(
      "Programming World",
      style: TextStyle(fontFamily: "RalewayRegular"),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.info_outline,
          color: Colors.yellow,
        ),
        onPressed: () {
          launch("https://amlavati.com/sqltutorial/privacy_policy_pw.html");
        },
      )
    ],
  );

  Widget makeBottom() {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.tag_faces),
          title: Text('Jokes'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.highlight),
          title: Text('Facts'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('I Questions'),
        ),
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
      selectedItemColor:
          Colors.yellow, //(_selectedIndex == 1) ? Colors.yellow : Colors.white,
    );
  }

  Future<void> _onItemTapped(int index) {
//    show();
    _selectedIndex = index;
    if (_selectedIndex == 0)
      fetchType("jokes");
    else if (_selectedIndex == 1)
      fetchType("facts");
    else {
      fetchType("interviewQuestions");
      AdMob().createInterstitialAd()
        ..load()
        ..show();
    }
  }

  void fetchType(String type) async {
    pr.style(message: "Loading $type");
    pr.show();
    final response = await get("http://amlavati.com/sqltutorial/v1/$type");
    //  debugger();
    //  debugPrint("response::" + response.body.toString());
    if (response.statusCode == 200) {
      final dataModel =
          json.decode(response.body); //["jokes"] as List; // response.body;
      final list = dataModel["$type"] as List;
      if (pr.isShowing()) pr.hide();
      setState(() {
        if (!type.startsWith("interview")) {
          jokesFactsList =
              list.map((tagJson) => JokesAndFacts.fromJson(tagJson)).toList();
        } else
          questionList = list
              .map((tagJson) => InterviewQuestions.fromJson(tagJson))
              .toList();
      });

//      list[0].jokes[0].
    } else {
// If the server did not return a 200 OK response,
// then throw an exception.
      throw Exception('Failed to load album');
    }

  }
}
