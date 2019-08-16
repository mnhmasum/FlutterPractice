import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CategoryBloc.dart';
import 'CategoryRoute.dart';

void main() => runApp(UnitConverterApp());

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      home: BlocProvider(  // 3
        builder:   (context)=> CategoryBloc(),
        child: CategoryRoute()
      ),
    );
  }
}



//https://fireship.io/lessons/flutter-state-management-guide/

