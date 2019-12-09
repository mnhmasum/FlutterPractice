
import 'package:rxdart/rxdart.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

// Data Model
class DetailsBloc {
  // ignore: close_sinks
  BehaviorSubject _textChanger = new BehaviorSubject<String>.seeded("Loading data....");

  Observable get streamTextChange$ => _textChanger.stream;

  String get currentText => _textChanger.value;


  callAPI() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = "https://www.googleapis.com/books/v1/volumes?q={http}";

    // Await the http get response, then decode the json-formatted responce.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['totalItems'];
      print("Number of books about http: $itemCount.");

      _textChanger.add('${response.body}');

    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

  getInfo() {
    callAPI();
  }
}
