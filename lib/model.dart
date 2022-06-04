class Account {
  double pln;
  double eur;
  double czk;
  double rub;
  double kzt;
  double usd;
  double trl;

  Account({
    required this.pln,
    required this.eur,
    required this.czk,
    required this.rub,
    required this.kzt,
    required this.usd,
    required this.trl,
  });

  factory Account.fromJson(json) {
    return Account(
      pln: json['PLN'],
      eur: json['EUR'],
      czk: json['CZK'],
      rub: json['RUB'],
      kzt: json['KZT'],
      usd: json['USD'],
      trl: json['TRY'],
    );
  }
}

class Rate {
  double rateczk;
  double ratepln;
  double raterub;
  double ratekzt;
  double ratetry;
  double rateusd;
  double rateltc;
  Rate({
    required this.rateczk,
    required this.ratepln,
    required this.raterub,
    required this.ratekzt,
    required this.ratetry,
    required this.rateusd,
    required this.rateltc,
  });

  factory Rate.fromJson(json) {
    return Rate(
      rateczk: json['RATECZK'],
      ratepln: json['RATEPLN'],
      raterub: json['RATERUB'],
      ratekzt: json['RATEKZT'],
      ratetry: json['RATETRY'],
      rateusd: json['RATEUSD'],
      rateltc: json['RATELTC'],
    );
  }
}

class Exchange {
  String rate;

  Exchange({
    required this.rate,
  });

  factory Exchange.fromJson(json) {
    return Exchange(
      rate: json["Realtime Currency Exchange Rate"]["5. Exchange Rate"],
    );
  }
}

class Balance {
  double balance;
  double amend;
  double balanceCoin;
  double buy;
  double sell;
  double offset;
  double lost;
  double last;
  String timestamp;
  String timestampinit;
  double bottom;
  double delta;
  double free;
  List orderPrice;
  Balance({
    required this.balance,
    required this.amend,
    required this.balanceCoin,
    required this.buy,
    required this.sell,
    required this.offset,
    required this.lost,
    required this.last,
    required this.timestamp,
    required this.timestampinit,
    required this.bottom,
    required this.delta,
    required this.free,
    required this.orderPrice,
  });

  factory Balance.fromJson(json) {
    return Balance(
      balance: json['BALANCE'],
      buy: json['BUY'],
      sell: json['SELL'],
      last: json['LAST'],
      balanceCoin: json['BALANCECOIN'],
      offset: json['OFFSET'],
      amend: json['AMEND'],
      lost: json['LOST'],
      bottom: json['BOTTOM'],
      delta: json['DELTA'],
      free: json['FREE'],
      timestamp: json['TIMESTAMP'],
      timestampinit: json['TIMESTAMPINIT'],
      orderPrice: json['ORDERPRICE'],
    );
  }
}
