
import 'package:rxdart/rxdart.dart';

// Data Model
class CategoryBloc {
  BehaviorSubject _counter = new BehaviorSubject<int>.seeded(1);
  // ignore: close_sinks
  BehaviorSubject _textChanger = new BehaviorSubject<String>.seeded("Hello Text");

  Observable get stream$ => _counter.stream;
  Observable get streamTextChange$ => _textChanger.stream;
  int get current => _counter.value;

  String get currentText => _textChanger.value;

  increment() {
    _counter.add(current + 1);
  }

  changeText(String text) {
    _counter.add(text);
  }
}
