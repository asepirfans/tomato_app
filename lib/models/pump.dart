// To parse this JSON data, do
//
//     final pump = pumpFromJson(jsonString);

import 'dart:convert';

Pump pumpFromJson(String str) => Pump.fromJson(json.decode(str));

String pumpToJson(Pump data) => json.encode(data.toJson());

class Pump {
    String id;
    String pump1;
    String pump2;
    String pump3;
    DateTime waktu;
    int v;

    Pump({
        required this.id,
        required this.pump1,
        required this.pump2,
        required this.pump3,
        required this.waktu,
        required this.v,
    });

    factory Pump.fromJson(Map<String, dynamic> json) => Pump(
        id: json["_id"],
        pump1: json["pump1"],
        pump2: json["pump2"],
        pump3: json["pump3"],
        waktu: DateTime.parse(json["waktu"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "pump1": pump1,
        "pump2": pump2,
        "pump3": pump3,
        "waktu": waktu.toIso8601String(),
        "__v": v,
    };
}
