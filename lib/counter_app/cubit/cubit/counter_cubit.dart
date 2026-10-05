import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  var count = 0;

  void increment() {
    count++;
    emit(CounterTextIncrement());
  }

  void decrement() {
    count--;
    emit(CounterTextDecrement());
  }
}
