import 'dart:async';
import 'package:bloc/bloc.dart';

enum CategoryEvent { increment } // 1

class CategoryBloc extends Bloc<CategoryEvent, int> { // 2
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CategoryEvent event, int currentState) async* {
    switch (event) {
      case CategoryEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}