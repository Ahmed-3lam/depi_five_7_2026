part of 'counter_cubit.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterTextIncrement extends CounterState {}
class CounterTextDecrement extends CounterState {}
