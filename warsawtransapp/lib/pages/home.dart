import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warsawtransapp/data/busstops/models/busstopdata.dart';
import 'package:warsawtransapp/data/busstops/models/busstopsinfo.dart';
import 'package:warsawtransapp/data/core/bus_client.dart';
import 'package:warsawtransapp/data/lines/models/busline.dart';
import 'package:warsawtransapp/data/lines/models/busstoplines.dart';
import 'package:warsawtransapp/data/timetables/models/busroute.dart';
import 'package:warsawtransapp/data/timetables/models/busroutes.dart';
import 'package:warsawtransapp/models/favbusinfo.dart';
import 'package:warsawtransapp/utils/colors.dart';
import 'package:warsawtransapp/widgets/bus_timetable_widget.dart';
import 'package:warsawtransapp/widgets/lines_button_widget.dart';
import 'package:warsawtransapp/widgets/nav_bus_widget.dart';
import 'package:warsawtransapp/widgets/nav_widget.dart';
import 'package:warsawtransapp/widgets/search_widget.dart';

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
  List<BusstopInfo> _data = [];
  List<FavBusInfo> _favbusinfos = [];

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
    print(busroutes);
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
                  child: SearchWithSuggestionsWidget(
                    busstopsInfo: downloadBusstopsinfo,
                    onSuggestionSelectedCallback: (selectedBusStop) {
                      setState(() {});
                      fetchBusstopLines(selectedBusStop);
                      print('Selected bus stop: ${selectedBusStop.toString()}');
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
                  height: MediaQuery.of(context).size.height / 3,
                  child: busstopLines != null && busstopLines!.lines.isNotEmpty
                      ? LinesButtonsWidget(
                          items: busstopLines!.lines,
                          onLinesSelected: fetchBusroutes)
                      : const SizedBox(), // Jeśli nie ma linii autobusowych, nie wyświetlaj widgetu
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / (4 / 3),
                  height: MediaQuery.of(context).size.height / 3,
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
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            _addSelectedBusStop(selectedBusStop!);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.secondary,
                            ),
                          ),
                          child: const Padding(
                            padding:
                                EdgeInsets.all(8.0), // Add padding/margins here
                            child: Text(
                              "Save busstop",
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _buildDataList(),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / (4 / 3),
                  height: 10,
                  // Empty because it's a row with a search bar
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addSelectedBusStop(BusstopInfo selectedBusStop) {
    setState(() {
      _data.add(selectedBusStop); // Dodawanie nazwy przystanku
      //  _favbusinfos.add(FavBusInfo(busstopInfo: selectedBusStop,busLines: busstopLines?.lines));
    });
  }

  Widget _buildDataList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                _data.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Element usunięty'),
              ));
            },
            child: ListTile(
              onTap: () {
                _onSelectedBusStopFromList(_data[index]);
              },
              title: Text(_data[index].name), // Wyświetlanie nazwy przystanku
            ),
          );
        },
      ),
    );
  }

  void _onSelectedBusStopFromList(BusstopInfo selectedBusStop) {
    setState(() {
      this.selectedBusStop = selectedBusStop;
    });
    fetchBusstopLines(selectedBusStop);
  }
}
