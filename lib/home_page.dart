import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/counter_bloc.dart';
// import 'package:flutter_application_1/cubit/counter_cubit.dart';
import 'package:flutter_application_1/inc_dec_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  /*
    * Here's how it works: and why put counter within "build method" ↓
    *
    * The floatingActionButton triggers counterCubit.increment() when pressed.
    * The CounterCubit updates its state.
    * BlocBuilder listens to these state changes and triggers a rebuild of its builder function.
    * Inside the builder function, you now declare final counter = counterCubit.state;. This ensures counter reflects the latest state.
    * The widget tree under BlocBuilder gets rebuilt with the updated counter value.
    * */
  @override
  Widget build(BuildContext context) {
    // final counterCubit = BlocProvider.of<CounterCubit>(context);
    final counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("You have pushed the button this many times"),
            // now whenever counter updates, BlocBuilder will make "only build method re-run which is why counter initialized within `build method`" and now only the widget that uses value from counter will update, not the entire Scaffold
            BlocBuilder<CounterBloc, int>(
                // when specified CounterBloc, then below "bloc property could be optional" and "bloc is needed if there's no provider at main.dart and only instantiated on this widget"
                // N.B: it will go up the "WidgetTree" and find a provider that returns "counterBloc"
                bloc: counterBloc,
                builder: (context, counter) {
                  return Text("$counter",
                      style: Theme.of(context).textTheme.headlineMedium);
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const IncDecPage()));
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
