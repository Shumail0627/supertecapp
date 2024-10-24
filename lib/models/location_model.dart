class LocationPoint {
  final String? type;
  final String? address;
  final String? state;
  final String? city;
  final String? street;
  final String? zipCode;
  final List<num>? coordinates;

  LocationPoint({
    this.type,
    this.address,
    this.state,
    this.city,
    this.street,
    this.zipCode,
    this.coordinates,
  });

  factory LocationPoint.fromJson(Map<String, dynamic> json) => LocationPoint(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<num>.from(json["coordinates"]!.reversed.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
