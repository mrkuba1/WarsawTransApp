import 'dart:async'; // Import required for Timer
import 'package:flutter/material.dart';
import 'package:warsawtransapp/data/timetables/models/busroute.dart';

class BusTimeTableWidget extends StatefulWidget {
  final List<BusRoute> items;

  const BusTimeTableWidget({Key? key, required this.items}) : super(key: key);

  @override
  _BusTimeTableWidgetState createState() => _BusTimeTableWidgetState();
}

class _BusTimeTableWidgetState extends State<BusTimeTableWidget> {
  late List<BusRoute> sortedBusRoutes;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    sortedBusRoutes = BusRoute.sortBusRoutesByTime(widget.items);
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      setState(() {
        // Update the sortedBusRoutes
        sortedBusRoutes = BusRoute.sortBusRoutesByTime(widget.items);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Numer linii',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Odjazd',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Kierunek',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Pozostało',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: sortedBusRoutes.map<DataRow>((BusRoute route) {
        DateTime now = DateTime.now();
        String timeDifference = '-';

        DateTime departureDateTime = DateTime(
            now.year, now.month, now.day, route.time.hour, route.time.minute);

        Duration difference = departureDateTime.difference(now);

        int hours = difference.inHours;
        int minutes = difference.inMinutes.remainder(60);
        int seconds = difference.inSeconds.remainder(60);

        if (hours > 0) {
          timeDifference = '$hours:${minutes.toString().padLeft(2, '0')}';
        } else if (hours == 0) {
          if (minutes < 0) {
            timeDifference = 'odjechał ${-1 * minutes} minut temu';
          } else {
            timeDifference = '$hours:${minutes.toString().padLeft(2, '0')}';
          }
        } else if (hours < 0) {
          hours += 24;
          if (minutes < 0) {
            minutes += 60;
            hours--;
          }
          if (seconds < 0) {
            seconds += 60;
            minutes--;
          }
          timeDifference = '$hours:${minutes.toString().padLeft(2, '0')}';
        }

        return DataRow(
          cells: <DataCell>[
            DataCell(Text(route.line!.value)),
            DataCell(Text(route.formatTime(route.time.toString()))),
            DataCell(Text(route.destination)),
            DataCell(Text(timeDifference)),
          ],
        );
      }).toList(),
    );
  }
}
