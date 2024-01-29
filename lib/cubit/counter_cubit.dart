import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  // here parent class i.e. Cubit and its contractor requires a single argument of "dynamic type" which is what done below
  CounterCubit() : super(0); // type given to Cubit<T = int>
  void increment() {
    // state is getter property so can't do state = state + 1; and so use "emit" and as emitted; it will notify all the listening widgets
    // N.B: emit will notify to all of its consumer widgets for the value changes and it's up to the "consuming widgets how to listen to these value changes"
    emit(state + 1);
  }

  void decrement() {
    // N.B: emit will notify to all of its consumer widgets for the value changes and it's up to the "consuming widgets how to listen to these value changes"
    // emit has protected accessor so it could by main and derived classes but not outside (wherever instantiating)
    if (state > 0) emit(state - 1);
    // print("after: $state");
  }
}
