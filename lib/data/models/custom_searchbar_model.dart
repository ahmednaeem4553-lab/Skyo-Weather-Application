// lib/data/models/custom_search_bar_model.dart
class CitySuggestion {
  final String name;
  final String? state;
  final String country;
  final double lat;
  final double lon;

  CitySuggestion({
    required this.name,
    this.state,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory CitySuggestion.fromJson(Map<String, dynamic> json) {
    return CitySuggestion(
      name: json['name'] as String? ?? 'Unknown',
      state: json['state'] as String?,
      country: json['country'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
    );
  }

  String get displayName {
    final parts = [name];
    if (state != null && state!.isNotEmpty) parts.add(state!);
    if (country.isNotEmpty) parts.add(country);
    return parts.join(', ');
  }
}