import 'dart:async';
import 'dart:convert';

import 'model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Account> fetchAlbum() async {
  var url;
  if (_MyAppState.selectedIndex == 0) {
    url = Uri.parse(
        'https://angular-argon-331323-default-rtdb.firebaseio.com/house.json');
  } else {
    url = Uri.parse(
        'https://angular-argon-331323-default-rtdb.firebaseio.com/debt.json');
  }
  final response = await http.get(url);
  return Account.fromJson(jsonDecode(response.body));
}

Future<Rate> localgetcourse() async {
  final response = await http.get(Uri.parse(
      'https://angular-argon-331323-default-rtdb.firebaseio.com/course.json'));
  return Rate.fromJson(jsonDecode(response.body));
}

updateAlbum(double text1, double text2, double text3, double text4,
    double text5, double text6, double text7) async {
  var url;
  if (_MyAppState.selectedIndex == 0) {
    url = Uri.parse(
        'https://angular-argon-331323-default-rtdb.firebaseio.com/house.json');
  } else {
    url = Uri.parse(
        'https://angular-argon-331323-default-rtdb.firebaseio.com/debt.json');
  }
  await http.patch(
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
      "USD": text6,
      "TRY": text7
    }),
  );
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
  final TextEditingController controller7 = TextEditingController();
  late Future<Account> futureAccount;
  late Future<Rate> futureRate;
  Widget ratetr() {
    if (localratetry == null) {
      return const CircularProgressIndicator();
    } else {
      return Text(localratetry.toStringAsFixed(2));
    }
  }

  Widget ratepl() {
    if (localratepln == null) {
      return const CircularProgressIndicator();
    } else {
      return Text(localratepln.toStringAsFixed(2));
    }
  }

  Widget rateus() {
    if (localrateusd == null) {
      return const CircularProgressIndicator();
    } else {
      return Text(localrateusd.toStringAsFixed(2));
    }
  }

  Widget rateru() {
    if (localraterub == null) {
      return const CircularProgressIndicator();
    } else {
      return Text(localraterub.toStringAsFixed(2));
    }
  }

  Widget ratekz() {
    if (localratekzt == null) {
      return const CircularProgressIndicator();
    } else {
      return Text(localratekzt.toStringAsFixed(2));
    }
  }

  Widget ratecz() {
    if (localrateczk == null) {
      return const CircularProgressIndicator();
    } else {
      return Text(localrateczk.toStringAsFixed(2));
    }
  }

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
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text("PLN: $text1 / RATE: "),
            ratepl(),
          ]),
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text("RUB: $text3 / RATE: "),
            rateru(),
          ]),
          TextField(
            controller: controller3,
            decoration: const InputDecoration(
              hintText: 'Enter RUB Value',
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text("CZK: $text4 / RATE: "),
            ratecz(),
          ]),
          TextField(
            controller: controller4,
            decoration: const InputDecoration(
              hintText: 'Enter CZK Value',
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text("KZT: $text5 / RATE: "),
            ratekz(),
          ]),
          TextField(
            controller: controller5,
            decoration: const InputDecoration(
              hintText: 'Enter KZT Value',
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text("USD: $text6 / RATE: "),
            rateus(),
          ]),
          TextField(
            controller: controller6,
            decoration: const InputDecoration(
              hintText: 'Enter USD Value',
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text("TRY: $text7 / RATE: "),
            ratetr(),
          ]),
          TextField(
            controller: controller7,
            decoration: const InputDecoration(
              hintText: 'Enter TRY Value',
            ),
          ),
        ],
      );
    }
  }

  var text1, text2, text3, text4, text5, text6, text7;
  var sum;
  var localrateczk,
      localratepln,
      localraterub,
      localratekzt,
      localrateusd,
      localratetry;
  void account() async {
    var data7 = await fetchAlbum();
    var data8 = await localgetcourse();

    setState(() {
      text1 = data7.pln;
      text2 = data7.eur;
      text3 = data7.rub;
      text4 = data7.czk;
      text5 = data7.kzt;
      text6 = data7.usd;
      text7 = data7.trl;
      localrateczk = data8.rateczk;
      localratepln = data8.ratepln;
      localraterub = data8.raterub;
      localratekzt = data8.ratekzt;
      localrateusd = data8.rateusd;
      localratetry = data8.ratetry;
      sum = text1 / localratepln +
          text2 +
          text3 / localraterub +
          text4 / localrateczk +
          text5 / localratekzt +
          text6 / localrateusd +
          text7 / localratetry;
      sum = double.parse((sum).toStringAsFixed(2));
    });
  }

  void update(double text1, double text2, double text3, double text4,
      double text5, double text6, double text7) async {
    await updateAlbum(text1, text2, text3, text4, text5, text6, text7);
    setState(() {
      account();
    });
  }

  static int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      account();
    });
  }

  @override
  void initState() {
    super.initState();
    account();
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
                        if (controller7.text != '') {
                          text7 = double.parse(controller7.text);
                        }
                        setState(() {
                          update(
                              text1, text2, text3, text4, text5, text6, text7);
                        });
                      },
                      child: const Text('Update Data'),
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
