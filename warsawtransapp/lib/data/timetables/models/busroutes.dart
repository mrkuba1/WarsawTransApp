import 'dart:convert';
import 'package:warsawtransapp/data/lines/models/busline.dart';
import 'package:warsawtransapp/data/timetables/models/busroute.dart';

class Busroutes {
  List<BusRoute> routes;
  BusLine? line;

  Busroutes({
    required this.routes,
  });

  Map<String, dynamic> toMap() {
    return {
      'routes': routes.map((route) => route.toMap()).toList(),
    };
  }

  factory Busroutes.fromMap(Map<String, dynamic> map) {
    return Busroutes(
      routes: (map['result'] as List<dynamic>?)
              ?.map((x) => BusRoute.fromMap(x))
              .whereType<BusRoute>()
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Busroutes.fromJson(String source) =>
      Busroutes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Busroutes(routes: $routes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Busroutes && other.routes == routes;
  }

  @override
  int get hashCode {
    return routes.hashCode;
  }

  void setBusLine(BusLine line) {
    this.line = line;
  }
}
