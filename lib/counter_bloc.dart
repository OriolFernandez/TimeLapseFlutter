import 'dart:async';
import 'counter_event.dart';
// https://www.youtube.com/watch?v=oxeYeMHVLII
// https://resocoder.com/2019/01/05/flutter-bloc-pattern-tutorial-from-scratch/
class CounterBloc {
  int _counter = 0;

  final _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink;

  Stream<int> get counter => _counterStateController.stream;
  final _counterEventController = StreamController<CounterEvent>();

  Sink<CounterEvent> get counterEvent => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
