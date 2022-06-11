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

Future<Balance> getbalance() async {
  var url;
  if (_MyAppState.selectedIndex == 2) {
    url = Uri.parse(
        'https://angular-argon-331323-default-rtdb.firebaseio.com/algo.json');
  } else {
    url = Uri.parse(
        'https://angular-argon-331323-default-rtdb.firebaseio.com/algo2.json');
  }
  final response = await http.get(url);
  return Balance.fromJson(jsonDecode(response.body));
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

  Widget ratecr() {
    if (localrateltc == null) {
      return const CircularProgressIndicator();
    } else if(selectedIndex==2) {
      return Text(localrateltc.toStringAsFixed(2));
    } else {
      return Text(localratecr2.toStringAsFixed(2));
    }
  }

  Widget total() {
    if (sum == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text("BALANCE: "), CircularProgressIndicator()],
      );
    } else {
      return Text("BALANCE: $sum€");
    }
  }

  Widget body() {
    if (selectedIndex == 0 || selectedIndex == 1) {
      return ListView(
        children: [
          const Text(""),
          total(),
          const Text(""),
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
                    update(text1, text2, text3, text4, text5, text6, text7);
                  });
                },
                child: const Text('Update Data'),
              ),
            ],
          ),
        ],
      );
    } else if (balance == null) {
      return const CircularProgressIndicator();
    } else {
      return ListView(children: [
        Text("\nCOIN: "+coin+"-USDT\n"),
        Text("BALANCE\n USD: " +balance.toStringAsFixed(2) +" / FREE: " + free.toStringAsFixed(2)+" / COIN: " +balanceCoin.toStringAsFixed(2)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("LAST: "+last.toStringAsFixed(2)+" / CURRENT: "),
          ratecr(),
        ]),
        Text("\nB4: "+orderPrice[0].toStringAsFixed(2) +" / B3: "+orderPrice[1].toStringAsFixed(2) + " / B2: "+orderPrice[2].toStringAsFixed(2) +" / B1: "+orderPrice[3].toStringAsFixed(2)),
        Text("A1: "+orderPrice[4].toStringAsFixed(2) +" / A2: "+orderPrice[5].toStringAsFixed(2) + " / A3: "+orderPrice[6].toStringAsFixed(2) +" / A4: "+orderPrice[7].toStringAsFixed(2)),
        Text("\nBUY: $buy / SELL: $sell "),
        Text("AMEND: $amend / OFFSET: $offset / DELTA: "+delta.toStringAsFixed(3)),
        Text("LOST: $lost / BOTTOM: $bottom "),
        Text("\nSTART: $timestampinit "),
        Text("ORDER: $timestamporder "),
        Text("ALIVE: $timestamp "),
        Text("PROFIT: " +
            profit.toStringAsFixed(2) +
            " / PERCENT: " +
            percent.toStringAsFixed(2) +
            "\n"),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                Timer.periodic(
                    const Duration(seconds: 15), (Timer t) => account());
              });
            },
            child: const Text('Update Data'),
          ),
        ]),
      ]);
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
            Text("CZK: " + text4.toStringAsFixed(2) + " / RATE: "),
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
            Text("USD: " + text6.toStringAsFixed(2) + " / RATE: "),
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
  var balance,amend,balanceCoin,buy,sell,offset,lost,last,timestamp,timestampinit,bottom,timestamporder,coin;
  var sum, profit, percent,delta,orderPrice,free;
  var localrateczk,localratepln,localraterub,localratekzt,localrateusd,localratetry,localrateltc,localratecr2;

  void account() async {
    var data7 = await fetchAlbum();
    var data8 = await localgetcourse();
    var data9 = await getbalance();
    setState(() {
      text1 = data7.pln;
      text2 = data7.eur;
      text3 = data7.rub;
      text4 = data7.czk;
      text5 = data7.kzt;
      text6 = data7.usd;
      text7 = data7.trl;
      balance = data9.balance;
      balanceCoin = data9.balanceCoin;
      amend = data9.amend;
      bottom = data9.bottom;
      coin=data9.coin;
      buy = data9.buy;
      last = data9.last;
      lost = data9.lost;
      offset = data9.offset;
      delta=data9.delta;
      free=data9.free;
      orderPrice=data9.orderPrice;
      sell = data9.sell;
      timestamp = data9.timestamp;      
      timestamporder = data9.timestamporder;
      timestampinit = data9.timestampinit;
      double factor = 4;
      double lostFactor = 6;
      profit = sell * delta * balanceCoin / factor -
          balanceCoin / factor * last * 0.0016 -
          lost * lostFactor * delta * balanceCoin / factor -
          lost * 2 * balanceCoin * 0.001 -
          amend * balanceCoin * last / factor * 0.0002;
      percent = profit / (balanceCoin * last * 2) * 100;
      localrateczk = data8.rateczk;
      localratepln = data8.ratepln;
      localraterub = data8.raterub;
      localratekzt = data8.ratekzt;
      localrateusd = data8.rateusd;
      localratetry = data8.ratetry;
      localrateltc = data8.rateltc;
      localratecr2=data8.ratecr2;      
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
          style: Theme.of(context).textTheme.headline5!,
          textAlign: TextAlign.center,
          child: Center(child: body()),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.balance),
              label: 'Algorithm 6',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.military_tech), label: 'Algorithm 7'),
          ],
          currentIndex: selectedIndex,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.amber,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
