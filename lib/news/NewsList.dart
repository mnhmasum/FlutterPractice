import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/datamodel/News.dart';
import 'package:flutter_app/details/NewsDetails.dart';
import '../news/NewsBloc.dart';
import '../main.dart';

class NewsList extends StatelessWidget {
  String queryText = '';
  final String message;
  final String countryName;
  List<Articles> articles = new List<Articles>();

  NewsList(this.message, this.countryName);

  @override
  Widget build(BuildContext context) {
    final _apiCallService = getIt<NewsBloc>();
    _apiCallService.getInfo(message.toLowerCase());
    print("Details Called===>" + message);

    final appBar = AppBar(
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: Text(
        'Headlines',
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(countryName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
          ),
          Container(
            child: StreamBuilder(
                stream: _apiCallService.streamTextChange$,
                builder: (context, snapshot) {
                  return Container(
                    height: 4.0,
                    decoration: new BoxDecoration(color: Colors.white70),
                  );
                }),
          ),
          StreamBuilder(
              stream: _apiCallService.streamNews$,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetails(
                                          (snapshot.data[index] as Articles)),
                                    ));

                                print('I was tapped! ${snapshot.data}');
                              },
                              title: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 80,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 100,
                                            height: 100,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  '${(snapshot.data[index] as Articles).urlToImage}',
                                              placeholder: (context, url) =>
                                                  Container(
                                                      width: 30,
                                                      height: 30,
                                                      child: Icon(
                                                          Icons.autorenew)),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8.0, 0, 0, 0),
                                              child: Container(
                                                child: Text(
                                                    ' ${(snapshot.data[index] as Articles).title}'),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        height: 1.0,
                                        decoration: new BoxDecoration(
                                            color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }));
                } else {
                  return Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              })
        ],
      ),
    );

    return screen;
  }
}
