import 'package:flutter_bloc/flutter_bloc.dart';

// instead of using "import" , use part to mention as below for event i.e. CounterEvent
part "counter_event.dart";

class CounterBloc extends Bloc<CounterEvent, int> {
  // necessary argument for main class -> super(given hard-coded value from here)
  CounterBloc() : super(0) {
    // so, whenever CounterIncremented() instantiated anywhere by any consuming widget; then it'll run the below code -> then how those listening/subscribed widgets handle the changes by e.g. BlocBuilder etc.
    on<CounterIncremented>((event, emit) {
      // the value given to super() is what available on state; which is why here incremented state + 1
      emit(state + 1);
    });

    on<CounterDecremented>((event, emit) {
      if (state > 0) emit(state - 1);
    });
  }
}
