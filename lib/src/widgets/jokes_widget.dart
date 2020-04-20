import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:programmingfactsandjokes/src/model/DataModel.dart';

class JokesWidget extends StatelessWidget {
  final List<JokesAndFacts> jokesList;
  final List<InterviewQuestions> questionList;
  final int selectedIndex;
  bool isIos;


  JokesWidget(this.jokesList, this.questionList, this.selectedIndex);

  @override
  Widget build(BuildContext context) {

    isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return ListView.separated(
      itemCount: (selectedIndex < 2) ? jokesList.length : questionList.length,
      itemBuilder: (context, int index) {
        if (selectedIndex < 2) {
          return buildJokesAndFacts(jokesList[index]);
        } else {
          return buildInterviewQuestion(questionList[index]);
        }
        //return ListTile(title: Text(jokesList[index].message));
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey,
          thickness: 1,
          height: 20,
        );
      },
    );
  }

  Widget buildInterviewQuestion(InterviewQuestions questions) {
    return Container(
//      decoration: BoxDecoration(
//
//        border: Border.all(color: Colors.grey),
//      ),
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
//      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            questions.question,
            style: TextStyle(
                fontSize: 25,
                fontFamily: "RalewayLight",
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          Text(
            questions.answer,
            style: TextStyle(fontSize: 25, fontFamily: "RalewayLight"),
          ),
          Text(
            questions.askedIn,
            style: TextStyle(fontSize: 25, fontFamily: "RalewayLight"),
          ),
          Text(
            questions.explanation,
            style: TextStyle(fontSize: 25, fontFamily: "RalewayLight"),
          ),
          RaisedButton.icon(
            onPressed: () => share("", questions.question, questions.answer),

            // share(jokes.image, jokes.title, jokes.message),
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text(""),
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            textColor: Colors.white,
            splashColor: Color.fromRGBO(58, 66, 86, 1.0),
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget buildJokesAndFacts(JokesAndFacts jokes) {
    return Container(
//      decoration: BoxDecoration(
//
//        border: Border.all(color: Colors.grey),
//      ),
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
//      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            jokes.title,
            style: TextStyle(
                fontSize: 25,
                fontFamily: "RalewayLight",
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          Text(
            jokes.message,
            style: TextStyle(fontSize: 25, fontFamily: "RalewayLight"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Image.network(jokes.image),
          ),
          RaisedButton.icon(
            onPressed: () => share(jokes.image, jokes.title, jokes.message),

            // share(jokes.image, jokes.title, jokes.message),
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text(""),
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            textColor: Colors.white,
            splashColor: Color.fromRGBO(58, 66, 86, 1.0),
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  share(String imageUrl, String title, String message) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String linkType =
//        "For iOS : itms-apps://itunes.apple.com/" +
//        packageInfo.packageName +
        "Android:  https://play.google.com/store/apps/details?id=" +
        packageInfo.packageName;

    String shareTest = title +
        "\n" +
        message +
        "\n\n Download and Share the app for more... \n " +
        linkType;

    if (imageUrl != "") {
      var request = await HttpClient().getUrl(Uri.parse(imageUrl));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('Share', 'amlog.jpg', bytes, 'image/jpg',
          text: shareTest);
    } else {
      Share.text(
        'Share',
        shareTest,
        'text/html',
      );
    }
  }
}
