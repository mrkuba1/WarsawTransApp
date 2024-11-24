import 'dart:convert';

class BusLine {
  final String value;
  final String key;

  BusLine({required this.value, required this.key});

  BusLine copyWith({
    String? value,
    String? key,
  }) {
    return BusLine(value: value ?? this.value, key: key ?? this.key);
  }

  Map<String, dynamic> toMap() {
    return {
      'wartosc': value,
      'linia': key,
    };
  }

  factory BusLine.fromMap(Map<String, dynamic> map) {
    return BusLine(
      value: map['values'][0]['value']?.toString() ?? '',
      key: map['values'][0]['key']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BusLine.fromJson(String source) =>
      BusLine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusLine(value: $value, key: $key)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BusLine && other.value == value && other.key == key;
  }

  @override
  int get hashCode {
    return value.hashCode ^ key.hashCode;
  }
}
