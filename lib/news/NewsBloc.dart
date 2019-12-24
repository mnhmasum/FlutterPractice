import 'package:flutter_app/datamodel/News.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

// Data Model
class NewsBloc {
  BehaviorSubject _textChanger = new BehaviorSubject<String>.seeded("Loading data....");
  BehaviorSubject newsData = new BehaviorSubject<List<Articles>>.seeded(null);

  Observable get streamTextChange$ => _textChanger.stream;
  Observable get streamNews$ => newsData.stream;

  String get currentText => _textChanger.value;

  List<Articles> get currentArticles => newsData.value;

  callAPI(String text) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = "https://newsapi.org/v2/top-headlines?country=" + text +
        "&category=business&apiKey=51020d256c68430ba9bd415505885b3e";

    print(url);

    Map<String, String> headers = {
      "Accept": "application/json",
    };

    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      News news = News.fromJson(jsonResponse);

      if (news.articles.length > 0) {
        newsData.add(news.articles);
      } else {
        _textChanger.add('Sorry data not found');
      }
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

  getInfo(String text) {
    _textChanger.add('Loading....');
    newsData.add(null);
    callAPI(text);
  }
}
