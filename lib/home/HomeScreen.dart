import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'HomeBloc.dart';
import '../main.dart';
import '../news/NewsList.dart';
import 'package:flutter/services.dart' show rootBundle;

final _backgroundColor = Colors.green[100];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen();

  @override
  Home createState() {
    return Home();
  }
}

class Home extends State<CategoryScreen> {
  //final _bloc = CategoryBloc();

  /* String _text = "";

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];*/

//  Widget _buildCategoryWidgets(List<String> categories) {
//    return ListView.builder(
//      shrinkWrap: true,
//      itemBuilder: (BuildContext context, int index) => categories[index],
//      itemCount: categories.length,
//    );
//  }

  final myController = TextEditingController();
  List<String> countryCodeList = List<String>();
  final List<String> duplicatedItems = List<String>();

  LinkedHashMap countryCodes = new LinkedHashMap<String, String>();
  Home() {
    countryCodes.putIfAbsent("US", () => "AMERICA");
    countryCodes.putIfAbsent("GB", () => "GREAT BRITAIN");
    countryCodes.putIfAbsent("CN", () => "CHINA");
    countryCodes.putIfAbsent("IN", () => "INDIA");
    countryCodes.putIfAbsent("AU", () => "AUSTRALIA");

    countryCodes.forEach((k,v) => duplicatedItems.add(v));

 /*   duplicatedItems.add("GB");
    duplicatedItems.add("CN");
    duplicatedItems.add("IN");
    duplicatedItems.add("AU");*/
  }

  parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    rootBundle.loadString(assetsPath).then((jsonStr) => print("==>" + jsonStr));
  }

  @override
  void initState() {
    countryCodeList.addAll(duplicatedItems);
    print('Loading... UI !');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _counterService = getIt<CategoryBloc>();


    final appBar = AppBar(
      elevation: 0.0,
      title: Text(
        'Latest News',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: _backgroundColor,
    );

    return Scaffold(
        appBar: appBar,
        body: Container(
            child: StreamBuilder(
                stream: _counterService.stream$,
                initialData: 0,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Container(
                      child: Column(children: <Widget>[
                    /*      FlatButton(
                      onPressed: () {
                        _counterService.increment();
                        setState(() {
                          //_text = text;
                        });
                        //myController.text = "Try now";
                      },
                      //child: new Text("Tap Here $_text"),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        onChanged: (text) {
                          List<String> dummySearchList = List<String>();
                          dummySearchList.addAll(duplicatedItems);
                          if (text.isNotEmpty) {
                            List<String> finalList = List<String>();
                            dummySearchList.forEach((item) {
                              if (item.toUpperCase().contains(text.toUpperCase())) {
                                log(item);
                                finalList.add(item);
                              }
                            });

                            setState(() {
                              countryCodeList.clear();
                              countryCodeList.addAll(finalList);
                            });

                            return;
                          } else {
                            setState(() {
                              countryCodeList.clear();
                              countryCodeList.addAll(duplicatedItems);
                            });
                          }

//                          setState(() {
//                            _text = text;
//                          });
                        },
                        controller: myController,
                        decoration:
                            InputDecoration(hintText: 'Enter a search term'),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: countryCodeList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {

                                  countryCodes.forEach((k,v) {
                                    if(countryCodeList[index].toString().contains(v)) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsList(k.toString().toLowerCase())),
                                      );
                                    }
                                  });

                                  print('I was tapped! ${snapshot.data}');
                                },
                                title: Text('${countryCodeList[index]}'),
                              );
                            }))
                  ]));
                })));
  }

  @override
  void dispose() {
    super.dispose();
    //_bloc.dispose();
  }
}
