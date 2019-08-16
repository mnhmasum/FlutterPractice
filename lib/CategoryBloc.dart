import 'dart:async';
import 'package:bloc/bloc.dart';

enum CategoryEvent { increment, decrement } // 1

class CategoryBloc extends Bloc<CategoryEvent, int> {
  int initVal = 10;



  setMyVal(int val) {
    this.initVal = val;
    //currentState = val;
  }


  @override
  void onTransition(Transition<CategoryEvent, int> transition) {
    print(transition);
  }

  @override
  int get initialState => initVal;

  @override
  Stream<int> mapEventToState(CategoryEvent event) async* {
    switch (event) {
      case CategoryEvent.decrement:
        yield currentState - 1;
        break;
      case CategoryEvent.increment:
        yield currentState + initVal;
        break;
    }
  }
}

class CategoryBloc1 extends Bloc<CategoryEvent, double> {
  double initVal = 10;

  setMyVal(double val) {
    this.initVal = val;
    //currentState = val;
  }

  @override
  double get initialState => initVal;

  @override
  Stream<double> mapEventToState(CategoryEvent event) async* {
    switch (event) {
      case CategoryEvent.decrement:
        yield currentState - 1;
        break;
      case CategoryEvent.increment:
        yield currentState + initVal;
        break;
    }
  }
}