import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/datamodel/News.dart';
import 'package:flutter_app/details/NewsDetails.dart';
import '../news/NewsBloc.dart';

class NewsList extends StatefulWidget {
  final String message;
  final String countryName;

  NewsList(this.message, this.countryName);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList>
    with SingleTickerProviderStateMixin {
  String queryText = '';
  final _apiCallService = new NewsBloc();
  List<Articles> articles = new List<Articles>();

  Animation<double> animation;
  AnimationController controller;

  Widget separator() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        height: 1.0,
        decoration: new BoxDecoration(color: Colors.black),
      ),
    );
  }

  Widget customImageView(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      child: CachedNetworkImage(
        imageUrl: '$imageUrl',
        placeholder: (context, url) =>
            Container(width: 30, height: 30, child: Icon(Icons.autorenew)),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _apiCallService.dispose();
    print("Dispose called");
  }

  @override
  Widget build(BuildContext context) {
    _apiCallService.getInfo(widget.message.toLowerCase());

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
                child: Text(widget.countryName,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                                decoration: new BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white70,
                                      blurRadius: 25.0,
                                      // soften the shadow
                                      spreadRadius: 5.0,
                                      //extend the shadow
                                      offset: Offset(
                                        15.0,
                                        // Move to right 10  horizontally
                                        15.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 80,
                                      child: Row(
                                        children: <Widget>[
                                          customImageView(
                                              '${(snapshot.data[index] as Articles).urlToImage}'),
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
                                    separator()
                                  ],
                                ),
                              ),
                            );
                          }));
                } else {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      height: animation.value,
                      width: animation.value,
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
