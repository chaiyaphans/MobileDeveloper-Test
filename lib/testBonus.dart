import 'package:flutter/material.dart';

class TestBonus extends StatefulWidget {
  @override
  _TestBonusState createState() => _TestBonusState();
}

class _TestBonusState extends State<TestBonus> {
  final TextEditingController _fiboNumberController = TextEditingController();
  final TextEditingController _primeNumberController = TextEditingController();
  String fibonanciListText = "";
  String primeNumberListText = "";
  bool enablebuttonFibo = false;
  bool enablebuttonPrime = false;
  List<int> _fibonanciList = [];
  @override
  void initState() {
    enablebuttonFibo = false;
    enablebuttonPrime = false;
    super.initState();
  }

  int fibonacci(int num) {
    if (num <= 2) {
      return 1;
    } else {
      return fibonacci(num - 1) + fibonacci(num - 2);
    }
  }

  void fibonaccitext(List<int> fibonanciList) {
    fibonanciListText = "";
    for (int i = 0; i < fibonanciList.length; i++) {
      setState(() {
        if (i == 0) {
          fibonanciListText += fibonanciList[i].toString();
        } else {
          fibonanciListText += "," + fibonanciList[i].toString();
        }
      });
    }
    //return fibonanciListText;
  }

  void fibonacciList(int number) {
    _fibonanciList = [];
    if (number == 0) {
      setState(() {
        _fibonanciList = [0];
      });
    } else if (number == 1) {
      setState(() {
        _fibonanciList = [0, 1];
      });
    } else if (number > 1) {
      _fibonanciList = [0, 1];
      for (int i = 2; i <= number; i++) {
        setState(() {
          _fibonanciList.add(fibonacci(i));
        });
      }
    }
  }

  bool isPrime(int n) {
    if (n == 1 || n == 0) {
      return false;
    }
    for (int i = 2; i < n; i++) {
      if (n % i == 0) {
        return false;
      }
    }
    return true;
  }

  void generatePrimeNumber(int n) {
    primeNumberListText = "";
    for (int i = 1; i <= n; i++) {
      //check if current number is prime
      if (isPrime(i)) {
        //   Console.Write(i + " ");
        if (i == 2) {
          setState(() {
            primeNumberListText += i.toString();
          });
        } else {
          setState(() {
            primeNumberListText += "," + i.toString();
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Bonus Test"),
        SizedBox(height: 5),
        Column(
          children: [
            Text("เขียน program generate ตัวเลข Fibonacci"),
            SizedBox(height: 5),
            Container(
              // height: 30,
              width: 100,
              child: TextFormField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical(y: 1.0),
                keyboardType: TextInputType.number,
                controller: _fiboNumberController,
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
                  if (text != "") {
                    setState(() {
                      enablebuttonFibo = true;
                    });
                  } else {
                    setState(() {
                      enablebuttonFibo = false;
                    });
                  }
                },
              ),
            ),
            TextButton(
                onPressed: enablebuttonFibo
                    ? () {
                        fibonacciList(int.parse(_fiboNumberController.text));
                        fibonaccitext(_fibonanciList);
                      }
                    : null,
                child: Text("Generate Fibonacci")),
            Container(
              width: 300,
              child: Text(
                "Fibonacci Number = " + fibonanciListText,
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
        Text("-------------------------------------------------------------------"),
        Column(
          children: [
            Text("เขียน program generate จำนวนเฉพาะ"),
            SizedBox(height: 5),
            Container(
              // height: 30,
              width: 100,
              child: TextFormField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical(y: 1.0),
                keyboardType: TextInputType.number,
                controller: _primeNumberController,
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
                  if (text != "") {
                    setState(() {
                      enablebuttonPrime = true;
                    });
                  } else {
                    setState(() {
                      enablebuttonPrime = false;
                    });
                  }
                },
              ),
            ),
            TextButton(
                onPressed: enablebuttonPrime
                    ? () {
                        generatePrimeNumber(int.parse(_primeNumberController.text));
                      }
                    : null,
                child: Text("Generate Prime Number")),
            Container(
              width: 300,
              child: Text(
                "Prime Number = " + primeNumberListText,
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
        Text("-------------------------------------------------------------------"),
      ],
    );
  }
}
