import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:sandvich/brain/calc.dart';
import 'package:sandvich/model/stats.dart';
import 'package:sandvich/widget/edit_field.dart';

Box savedData;

class CalculatorApp extends StatefulWidget {
  static String route = '/calc';
  static String title = 'Calculator';

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  Future<Calculator> calculatorFuture;

  Calculator calculator;
  final keyController = TextEditingController();
  final refController = TextEditingController();
  final monController = TextEditingController();
  FocusNode _keyfocus = FocusNode();
  FocusNode _reffocus = FocusNode();
  FocusNode _monfocus = FocusNode();

  @override
  void initState() {
    super.initState();
    getSavedCalculator()
        .then((value) => {calculator = value})
        .catchError((e) => calculator = Calculator(0, 0));
    getCalculator()
        .then((value) => {calculator = value})
        .catchError((e) => calculator = Calculator(0, 0));
    keyController.addListener(() {
      if (keyController.text.isNotEmpty && _keyfocus.hasFocus) {
        refController.text = calculator.keyToRefined(keyController.text);
        monController.text = calculator.keysToMoney(keyController.text);
      }
    });
    refController.addListener(() {
      if (refController.text.isNotEmpty && _reffocus.hasFocus) {
        keyController.text = calculator.refinedToKeys(refController.text);
        monController.text = calculator.refinedToMoney(refController.text);
      }
    });
    monController.addListener(() {
      if (monController.text.isNotEmpty && _monfocus.hasFocus) {
        keyController.text = calculator.moneyToKeys(monController.text);
        refController.text = calculator.moneyToRefined(monController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CalculatorApp.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              setState(() {
                getCalculator()
                    .then((value) => {calculator = value})
                    .catchError((e) => calculator = Calculator(0, 0));
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            EditField(
              "Key",
              Icons.vpn_key_rounded,
              keyController,
              _keyfocus,
            ),
            EditField(
              "Ref",
              Icons.settings,
              refController,
              _reffocus,
            ),
            EditField(
              "USD",
              Icons.attach_money_rounded,
              monController,
              _monfocus,
            ),
          ],
        ),
      ),
    );
  }
}

Stats parseStats(String responseBody) {
  final parsed = json.decode(responseBody);
  return Stats.fromJson(parsed);
}

Future<Calculator> getSavedCalculator() async {
  var keyPrice = savedData.get('key_price');
  var refPrice = savedData.get('ref_price');
  return Calculator(keyPrice, refPrice);
}

Future<Calculator> getCalculator() async {
  savedData = await Hive.openBox('saved');
  Stats stats = await fetchStats();
  var keyPrice = double.parse(stats.bptfKeyPrice.split(" ")[0]);
  var refPrice = double.parse(stats.bptfRefPrice.split(" ")[0]);
  savedData.put('key_price', keyPrice);
  savedData.put('ref_price', refPrice);
  // TODO: When offline use saved prices
  return Calculator(keyPrice, refPrice);
}

Future<Stats> fetchStats() async {
  final response = await http.get('https://ksyko.duckdns.org/stats.json');
  if (response.statusCode == 200) {
    return compute(parseStats, response.body);
  } else {
    throw Exception('Failed to load feed');
  }
}
