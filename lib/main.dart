import 'package:flutter/material.dart';
import 'CategoryBloc.dart';
import 'CategoryScreen.dart';

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
        title: 'Bangla Dictionary',
        home: CategoryScreen());
  }
}
