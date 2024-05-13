import 'dart:convert';
import 'package:busapp/data/busstops/models/busstopdata.dart';
import 'package:busapp/data/busstops/models/busstopsinfo.dart';
import 'package:busapp/data/core/bus_client.dart';
import 'package:busapp/data/lines/models/busline.dart';
import 'package:busapp/data/lines/models/busstoplines.dart';
import 'package:busapp/data/timetables/models/busroute.dart';
import 'package:busapp/data/timetables/models/busroutes.dart';
import 'package:busapp/presentation/widgets/bus_timetable_widget.dart';
import 'package:busapp/presentation/widgets/lines_button_widget.dart';
import 'package:busapp/presentation/widgets/nav_bus_widget.dart';
import 'package:busapp/presentation/widgets/nav_widget.dart';
import 'package:busapp/presentation/widgets/save_widget.dart';
import 'package:busapp/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final BusClient _busClient = BusClient();
  late BusstopsInfo downloadBusstopsinfo = BusstopsInfo(busstopsinfo: []);
  String name = 'Please select your busstop';
  BusstopInfo? selectedBusStop;
  BusstopLines? busstopLines;
  List<BusLine> selectedLines = [];
  List<BusRoute> busroutes = [];
  List<Busroutes> busRoutesList = [];

  Future<void> fetchBusstopsInfo() async {
    print("POBIERAM DANE");
    try {
      //BusstopsInfo busstopsInfos = await _busClient.getBusstopsInfo();
      final String contents =
          await rootBundle.loadString('assets/all_busstops_info.json');
      final jsonData = json.decode(contents);
      BusstopsInfo busstopsInfos = BusstopsInfo.fromMap(jsonData);

      setState(() {
        downloadBusstopsinfo = busstopsInfos;
      });
    } catch (e) {
      // Obsługa błędu
      print("Wystąpił błąd podczas pobierania danych o przystankach : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBusstopsInfo();
  }

  // Metoda do pobierania danych dla przystanku autobusowego
  Future<void> fetchBusstopLines(BusstopInfo busStopInfo) async {
    try {
      // Pobieranie danych
      BusstopLines lines = await _busClient.getBusstopLines(
        busStopInfo.id,
        busStopInfo.smallid,
      );
      // Aktualizacja stanu
      setState(() {
        busroutes = [];
        selectedBusStop = busStopInfo;
        name = ("${busStopInfo.name} ${busStopInfo.id} ${busStopInfo.smallid}");
        busstopLines = lines;
        busroutes = [];
        busRoutesList = [];
      });
    } catch (e) {
      // Obsługa błędu
      print("Wystąpił błąd podczas pobierania danych: $e");
    }
    print(busstopLines);
  }

  Future<void> fetchBusroutes(List<BusLine> lines) async {
    print(lines);
    try {
      for (int i = 0; i < lines.length; i++) {
        Busroutes busRoutes = await _busClient.getBusRoutes(
            selectedBusStop!.id, selectedBusStop!.smallid, lines[i].value);

        busRoutes.setBusLine(lines[i]);
        busRoutesList.add(busRoutes);
      }
    } catch (e) {
      print("Wystąpił błąd podczas pobierania danych: $e");
    }
    setState(() {
      busroutes = mergeBusRoute(busRoutesList);
    });
    busRoutesList = [];
    // print(busroutes);
  }

  List<BusRoute> mergeBusRoute(List<Busroutes> busRoutesList) {
    List<BusRoute> selectedBusRoute = [];
    for (int i = 0; i < busRoutesList.length; i++) {
      for (int j = 0; j < busRoutesList[i].routes.length; j++) {
        busRoutesList[i].routes[j].setBusLine(busRoutesList[i].line as BusLine);
        selectedBusRoute.add(busRoutesList[i].routes[j]);
      }
    }
    BusRoute.sortBusRoutesByTime(selectedBusRoute);
    return selectedBusRoute;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: const NavWidget(),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / (4 / 3),
                  child: BusstopNavWidget(name: name),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 100,
                  // child: BusStopsSearch(
                  //   busstopsInfo: downloadBusstopsinfo,
                  // ),
                  child: SearchWithSuggestionsWidget(
                    busstopsInfo: downloadBusstopsinfo,
                    onSuggestionSelectedCallback: (selectedBusStop) {
                      setState(() {});
                      fetchBusstopLines(selectedBusStop);
                      // Tutaj możesz wykonać dowolne działania na wybranym przystanku
                      print('Selected bus stop: ${selectedBusStop.name}');
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / (4 / 3),
                  height: 10,
                  //puste bo to rzad z wyszukiwarka
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / (4 / 3),
                  child: busstopLines != null && busstopLines!.lines.isNotEmpty
                      ? LinesButtonsWidget(
                          items: busstopLines!.lines,
                          onLinesSelected: fetchBusroutes)
                      : const SizedBox(), // Jeśli nie ma linii autobusowych, nie wyświetlaj widgetu
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / (4 / 3),
                  height: MediaQuery.of(context).size.height / (4 / 3),
                  child: busroutes.isNotEmpty
                      ? BusTimeTableWidget(items: busroutes)
                      : const SizedBox(), // Jeśli nie ma linii autobusowych, nie wyświetlaj widgetu
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 100,
                  child: SaveList(
                    selectedLines: selectedLines,
                    busStop: selectedBusStop ??
                        BusstopInfo(
                            id: '',
                            name: '',
                            smallid: '',
                            latitude: '',
                            streetid: '',
                            alitude: '',
                            destionation: ''),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / (4 / 3),
                  height: 10,
                  //puste bo to rzad z wyszukiwarka
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
