import 'dart:convert';
import 'package:warsawtransapp/data/busstops/models/busstopdata.dart';

class BusstopsInfo {
  List<BusstopInfo> busstopsinfo;

  BusstopsInfo({
    required this.busstopsinfo,
  });

  BusstopsInfo copyWith({
    List<BusstopInfo>? busstopsinfo,
  }) {
    return BusstopsInfo(
      busstopsinfo: busstopsinfo ?? this.busstopsinfo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'busstopsinfo':
          busstopsinfo.map((busstopinfo) => busstopinfo.toMap()).toList(),
    };
  }

  factory BusstopsInfo.fromMap(Map<String, dynamic> map) {
    return BusstopsInfo(
      busstopsinfo: (map['result'] as List<dynamic>?)
              ?.map((x) => BusstopInfo.fromMap(x))
              .whereType<BusstopInfo>()
              .toList() ??
          [],
    );
  }
  String toJson() => json.encode(toMap());

  factory BusstopsInfo.fromJson(String source) =>
      BusstopsInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusstopsInfo(busstops:$busstopsinfo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BusstopsInfo && other.busstopsinfo == busstopsinfo;
  }

  @override
  int get hashCode {
    return busstopsinfo.hashCode;
  }

  BusstopInfo getBusstopInfoByIdAndIdSmall(String id, String idSmall) {
    return busstopsinfo.firstWhere(
      (busstopInfo) => busstopInfo.id == id && busstopInfo.smallid == idSmall,
      orElse: () =>
          throw Exception('BusstopInfo not found for the given id and idSmall'),
    );
  }

  List<BusstopInfo> getBusstopsInfoByName(String name) {
    return busstopsinfo
        .where(
          (busstopInfo) =>
              busstopInfo.name.toLowerCase().contains(name.toLowerCase()),
        )
        .toList();
  }
}
