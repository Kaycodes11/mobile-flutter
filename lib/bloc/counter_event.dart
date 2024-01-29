part of "counter_bloc.dart";

// to not allow CounterEvent to be instantiated outside
sealed class CounterEvent {}

// N.B: used final to disallow these two classes from being instantiated elsewhere other than this file
final class CounterIncremented extends CounterEvent {}

final class CounterDecremented extends CounterEvent {}
