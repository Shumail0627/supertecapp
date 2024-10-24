import 'dart:convert';

// Function to parse JSON string into a list of OfficeLocationModel objects
List<OfficeLocationModel> officeLocationModelFromMap(String str) =>
    List<OfficeLocationModel>.from(
        json.decode(str).map((x) => OfficeLocationModel.fromMap(x)));

// Function to convert a list of OfficeLocationModel objects into a JSON string
String officeLocationModelToMap(List<OfficeLocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class OfficeLocationModel {
  final String? id;
  final String? officeName;
  final String? latitude;
  final String? longitude;
  final String? radius;
  final dynamic createdAt;
  String? address; // Added address field

  OfficeLocationModel({
    this.id,
    this.officeName,
    this.latitude,
    this.longitude,
    this.radius,
    this.createdAt,
    this.address, // Initialize the address field
  });

  // Function to create a copy of the current object with new values
  OfficeLocationModel copyWith({
    String? id,
    String? officeName,
    String? latitude,
    String? longitude,
    String? radius,
    dynamic createdAt,
    String? address, // Add address to copyWith method
  }) =>
      OfficeLocationModel(
        id: id ?? this.id,
        officeName: officeName ?? this.officeName,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        radius: radius ?? this.radius,
        createdAt: createdAt ?? this.createdAt,
        address: address ?? this.address, // Copy address field
      );

  // Factory constructor to create an object from a map
  factory OfficeLocationModel.fromMap(Map<String, dynamic> json) =>
      OfficeLocationModel(
        id: json["id"],
        officeName: json["office_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        radius: json["radius"],
        createdAt: json["created_at"],
        address: json["address"], // Populate address if present in the JSON
      );

  // Function to convert an object into a map
  Map<String, dynamic> toMap() => {
        "id": id,
        "office_name": officeName,
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
        "created_at": createdAt,
        "address": address, // Include address in the map
      };
}
