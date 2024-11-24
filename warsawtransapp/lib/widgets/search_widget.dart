import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:warsawtransapp/data/busstops/models/busstopdata.dart';
import 'package:warsawtransapp/data/busstops/models/busstopsinfo.dart';
import 'package:warsawtransapp/data/lines/models/busstoplines.dart';

class SearchWithSuggestionsWidget extends StatefulWidget {
  final BusstopsInfo busstopsInfo;
  final Function(BusstopInfo) onSuggestionSelectedCallback;

  const SearchWithSuggestionsWidget({
    Key? key,
    required this.busstopsInfo,
    required this.onSuggestionSelectedCallback,
  }) : super(key: key);

  @override
  _SearchWithSuggestionsWidgetState createState() =>
      _SearchWithSuggestionsWidgetState();
}

class _SearchWithSuggestionsWidgetState
    extends State<SearchWithSuggestionsWidget> {
  final TextEditingController _typeAheadController = TextEditingController();
  BusstopInfo? _selectedBusStop;
  BusstopLines? busstopLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField<BusstopInfo>(
        suggestionsCallback: (search) async {
          final busStops = widget.busstopsInfo
              .getBusstopsInfoByName(search); // Użyj widget.busstopsInfo
          return busStops;
        },
        itemBuilder: (context, BusstopInfo suggestion) {
          return ListTile(
            title: Text(suggestion.name),
            subtitle:
                Text('Id: ${suggestion.id} smallId: ${suggestion.smallid}'),
          );
        },
        onSuggestionSelected: (BusstopInfo suggestion) async {
          setState(() {
            _selectedBusStop = suggestion;
            _typeAheadController.text =
                '${_selectedBusStop?.name ?? ''} (Id: ${_selectedBusStop?.id}, SmallId: ${_selectedBusStop?.smallid})';
          });

          widget.onSuggestionSelectedCallback(
              _selectedBusStop!); // Przekazanie wybranego przystanku do nadklasy
        },
        noItemsFoundBuilder: (context) {
          return const ListTile(
            title: Text('No bus stops found'),
          );
        },
        textFieldConfiguration: TextFieldConfiguration(
          controller: _typeAheadController,
          decoration: const InputDecoration(
            labelText: 'Search Bus Stops',
          ),
        ),
      ),
    );
  }

  void _onSuggestionSelected(BusstopInfo selectedBusStop) {
    widget.onSuggestionSelectedCallback(selectedBusStop);
  }
}
