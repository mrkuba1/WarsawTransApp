import 'dart:convert';

class BusstopInfo {
  final String id;
  final String smallid;
  final String name;
  final String streetid;
  final String latitude;
  final String alitude;
  final String destionation;

  BusstopInfo({
    required this.id,
    required this.smallid,
    required this.name,
    required this.streetid,
    required this.latitude,
    required this.alitude,
    required this.destionation,
  });

  BusstopInfo copyWith(
      {String? id,
      String? smallid,
      String? name,
      String? streetid,
      String? latitude,
      String? alitude,
      String? destionation}) {
    return BusstopInfo(
      id: id ?? this.id,
      smallid: smallid ?? this.smallid,
      name: name ?? this.smallid,
      streetid: streetid ?? this.streetid,
      latitude: latitude ?? this.latitude,
      alitude: alitude ?? this.alitude,
      destionation: destionation ?? this.destionation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': alitude,
      'smallid': smallid,
      'name': name,
      'streetid': streetid,
      'latitude': latitude,
      'alitude': alitude,
      'destination': destionation
    };
  }

  factory BusstopInfo.fromMap(Map<String, dynamic> map) {
    return BusstopInfo(
      id: map['values'][0]['value']?.toString() ?? '',
      smallid: map['values'][1]['value']?.toString() ?? '',
      name: map['values'][2]['value']?.toString() ?? '',
      streetid: map['values'][3]['value']?.toString() ?? '',
      latitude: map['values'][4]['value']?.toString() ?? '',
      alitude: map['values'][5]['value']?.toString() ?? '',
      destionation: map['values'][6]['value']?.toString() ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory BusstopInfo.fromJson(String source) =>
      BusstopInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusstopInfo(id: $id, smallid: $smallid, name: $name, streetid:$streetid, latitude: $latitude, alitude: $alitude, destitation: $destionation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BusstopInfo &&
        other.id == id &&
        other.smallid == smallid &&
        other.name == name &&
        other.streetid == streetid &&
        other.alitude == alitude &&
        other.latitude == latitude &&
        other.destionation == destionation;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        smallid.hashCode ^
        name.hashCode ^
        streetid.hashCode ^
        alitude.hashCode ^
        latitude.hashCode ^
        destionation.hashCode;
  }
}
