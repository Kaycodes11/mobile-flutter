import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  CurrencyConverterMaterialPage({super.key}) {
    print("constructor called from Currency_Converter_Material_Page ");
  }

  // State createState() => State();
  @override
  State<CurrencyConverterMaterialPage> createState() {
    print("createState entered");
    return _CurrencyConverterMaterialPageState();
  }
}

// _ prefix means this is a private class (so it won't be accessible outside of this file)
class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  /*
  # Widget lifecycle of "Stateful widget":
  1. wherever this class being used e.g. CurrencyConverterMaterialPage : that class's constructor
  2. createState() of that class where this class being instantiated e.g. CurrencyConverterMaterialPage
  3. now this class e.g. _CurrencyConverterMaterialPage's initState (put the code that needs to run before build method)

   */

  // @override
  // void initState() {
  //   super.initState();
  //   print("Run code before it goes to build method e.g. async");
  // }

  void convert() {
    result = double.parse(textEditingController.text) * 80;
    setState(() {});
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(width: 2.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(5));

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: const Text('Currency Converter'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'INR ${result != 0 ? result.toStringAsFixed(3) : result.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              TextField(
                controller: textEditingController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Please enter the amount in USD',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  prefixIconColor: Colors.black,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: convert,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text('Convert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyConverterMaterialPagee extends StatelessWidget {
  const CurrencyConverterMaterialPagee({super.key});

  // BuildContext tells Flutter the location of this widget i.e. CurrencyConvertedMaterialPage (or any widget) in `WidgetTree`
  // Every widget will have this context property (here CurrencyConvertedMaterialPage, Text)

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(width: 2.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(5));

    // const used create compile-time constraints *which tells compiler that it doesn't depend on any `runtime variables` and can be calculated/determined at "compile-time"

    // N.B: if not using return const, then can use individually, const TextStyle, const Icon etc.

    // 1. So this widget could pre-computed at "compile-time" thus making the app more efficient

    // 2. in case of StatelessWidget (i.e. immutable), using const prevent from re-initializing from outside (which is a good practice)

    // N.B: here didn't use return since some Widgets has runtime computation (border) while other compile-time computation so added like below

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                // color: Colors.black,
                // height: 400,
                // width: 300,
                child: const Text(
                  "0",
                  style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Please, enter the amount in USD",
                    hintStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                    prefixIconColor: Colors.black,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (kDebugMode) {
                    print("button clicked");
                  }
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    minimumSize:
                        MaterialStatePropertyAll(Size(double.infinity, 50))),
                child: const Text("Convert"),
              )
            ],
          ),
        ));
  }
}
