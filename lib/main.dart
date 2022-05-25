import 'package:flutter/material.dart';
import 'FoodMenu.dart';
import 'MoneyBox.dart';

void main() {
  var app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "บัญชีของฉัน",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              MoneyBox("ยอดคงเหลือ", 15000.75, Colors.blue, 150),
              SizedBox(height: 5,),
              MoneyBox("รายรับ", 45000.75, Colors.green, 100),
              SizedBox(height: 5,),
              MoneyBox("รายจ่าย", 30000.75, Colors.red, 100),
              SizedBox(height: 5,),
              MoneyBox("ยอดค้างชำระ", 5000.75, Colors.orange, 100),
            ],
          ),
        ));
  }
}
