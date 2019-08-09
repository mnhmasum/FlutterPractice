import 'package:flutter/material.dart';

import 'CategoryRoute.dart';

void main() => runApp(UnitConverterApp());

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      home:   CategoryRoute()
    );
  }
}
//https://fireship.io/lessons/flutter-state-management-guide/

/*class HelloRectangular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.redAccent,
        child: Center(
            child: InkWell(
          // When the user taps the button, show a snackbar.
            onTap: () {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Tap to action'),
              ));
            },
            child: Container(
              color: Colors.amber,
              padding: EdgeInsets.all(17.0),
              child: Text('Flat Button'),
            ),
        )));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
          appBar: AppBar(title: Text("Hello Flutter World")),
          body: HelloRectangular()),
    );
  }
}*/

//void main() => runApp(MyApp());

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  createState() => _MyHomePageState();
}

Widget _buildGrid() => GridView.extent(
    maxCrossAxisExtent: 10,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: _buildGridTileList(30));


List<Container> _buildGridTileList(int count) => List.generate(
    count, (i) => Container(child: Text('You have pushed the button this many times:')));

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hello Flutter World")),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        color: Colors.deepOrangeAccent,
        child: Container(
          child: Column(
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              Text('$_counter'),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.lightBlue,
                child: _buildGrid(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter++;
        },
        child: Icon(Icons.add),
      ),
    );
  }
}*/
