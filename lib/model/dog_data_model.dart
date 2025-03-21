// To parse this JSON data, do
//
//     final dogDataModel = dogDataModelFromJson(jsonString);

import 'dart:convert';

List<DogDataModel> dogDataModelFromJson(String str) => List<DogDataModel>.from(
    json.decode(str).map((x) => DogDataModel.fromJson(x)));

String dogDataModelToJson(List<DogDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DogDataModel {
  String id;
  String url;
  int width;
  int height;

  DogDataModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory DogDataModel.fromJson(Map<String, dynamic> json) => DogDataModel(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "width": width,
        "height": height,
      };
}
