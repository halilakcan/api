import 'dart:async';
import 'dart:convert';
import 'model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse(
      'https://angular-argon-331323-default-rtdb.firebaseio.com/house.json'));
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

Future<Album> updateAlbum(double text1, double text2, double text3,
    double text4, double text5) async {
  final response = await http.patch(
    Uri.parse(
        'https://angular-argon-331323-default-rtdb.firebaseio.com/house.json'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, double>{
      "PLN": text1,
      "EUR": text2,
      "RUB": text3,
      "CZK": text4,
      "KZT": text5
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
  late Future<Album> futureAlbum;
 Widget total(){if(sum==null) {return const CircularProgressIndicator();} else {return Text("TOTAL EUR: $sum"); }}

  var text1, text2, text3, text4, text5;
  var rateczk, ratepln, raterub, ratekzt,sum;
  void func() async {
    var data1 = await getratepln();
    var data2 = await getraterub();
    var data3 = await getrateczk();
    var data4 = await getratekzt();
    var data5 = await fetchAlbum();
    setState(() {
      ratepln = double.parse(data1["Realtime Currency Exchange Rate"]["5. Exchange Rate"]);
      raterub = double.parse(data2["Realtime Currency Exchange Rate"]["5. Exchange Rate"]);
      rateczk = double.parse(data3["Realtime Currency Exchange Rate"]["5. Exchange Rate"]);
      ratekzt = double.parse(data4["Realtime Currency Exchange Rate"]["5. Exchange Rate"]);
      text1=data5.pln;
      text2=data5.eur;
      text3=data5.rub;
      text4=data5.czk;
      text5=data5.kzt;
      sum=text1/ratepln+text2+text3/raterub+text4/rateczk+text5/ratekzt;
      sum=double.parse((sum).toStringAsFixed(2));
    });
  }


  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    func();
  }

  @override
  build(context) {
    return MaterialApp(
      title: 'Akcan House Investment',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home Investment'),
        ),
        body: DefaultTextStyle(
          style: Theme.of(context).textTheme.headline2!,
          textAlign: TextAlign.center,
          child: Center(
            child: Column(
              children: [
                total(),
                FutureBuilder<Album>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("PLN: ${snapshot.data!.pln}"),
                            TextField(
                              controller: controller1,
                              decoration: const InputDecoration(
                                hintText: 'Enter PLN Value',
                              ),
                            ),
                            Text("EUR: ${snapshot.data!.eur}"),
                            TextField(
                              controller: controller2,
                              decoration: const InputDecoration(
                                hintText: 'Enter EUR Value',
                              ),
                            ),
                            Text("RUB: ${snapshot.data!.rub}"),
                            TextField(
                              controller: controller3,
                              decoration: const InputDecoration(
                                hintText: 'Enter RUB Value',
                              ),
                            ),
                            Text("CZK: ${snapshot.data!.czk}"),
                            TextField(
                              controller: controller4,
                              decoration: const InputDecoration(
                                hintText: 'Enter CZK Value',
                              ),
                            ),
                            Text("KZT: ${snapshot.data!.kzt}"),
                            TextField(
                              controller: controller5,
                              decoration: const InputDecoration(
                                hintText: 'Enter KZT Value',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (controller1.text == '') {
                                  text1 = snapshot.data!.pln;
                                } else {
                                  text1 = double.parse(controller1.text);
                                }
                                if (controller2.text == '') {
                                  text2 = snapshot.data!.eur;
                                } else {
                                  text2 = double.parse(controller2.text);
                                }
                                if (controller3.text == '') {
                                  text3 = snapshot.data!.rub;
                                } else {
                                  text3 = double.parse(controller3.text);
                                }
                                if (controller4.text == '') {
                                  text4 = snapshot.data!.czk;
                                } else {
                                  text4 = double.parse(controller4.text);
                                }
                                if (controller5.text == '') {
                                  text5 = snapshot.data!.kzt;
                                } else {
                                  text5 = double.parse(controller5.text);
                                }
                                setState(() {
                                  futureAlbum = updateAlbum(
                                      text1, text2, text3, text4, text5);
                                      func();
                                });
                              },
                              child: const Text('Update Data'),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
