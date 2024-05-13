import 'package:busapp/data/timetables/models/busroute.dart';
import 'package:flutter/material.dart';

class BusTimeTableWidget extends StatelessWidget {
  final List<BusRoute> items;

  const BusTimeTableWidget({Key? key, required this.items}) : super(key: key);

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
            'Pozostało',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: items.map<DataRow>((BusRoute route) {
        // Obliczanie różnicy czasu
        Duration difference = route.time.difference(DateTime.now());
        String timeDifference =
            '${difference.inHours}:${difference.inMinutes.remainder(60)}:${difference.inSeconds.remainder(60)}';
        return DataRow(
          cells: <DataCell>[
            DataCell(Text(route.line!.value)),
            DataCell(Text(route.formatTime(route.time.toString()))),
            DataCell(Text(timeDifference)),
          ],
        );
      }).toList(),
    );
  }
}
