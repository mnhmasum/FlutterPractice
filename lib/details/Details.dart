import 'package:flutter/material.dart';
import '../home/HomeBloc.dart';
import '../details/DetailsBloc.dart';
import '../main.dart';

class Details extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _counterService = getIt<CategoryBloc>();
    final _apiCallService = getIt<DetailsBloc>();

    _apiCallService.getInfo();

    final appBar = AppBar(
      elevation: 0.0,
      title: Text(
        'Wall',
        style: TextStyle(
          color: Colors.white,
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
          Container(color: Color(30), child: Text('text')),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: StreamBuilder(
                    stream: _counterService.stream$,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return RaisedButton(
                        onPressed: () {
                          _counterService.increment();
                          Navigator.pop(context);
                        },
                        child: Text('Go back! ${snapshot.data}'),
                      );
                    }),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text("Messege"),
            ),
          ),
          Container(
            child: StreamBuilder(
              stream: _apiCallService.streamTextChange$,
              builder: (context, snapshot) {
                return Center(
                  child: Text("Sub message ${snapshot.data}"),
                );
              }
            ),
          )
        ],
      ),
    );

    return screen;
  }
}
