import 'dart:convert';

import 'package:warsawtransapp/data/lines/models/busline.dart';

class BusRoute {
  final String team;
  final String destination;
  final String route;
  final DateTime time;
  BusLine? line;

  BusRoute(
      {required this.team,
      required this.destination,
      required this.route,
      required this.time});

  BusRoute copyWith({
    String? team,
    String? destination,
    String? route,
    DateTime? time,
  }) {
    return BusRoute(
        team: team ?? this.team,
        destination: destination ?? this.destination,
        route: route ?? this.route,
        time: time ?? this.time);
  }

  Map<String, dynamic> toMap() {
    return {
      'team': team,
      'destination': destination,
      'route': route,
      'time': time
    };
  }

  factory BusRoute.fromMap(Map<String, dynamic> map) {
    return BusRoute(
      team: map['values'][2]['value']?.toString() ?? '',
      destination: map['values'][3]['value']?.toString() ?? '',
      route: map['values'][4]['value']?.toString() ?? '',
      time: parseTime(map['values'][5]['value']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory BusRoute.fromJson(String source) =>
      BusRoute.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusRoute(team: $team, destination: $destination, route: $route, time $time, line $line)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BusRoute &&
        other.team == team &&
        other.destination == destination &&
        other.route == route &&
        other.time == time;
  }

  @override
  int get hashCode {
    return team.hashCode ^
        destination.hashCode ^
        route.hashCode ^
        time.hashCode;
  }

  static DateTime parseTime(String timeString) {
    List<String> parts = timeString.split(':');
    if (parts.length == 3) {
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      int second = int.parse(parts[2]);

      return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute, second);
    } else {
      throw FormatException('Invalid time format: $timeString');
    }
  }

  String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    return formattedTime;
  }

  void setBusLine(BusLine line) {
    this.line = line;
  }

  static List<BusRoute> sortBusRoutesByTime(List<BusRoute> busRoutes) {
    final now = DateTime.now();

     Duration min_difference = Duration(hours: 5) ;
     int zero_time =0;
     final List<BusRoute> busRoutes_sorted = [];

    for(int route =0; route < busRoutes.length;route++){
      DateTime departureDateTime = DateTime(
          now.year, now.month, now.day, busRoutes[route].time.hour, busRoutes[route].time.minute);
      // print('odjazd ${busRoutes[route].time.hour}');
      // print('teraz ${now.hour}');

      Duration difference = departureDateTime.difference(now);
      // print('dif $difference');
      // print('min $min_difference');
      // print('zerotime $zero_time');
      if(difference < min_difference && !difference.isNegative){
        min_difference = difference;

        zero_time = route;

      }
    }

    for  (int route = zero_time; route < busRoutes.length; route++) {
      busRoutes_sorted.add(busRoutes[route]);
    }
    for  (int route = 0; route < zero_time; route++) {
      busRoutes_sorted.add(busRoutes[route]);
    }
    return busRoutes_sorted;

  }

}
