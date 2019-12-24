import 'package:flutter/material.dart';
import 'package:flutter_app/news/NewsBloc.dart';
import 'home/HomeBloc.dart';
import 'home/HomeScreen.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = new GetIt();

void main() {
  getIt.registerSingleton<CategoryBloc>(CategoryBloc());
  getIt.registerSingleton<NewsBloc>(NewsBloc());
  runApp(Dashboard());
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Latest News',
        home: HomeScreen());
  }
}
