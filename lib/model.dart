class Album {
  double pln;
  double eur;
  double czk;
  double rub;
  double kzt;

  Album({
    required this.pln,
    required this.eur,
    required this.czk,
    required this.rub,
    required this.kzt,
  });

  factory Album.fromJson(json) {
    return Album(
      pln: json['PLN'],
      eur: json['EUR'],
      czk: json['CZK'],
      rub: json['RUB'],
      kzt: json['KZT'],
    );
  }
}
