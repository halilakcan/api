import 'dart:async';
import 'dart:convert';

import 'model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  var url;
  if (_MyAppState.selectedIndex == 0) {
    url = Uri.parse(
        'https://angular-argon-331323-default-rtdb.firebaseio.com/house.json');
  } else {
    url = Uri.parse(
        'https://angular-argon-331323-default-rtdb.firebaseio.com/debt.json');
  }
  final response = await http.get(url);
  return Album.fromJson(jsonDecode(response.body));
}

getratepln() async {
  final response = await http.get(Uri.parse(
      'https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=EUR&to_currency=PLN&apikey=7UK1NW1UZ8NZQT07'));
  return jsonDecode(response.body);
}

getraterub() async {
  final response = await http.get(Uri.parse(
      'https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=EUR&to_currency=RUB&apikey=7UK1NW1UZ8NZQT07'));
  return jsonDecode(response.body);
}

getrateczk() async {
  final response = await http.get(Uri.parse(
      'https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=EUR&to_currency=CZK&apikey=7UK1NW1UZ8NZQT07'));
  return jsonDecode(response.body);
}

getratekzt() async {
  final response = await http.get(Uri.parse(
      'https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=EUR&to_currency=KZT&apikey=7UK1NW1UZ8NZQT07'));
  return jsonDecode(response.body);
}

getrateusd() async {
  final response = await http.get(Uri.parse(
      'https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=EUR&to_currency=USD&apikey=7UK1NW1UZ8NZQT07'));
  return jsonDecode(response.body);
}

Future<Album> updateAlbum(double text1, double text2, double text3,
    double text4, double text5, double text6) async {
  var url;
  if (_MyAppState.selectedIndex == 0) {
    url = Uri.parse(
        'https://angular-argon-331323-default-rtdb.firebaseio.com/house.json');
  } else {
    url = Uri.parse(
        'https://angular-argon-331323-default-rtdb.firebaseio.com/debt.json');
  }
  final response = await http.patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, double>{
      "PLN": text1,
      "EUR": text2,
      "RUB": text3,
      "CZK": text4,
      "KZT": text5,
      "USD": text6
    }),
  );
  return Album.fromJson(jsonDecode(response.body));
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  createState() => _MyAppState();
}

class _MyAppState extends State {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();
  late Future<Album> futureAlbum;
  Widget total() {
    if (sum == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text("SUM: "), CircularProgressIndicator()],
      );
    } else {
      return Text("SUM: $sum€");
    }
  }

  Widget list() {
    if (text1 == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [CircularProgressIndicator()],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("PLN: $text1"),
          TextField(
            controller: controller1,
            decoration: const InputDecoration(
              hintText: 'Enter PLN Value',
            ),
          ),
          Text("EUR: $text2"),
          TextField(
            controller: controller2,
            decoration: const InputDecoration(
              hintText: 'Enter EUR Value',
            ),
          ),
          Text("RUB: $text3"),
          TextField(
            controller: controller3,
            decoration: const InputDecoration(
              hintText: 'Enter RUB Value',
            ),
          ),
          Text("CZK: $text4"),
          TextField(
            controller: controller4,
            decoration: const InputDecoration(
              hintText: 'Enter CZK Value',
            ),
          ),
          Text("KZT: $text5"),
          TextField(
            controller: controller5,
            decoration: const InputDecoration(
              hintText: 'Enter KZT Value',
            ),
          ),
          Text("USD: $text6"),
          TextField(
            controller: controller6,
            decoration: const InputDecoration(
              hintText: 'Enter USD Value',
            ),
          ),
        ],
      );
    }
  }

  var text1, text2, text3, text4, text5, text6;
  var rateczk, ratepln, raterub, ratekzt, rateusd, sum;
  void account() async {
    var data6 = await fetchAlbum();
    setState(() {
      text1 = data6.pln;
      text2 = data6.eur;
      text3 = data6.rub;
      text4 = data6.czk;
      text5 = data6.kzt;
      text6 = data6.usd;
    });
  }

  void update(double text1, double text2, double text3, double text4,
      double text5, double text6) async {
    await updateAlbum(text1, text2, text3, text4, text5, text6);
    setState(() {
      account();
    });
  }

  void summation() async {
    var data1 = await getratepln();
    var data2 = await getraterub();
    var data3 = await getrateczk();
    var data4 = await getratekzt();
    var data5 = await getrateusd();

    setState(() {
      ratepln = double.parse(
          data1["Realtime Currency Exchange Rate"]["5. Exchange Rate"]);
      raterub = double.parse(
          data2["Realtime Currency Exchange Rate"]["5. Exchange Rate"]);
      rateczk = double.parse(
          data3["Realtime Currency Exchange Rate"]["5. Exchange Rate"]);
      ratekzt = double.parse(
          data4["Realtime Currency Exchange Rate"]["5. Exchange Rate"]);
      rateusd = double.parse(
          data5["Realtime Currency Exchange Rate"]["5. Exchange Rate"]);

      sum = text1 / ratepln +
          text2 +
          text3 / raterub +
          text4 / rateczk +
          text5 / ratekzt +
          text6 / rateusd;
      sum = double.parse((sum).toStringAsFixed(2));
    });
  }

  static int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    account();
    summation();
  }

  @override
  build(context) {
    return MaterialApp(
      title: 'Akcan House Investment',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Financial Status and Home Investment'),
        ),
        body: DefaultTextStyle(
          style: Theme.of(context).textTheme.headline4!,
          textAlign: TextAlign.center,
          child: Center(
            child: ListView(
              children: [
                total(),
                list(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (controller1.text != '') {
                          text1 = double.parse(controller1.text);
                        }
                        if (controller2.text != '') {
                          text2 = double.parse(controller2.text);
                        }
                        if (controller3.text != '') {
                          text3 = double.parse(controller3.text);
                        }
                        if (controller4.text != '') {
                          text4 = double.parse(controller4.text);
                        }
                        if (controller5.text != '') {
                          text5 = double.parse(controller5.text);
                        }
                        if (controller6.text != '') {
                          text6 = double.parse(controller6.text);
                        }
                        setState(() {
                          update(text1, text2, text3, text4, text5, text6);
                          summation();
                        });
                      },
                      child: const Text('Update Data'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          account();
                          summation();
                        });
                      },
                      child: const Text('Update Page'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: 'Investment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.outbound),
              label: 'Loans',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.amber,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
