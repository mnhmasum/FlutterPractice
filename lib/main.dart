import 'package:flutter/material.dart';
import 'CategoryBloc.dart';
import 'CategoryRoute.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = new GetIt();

void main() {
  getIt.registerSingleton<CategoryBloc>(CategoryBloc());
  //getIt.registerSingleton<CategoryBloc>(new CategoryBloc());
  runApp(Dashboard());
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unit Converter',
        home: CategoryRoute());
  }
}
