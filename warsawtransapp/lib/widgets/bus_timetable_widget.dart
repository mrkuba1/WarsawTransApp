import 'package:flutter/material.dart';
import 'package:warsawtransapp/data/timetables/models/busroute.dart';

class BusTimeTableWidget extends StatelessWidget {
  final List<BusRoute> items;



  const BusTimeTableWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<BusRoute> busRoute_toSort = BusRoute.sortBusRoutesByTime(items);
    print(busRoute_toSort);
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
      rows: busRoute_toSort.map<DataRow>((BusRoute route) {
        // Obliczanie różnicy czasu---------------------

        // Pobieramy aktualną godzinę
        DateTime now = DateTime.now();
        String timeDifference ='';

        // Tworzymy obiekt DateTime z godziną odjazdu
        DateTime departureDateTime = DateTime(
            now.year, now.month, now.day, route.time.hour, route.time.minute);

        // Obliczamy różnicę czasu

        Duration difference = departureDateTime.difference(now);




            int hours = difference.inHours;
            int minutes = difference.inMinutes.remainder(60);
            int seconds = difference.inSeconds.remainder(60);





        if (hours > 0) {

          timeDifference =
          '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString()
              .padLeft(2, '0')}';
        }
         if(hours == 0 ){
           if(minutes < 0){
             timeDifference = 'odjechał ${-1*minutes} minut temu';
           }
         }
          else{
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
