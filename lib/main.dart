import 'package:flutter/material.dart';
import 'FoodMenu.dart';
import 'MoneyBox.dart';
import 'package:http/http.dart' as http;
import 'ExchangeRate.dart';

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
  ExchangeRate? _dataFromAPI;

  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  Future<ExchangeRate> getExchangeRate() async {
    var url = Uri.parse('https://api.exchangerate-api.com/v4/latest/THB');
    var response = await http.get(url);
    _dataFromAPI = exchangeRateFromJson(response.body);
    return _dataFromAPI!;
  }

  @override
  Widget build(BuildContext context) {
    print("เรียกใช้งาน build");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "อัตราการแลกเปลี่ยนสกุลเงิน",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getExchangeRate(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var result = snapshot.data;
            double amount = 100;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MoneyBox("สกุลเงิน ( THB )", amount, Colors.blue, 150),
                  SizedBox(height: 5,),
                  MoneyBox("EUR", amount*result.rates["EUR"], Colors.red, 100),
                  SizedBox(height: 5,),
                  MoneyBox("USD", amount*result.rates["USD"], Colors.green, 100),
                  SizedBox(height: 5,),
                  MoneyBox("GBP", amount*result.rates["GBP"], Colors.pink, 100),
                  SizedBox(height: 5,),
                  MoneyBox("JPY", amount*result.rates["JPY"], Colors.orange, 100),
                ],
              ),
            );
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }
}
