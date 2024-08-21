class City {
  final String name;
  final double lat;
  final double lon;
  final String state;
  final String country;

  City({
    required this.name,
    required this.lat,
    required this.lon,
    required this.state,
    required this.country,
  });

  // Factory constructor to create a City instance from a JSON map
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] as String,
      lat: json['lat'] as double,
      lon: json['lon'] as double,
      state: json['state'] as String,
      country: json['country'] as String,
    );
  }

  // Method to convert a City instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': lat,
      'lon': lon,
      'state': state,
      'country': country,
    };
  }
}
