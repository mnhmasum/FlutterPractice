import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/Category.dart' as prefix0;

import 'CategoryBloc.dart';
import 'category.dart';
import 'main.dart';
import 'home/Details.dart';

final _backgroundColor = Colors.green[100];

/// Category Route (screen).
///
/// This is the 'home' screen of the Unit Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.
class CategoryScreen extends StatefulWidget {
  const CategoryScreen();

  @override
  Home createState() {
    return Home();
  }
}

class Home extends State<CategoryScreen> {
  //final _bloc = CategoryBloc();

  final myController = TextEditingController();

  String _text = "";

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

//  Widget _buildCategoryWidgets(List<String> categories) {
//    return ListView.builder(
//      shrinkWrap: true,
//      itemBuilder: (BuildContext context, int index) => categories[index],
//      itemCount: categories.length,
//    );
//  }

  //final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  List<String> categories = List<String>();
  final List<String> duplicatedItems = List<String>();

  Home() {
    log("First Time Called===>");
    //for (var i = 0; i < _categoryNames.length; i++) {
    duplicatedItems.add("apple");
    duplicatedItems.add("banana");
    duplicatedItems.add("papa");
    duplicatedItems.add("guava");
    duplicatedItems.add("mango");
    //}
  }

  @override
  void initState() {
    categories.addAll(duplicatedItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //GetIt getIt = new GetIt();
    final _counterService = getIt<CategoryBloc>();

    /* final listView = Container(
      color: _backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 3.0),
      child: _buildCategoryWidgets(categories),
    );*/

    final appBar = AppBar(
      elevation: 0.0,
      title: Text(
        'Unit Converter',
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
                    Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        color: Colors.lightBlue,
                        child: Text('You have: ${snapshot.data}',
                            textAlign: TextAlign.left)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        onChanged: (text) {
                          List<String> dummySearchList = List<String>();
                          dummySearchList.addAll(duplicatedItems);
                          if (text.isNotEmpty) {
                            List<String> finalList = List<String>();
                            dummySearchList.forEach((item) {
                              if (item.contains(text)) {
                                log(item);
                                finalList.add(item);
                              }
                            });

                            setState(() {
                              finalList.forEach((finalItem) {
                                log("==> " + finalItem);
                              });

                              categories.clear();
                              categories.addAll(finalList);
                            });

                            return;
                          } else {
                            setState(() {
                              categories.clear();
                              categories.addAll(duplicatedItems);
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
                    FlatButton(
                      onPressed: () {
                        _counterService.increment();
                        myController.text = "Try now";
                        //categories.removeAt(0);
                        setState(() {
                          //_text = text;
                        });
                      },
                      child: new Text("Tap Here $_text"),
                    ),
                    Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Details()),
                                  );

                                  print('I was tapped! ${snapshot.data}');
                                },
                                title: Text('${categories[index]}'),
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
