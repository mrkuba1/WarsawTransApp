import 'dart:convert';
import 'package:warsawtransapp/data/lines/models/busline.dart';

class BusstopLines {
  List<BusLine> lines;
  String? busstopid;
  String? busstopidsmall;

  BusstopLines({
    required this.lines,
  });

  Map<String, dynamic> toMap() {
    return {
      'busstopid': busstopid,
      'busstopidsmall': busstopidsmall,
      'lines': lines.map((line) => line.toMap()).toList(),
    };
  }

  factory BusstopLines.fromMap(Map<String, dynamic> map) {
    return BusstopLines(
      lines: (map['result'] as List<dynamic>?)
              ?.map((x) => BusLine.fromMap(x))
              .whereType<BusLine>()
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusstopLines.fromJson(String source) =>
      BusstopLines.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusstopLines(busstopid: $busstopid, busstopidsmall: $busstopidsmall, lines: $lines)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BusstopLines &&
        other.busstopid == busstopid &&
        other.busstopidsmall == busstopidsmall &&
        other.lines == lines;
  }

  @override
  int get hashCode {
    return busstopid.hashCode ^ busstopidsmall.hashCode ^ lines.hashCode;
  }

  // Setter do ustawienia busstopid
  void setBusstopId(String id) {
    busstopid = id;
  }

  // Setter do ustawienia busstopidsmall
  void setBusstopIdSmall(String smallId) {
    busstopidsmall = smallId;
  }

  BusLine getBuslinebyLine(String line) {
    return lines.firstWhere((busline) => busline.value == line,
        orElse: () => throw Exception('Busline not found for the given line'));
  }
}
