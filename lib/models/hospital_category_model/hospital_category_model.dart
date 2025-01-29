// To parse this JSON data, do
//
//     final hospitalCategoryModel = hospitalCategoryModelFromJson(jsonString);

import 'dart:convert';

HospitalCategoryModel hospitalCategoryModelFromJson(String str) => HospitalCategoryModel.fromJson(json.decode(str));

String hospitalCategoryModelToJson(HospitalCategoryModel data) => json.encode(data.toJson());

class HospitalCategoryModel {
  List<HospitalCategoryDataModel>? data;
  int? status;
  String? message;

  HospitalCategoryModel({
    this.data,
    this.status,
    this.message,
  });

  factory HospitalCategoryModel.fromJson(Map<String, dynamic> json) => HospitalCategoryModel(
        data: json["data"] == null ? [] : List<HospitalCategoryDataModel>.from(json["data"]!.map((x) => HospitalCategoryDataModel.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class HospitalCategoryDataModel {
  String? id;
  String? name;
  int? v;

  HospitalCategoryDataModel({
    this.id,
    this.name,
    this.v,
  });

  factory HospitalCategoryDataModel.fromJson(Map<String, dynamic> json) => HospitalCategoryDataModel(
        id: json["_id"],
        name: json["name"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
      };
}
