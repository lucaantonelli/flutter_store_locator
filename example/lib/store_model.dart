class Store {
  int id;
  String name;
  String? address;
  String city;
  double latitude;
  double longitude;

  Store({
    required this.id,
    required this.name,
    this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: int.parse(json['id']),
      name: json['name'],
      address: json['address'],
      city: json['city'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
    );
  }
}

List<Store> storesFromJson(dynamic jsonData) {
  return List<Store>.from(jsonData.map((item) => Store.fromJson(item)));
}
