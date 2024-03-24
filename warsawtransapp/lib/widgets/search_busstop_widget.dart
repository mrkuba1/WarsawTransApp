import 'package:flutter/material.dart';

class BusStopsSearch extends StatefulWidget {
  const BusStopsSearch({super.key});

  @override
  _BusStopsSearchState createState() => _BusStopsSearchState();
}

class _BusStopsSearchState extends State<BusStopsSearch> {
  final TextEditingController _searchController = TextEditingController();
  // tutaj lista stringow z przystankami
  List<String> busStopsList = [
    // przykladowe przystanki
    "Nocznickiego",
    "Popiela",
    "Konradowicza",
    "Ratusz Arsenał",
    "Metro Młociny",
    "Metro Bemowo",
    "Metro Centrum",
    "Podkowińska",
    "Kościuszki Szkoła"
  ];
  List<String> filteredBusStopsList = [];

  @override
  void initState() {
    super.initState();
    // Domyślnie pokazujemy tylko 4 propozycje
    filteredBusStopsList = busStopsList.sublist(0, 4);
    _searchController.addListener(() {
      filterBusStopsList();
    });
  }

  // wyszukuje wszystie przystanki ktore aktualnie wpisywany skrot w sobie
  void filterBusStopsList() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      filteredBusStopsList = busStopsList.where((stop) {
        return stop.toLowerCase().contains(query);
      }).toList();

      // ograniczenie zeby byly wyswietlane w proponowanych tylko 4 przystanki
      if (filteredBusStopsList.length > 4) {
        filteredBusStopsList = filteredBusStopsList.sublist(0, 4);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Wpisz nazwe przystanku',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredBusStopsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(filteredBusStopsList[index]),
            onTap: () {
              // Po kliknięciu przystanku jego nazwa wskakuje do pola wpisywania
              _searchController.text = filteredBusStopsList[index];
              // Tutaj możesz dodać dodatkowe akcje po wybraniu przystanku
              print('Selected bus stop: ${filteredBusStopsList[index]}');
            },
          );
        },
      ),
    );
  }
}
