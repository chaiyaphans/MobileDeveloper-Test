// To parse this JSON data, do
//
//     final currencyRate = currencyRateFromJson(jsonString);

import 'dart:convert';

CurrencyRateModel currencyRateFromJson(String str) => CurrencyRateModel.fromJson(json.decode(str));

String currencyRateToJson(CurrencyRateModel data) => json.encode(data.toJson());

class CurrencyRateModel {
  Time? time;
  String? disclaimer;
  String? chartName;
  Bpi? bpi;

  CurrencyRateModel({
    this.time,
    this.disclaimer,
    this.chartName,
    this.bpi,
  });

  factory CurrencyRateModel.fromJson(Map<String, dynamic> json) => CurrencyRateModel(
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        disclaimer: json["disclaimer"],
        chartName: json["chartName"],
        bpi: json["bpi"] == null ? null : Bpi.fromJson(json["bpi"]),
      );

  Map<String, dynamic> toJson() => {
        "time": time?.toJson(),
        "disclaimer": disclaimer,
        "chartName": chartName,
        "bpi": bpi?.toJson(),
      };
}

class Bpi {
  CurrencyData? usd;
  CurrencyData? gbp;
  CurrencyData? eur;

  Bpi({
    this.usd,
    this.gbp,
    this.eur,
  });

  factory Bpi.fromJson(Map<String, dynamic> json) => Bpi(
        usd: json["USD"] == null ? null : CurrencyData.fromJson(json["USD"]),
        gbp: json["GBP"] == null ? null : CurrencyData.fromJson(json["GBP"]),
        eur: json["EUR"] == null ? null : CurrencyData.fromJson(json["EUR"]),
      );

  Map<String, dynamic> toJson() => {
        "USD": usd?.toJson(),
        "GBP": gbp?.toJson(),
        "EUR": eur?.toJson(),
      };
}

class CurrencyData {
  String? code;
  String? symbol;
  String? rate;
  String? description;
  double? rateFloat;

  CurrencyData({
    this.code,
    this.symbol,
    this.rate,
    this.description,
    this.rateFloat,
  });

  factory CurrencyData.fromJson(Map<String, dynamic> json) => CurrencyData(
        code: json["code"] ?? "",
        symbol: json["symbol"] ?? "",
        rate: json["rate"] ?? "",
        description: json["description"] ?? "",
        rateFloat: json["rate_float"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "symbol": symbol,
        "rate": rate,
        "description": description,
        "rate_float": rateFloat,
      };
}

class Time {
  String? updated;
  DateTime? updatedIso;
  String? updateduk;

  Time({
    this.updated,
    this.updatedIso,
    this.updateduk,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        updated: json["updated"],
        updatedIso: json["updatedISO"] == null ? null : DateTime.parse(json["updatedISO"]),
        updateduk: json["updateduk"],
      );

  Map<String, dynamic> toJson() => {
        "updated": updated,
        "updatedISO": updatedIso?.toIso8601String(),
        "updateduk": updateduk,
      };
}
