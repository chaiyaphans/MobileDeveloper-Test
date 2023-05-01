import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/test1.dart';
import 'package:test1/test2.dart';
import 'package:test1/testBonus.dart';
import 'currency_rate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Mobile Developer Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<String> currencyListDD = <String>["USD", "GBP", "EUR"];
  // CurrencyRateModel currencyRateData = CurrencyRateModel();
  // Bpi currencyTypeData = Bpi();

  // String currencyRateSelected = "";
  // double _BTCCalculate = 0.00;
  // final TextEditingController _qtyController = TextEditingController();

  @override
  void initState() {
    //getDataBTC();
    super.initState();
  }

  // Future<void> getDataBTC() async {
  //   final url = Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json");
  //   http.Response response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       currencyRateData = currencyRateFromJson(response.body);
  //       currencyTypeData = currencyRateData.bpi!;
  //     });
  //   }
  // }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                  ),
                ),
                child: Test1(),
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                  ),
                ),
                child: TestBonus(),
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                  ),
                ),
                child: Test2(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
