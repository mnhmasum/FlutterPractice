import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/datamodel/News.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class NewsDetails extends StatelessWidget {
  String queryText = '';
  Articles articles = new Articles();

  NewsDetails(this.articles);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
          Container(
            child: CachedNetworkImage(
              imageUrl: '${articles.urlToImage}',
              placeholder: (context, url) => Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                color: Color(30),
                child: Text(
                  articles.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(child: Text(articles.publishedAt)),
                  Center(
                    child: RaisedButton(
                      child: Icon(Icons.visibility),
                      onPressed: () {
                        _launchURL(articles.url);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
