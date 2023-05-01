import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'currency_rate.dart';

class Test1 extends StatefulWidget {
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _containerController = TextEditingController();

  FocusNode _focusNodeContainer = FocusNode();
  ScrollController _scrollController = ScrollController();
  List<String> currencyListDD = <String>["USD", "GBP", "EUR"];
  CurrencyRateModel currencyRateData = CurrencyRateModel();
  Bpi currencyTypeData = Bpi();

  String currencyRateSelected = "";
  double _BTCCalculate = 0.00;
  final TextEditingController _qtyController = TextEditingController();
  @override
  @override
  void initState() {
    getDataBTC();
    super.initState();
  }

  Future<void> getDataBTC() async {
    final url = Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        currencyRateData = currencyRateFromJson(response.body);
        currencyTypeData = currencyRateData.bpi!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
        const Duration(seconds: 60),
        (Timer t) => setState(() {
              getDataBTC();
            }));

    void calculateBTC(String calculateTypeSelected, double qty) {
      if (calculateTypeSelected.contains("USD")) {
        setState(() {
          _BTCCalculate = qty / double.parse(currencyTypeData.usd?.rateFloat.toString() ?? "");
        });
      } else if (calculateTypeSelected.contains("GBP")) {
        setState(() {
          _BTCCalculate = qty / double.parse(currencyTypeData.gbp?.rateFloat.toString() ?? "");
        });
      } else {
        setState(() {
          _BTCCalculate = qty / double.parse(currencyTypeData.eur?.rateFloat.toString() ?? "");
        });
      }
    }

    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Currency Exchange"),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "BTC =",
                style: TextStyle(fontSize: 24, color: Colors.orange),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                _BTCCalculate.toString(),
                style: TextStyle(fontSize: 20, color: Colors.green),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: DropdownButtonFormField(
            items: currencyListDD
                .map(
                  (String val) => DropdownMenuItem<String>(
                    value: val,
                    child: Text(
                      val,
                    ),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              setState(() {
                currencyRateSelected = value!;
                if (_qtyController.text != "") {
                  calculateBTC(currencyRateSelected, double.parse(_qtyController.text));
                }

                // damageList[i].vesselHold = vesselHoldSelected;
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 1),
              isDense: true,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          enabled: (currencyRateSelected != "") ? true : false,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical(y: 1.0),
          keyboardType: TextInputType.number,
          controller: _qtyController,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 24),
          decoration: InputDecoration(
            counterText: "",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.orange,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.orange,
              ),
            ),
          ),
          onChanged: (text) {
            calculateBTC(currencyRateSelected, double.parse(text));
          },
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "USD RATE =",
                style: TextStyle(fontSize: 18, color: Colors.orange),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                currencyTypeData.usd?.rate ?? "",
                style: TextStyle(fontSize: 18, color: Colors.green),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "GBP RATE =",
                style: TextStyle(fontSize: 18, color: Colors.orange),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                currencyTypeData.gbp?.rate ?? "",
                style: TextStyle(fontSize: 18, color: Colors.green),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "EUR RATE =",
                style: TextStyle(fontSize: 18, color: Colors.orange),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                currencyTypeData.eur?.rate ?? "",
                style: TextStyle(fontSize: 18, color: Colors.green),
              )
            ],
          ),
        ),
      ],
    );
  }
}
