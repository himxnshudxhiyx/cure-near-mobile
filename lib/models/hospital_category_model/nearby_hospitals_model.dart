// To parse this JSON data, do
//
//     final nearbyHospitals = nearbyHospitalsFromJson(jsonString);

import 'dart:convert';

NearbyHospitals nearbyHospitalsFromJson(String str) => NearbyHospitals.fromJson(json.decode(str));

String nearbyHospitalsToJson(NearbyHospitals data) => json.encode(data.toJson());

class NearbyHospitals {
  List<NearbyHospitalsDataModel>? data;
  int? totalRecords;
  int? status;
  String? message;

  NearbyHospitals({
    this.data,
    this.totalRecords,
    this.status,
    this.message,
  });

  factory NearbyHospitals.fromJson(Map<String, dynamic> json) => NearbyHospitals(
        data: json["data"] == null ? [] : List<NearbyHospitalsDataModel>.from(json["data"]!.map((x) => NearbyHospitalsDataModel.fromJson(x))),
        totalRecords: json["totalRecords"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalRecords": totalRecords,
        "status": status,
        "message": message,
      };
}

class NearbyHospitalsDataModel {
  Location? location;
  String? id;
  String? name;
  String? address;
  String? phone;
  List<String>? services;
  List<String>? category;

  NearbyHospitalsDataModel({
    this.location,
    this.id,
    this.name,
    this.address,
    this.phone,
    this.services,
    this.category,
  });

  factory NearbyHospitalsDataModel.fromJson(Map<String, dynamic> json) => NearbyHospitalsDataModel(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
        category: json["category"] == null ? [] : List<String>.from(json["category"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
        "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
      };
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
