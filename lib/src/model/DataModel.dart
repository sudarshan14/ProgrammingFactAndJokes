class JokesAndFacts {
  String _category;
  String _title;
  String _message;
  String _image;

  JokesAndFacts(category, title, message, image) {
    this._category = category;
    this._title = title;
    this._message = message;
    this._image = image;
  }

//  factory Jokes.fromJson(dynamic json) {
//    return Jokes(json['category'] as String, json['title'] as String,
//        json['message'] as String, json['image'] as String);
//  }

  JokesAndFacts.fromJson(Map<String, dynamic> json) {
    _category = json['category'];
    _title = json['title'];
    _message = json['message'];
    _image = json['image'];
  }

  String get category => _category;

  set category(String category) => _category = category;

  String get title => _title;

  set title(String title) => _title = title;

  String get message => _message;

  set message(String message) => _message = message;

  String get image => _image;

  set image(String image) => _image = image;

}


class InterviewQuestions {
  int sno;
  String question;
  String answer;
  String explanation;
  String askedIn;
  String visibe;

  InterviewQuestions({this.sno,
    this.question,
    this.answer,
    this.explanation,
    this.askedIn,
    this.visibe});

  InterviewQuestions.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    question = json['question'];
    answer = json['answer'];
    explanation = json['explanation'];
    askedIn = json['asked_in'];
    visibe = json['visibe'];
  }
}
//class DataModel {
//  List<Jokes> _jokes;
//
//  DataModel({List<Jokes> jokes}) {
//    this._jokes = jokes;
//  }
//
//  List<Jokes> get jokes => _jokes;
//  set jokes(List<Jokes> jokes) => _jokes = jokes;
//
//  DataModel.fromJson(Map<String, dynamic> json) {
//    if (json['jokes'] != null) {
//      _jokes = new List<Jokes>();
//      json['jokes'].forEach((v) {
//        _jokes.add(new Jokes.fromJson(v));
//      });
//    }
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this._jokes != null) {
//      data['jokes'] = this._jokes.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//}
//
//class Jokes {
//  String _category;
//  String _title;
//  String _message;
//  String _image;
//
//  Jokes({String category, String title, String message, String image}) {
//    this._category = category;
//    this._title = title;
//    this._message = message;
//    this._image = image;
//  }
//

//
//  Jokes.fromJson(Map<String, dynamic> json) {
//    _category = json['category'];
//    _title = json['title'];
//    _message = json['message'];
//    _image = json['image'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['category'] = this._category;
//    data['title'] = this._title;
//    data['message'] = this._message;
//    data['image'] = this._image;
//    return data;
//  }
//}
