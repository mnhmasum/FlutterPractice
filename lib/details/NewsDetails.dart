import 'package:flutter/material.dart';
import 'package:flutter_app/datamodel/News.dart';

class NewsDetails extends StatelessWidget {
  String queryText = '';
  Articles articles = new Articles();

  NewsDetails(this.articles);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: Text(
        'News',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
        ),
      ),
      centerTitle: false,
      backgroundColor: Colors.lightBlue[100],
    );

    final screen = Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Color(30),
                child: Text(
                  articles.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  articles.content,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );

    return screen;
  }
}
