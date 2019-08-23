import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'CategoryBloc.dart';
import 'category.dart';
import 'main.dart';

final _backgroundColor = Colors.green[100];

/// Category Route (screen).
///
/// This is the 'home' screen of the Unit Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.
class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  @override
  State<StatefulWidget> createState() {
    return Home();
  }
}

class Home extends State<CategoryRoute> {
  //final _bloc = CategoryBloc();

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

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

  Widget _buildCategoryWidgets(List<Widget> categories) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => categories[index],
      itemCount: categories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    //GetIt getIt = new GetIt();
    final _counterService = getIt<CategoryBloc>();

    final categories = <Category>[];

    for (var i = 0; i < _categoryNames.length; i++) {
      categories.add(Category(
        name: _categoryNames[i],
        color: _baseColors[i],
        iconLocation: Icons.cake,
      ));
    }

    final listView = Container(
      color: _backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryWidgets(categories),
    );

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
                          Text('You have 2'),
                          FlatButton(
                            onPressed: () => _counterService.increment(),
                            child: new Text("Tap Here"),
                          ),
                          new Expanded(child: listView)
                  ]));
                })));
  }

  @override
  void dispose() {
    super.dispose();
    //_bloc.dispose();
  }
}
