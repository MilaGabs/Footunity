class Medida {
  double centimetros;
  double inches;
  double br;
  double us;
  double uk;
  double eu;
  DateTime dataMedicao;

  Medida({this.centimetros, this.inches, this.br, this.dataMedicao, this.eu, this.uk, this.us});
  
  factory Medida.fromJson(json) {
    var medida = new Medida(
      centimetros: json["centimetros"],
      inches: json["inches"] as double,
      br: json["br"] as double,
      us: json["us"] as double,
      uk: json["uk"] as double,
      eu: json["eu"] as double,
    );

    return medida;
  }
  //factory Medida.fromJson(Map<String, dynamic> json) => _$MedidaFromJson(json);
  //Map<String, dynamic> toJson() => _$MedidaToJson(this);
}