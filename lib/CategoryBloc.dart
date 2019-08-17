import 'dart:async';
import 'CategoryEvent.dart';

import 'package:rxdart/rxdart.dart';

// Global Variable
//CategoryBloc counterService = CategoryBloc();

// Data Model
class  CategoryBloc{

  BehaviorSubject _counter = new BehaviorSubject<int>.seeded(1);

  Observable get stream$ => _counter.stream;
  int get current => _counter.value;

  increment() {
    _counter.add(current + 1);
  }

}
