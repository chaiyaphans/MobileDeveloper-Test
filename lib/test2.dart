import 'package:flutter/material.dart';

class Test2 extends StatefulWidget {
  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  final TextEditingController _pinCodeController = TextEditingController();
  String inputPin = "";
  List<int> inputPinList = [];

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    inputPin = "";
    inputPinList = [];

    super.initState();
  }

  String validatePincode(String str) {
    inputPinList = [];
    int a = int.parse(str);

    while (a > 0) {
      inputPinList.add(a % 10);
      a = (a / 10).floor();
      inputPinList.sort();
      // print(inputPinList);
    }
    if (a == 0) {
      int countDuplicate = 0;
      int countSequential = 0;
      int countSequential2 = 0;
      for (int i = 1; i < inputPinList.length; i++) {
        if (inputPinList[i] == inputPinList[i - 1]) {
          countDuplicate++;
          if (countDuplicate > 2) {
            setState(() {
              print("duplicate");
            });
            return 'input จะต้องกันไม่ให้มีเลขซ้ำติดกันเกิน 2 ตัว \n และ input จะต้องกันไม่ให้มีเลขชุดซ้ำ เกิน 2 ชุด';
          }
        } else if (((inputPinList[i]) - (inputPinList[i - 1]) == 1)) {
          countSequential++;
          if (countSequential > 2) {
            setState(() {
              print("sequential");
            });
            return "input จะต้องกันไม่ให้มีเลขเรียงกันเกิน 2 ตัว";
          }
        } else if ((inputPinList[i - 1]) - (inputPinList[i]) == 1) {
          countSequential2++;
          if (countSequential2 > 2) {
            setState(() {
              print("Sequential2");
            });
            return "input จะต้องกันไม่ให้มีเลขเรียงกันเกิน 2 ตัว";
          }
        }
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text("จงเขียนฟังก์ชัน validate pincode"),
          SizedBox(height: 5),
          TextFormField(
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical(y: 1.0),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'โปรดระบุ Input';
              } else if (value.length < 6) {
                return 'Input จะต้องมีความยาวมากกว่าหรือเท่ากับ 6 ตัวอักษร';
              } else {
                return validatePincode(value) == '' ? null : validatePincode(value);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('validate pincode ถูกต้อง')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
