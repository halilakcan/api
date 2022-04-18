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

  Rate({
    required this.rateczk,
    required this.ratepln,
    required this.raterub,
    required this.ratekzt,
    required this.ratetry,
    required this.rateusd,
  });

  factory Rate.fromJson(json) {
    return Rate(
      rateczk: json['RATECZK'],
      ratepln: json['RATEPLN'],
      raterub: json['RATERUB'],
      ratekzt: json['RATEKZT'],
      ratetry: json['RATETRY'],
      rateusd: json['RATEUSD'],
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
