import 'package:warsawtransapp/data/secrets.dart';

enum BusClientPath {
  busstopinfo,
  busstopsline,
  timetables;

  const BusClientPath();

  String get path {
    switch (this) {
      case BusClientPath.busstopsline:
        return '/api/action/dbtimetable_get/';
      case BusClientPath.timetables:
        return '/api/action/dbtimetable_get/';
      case BusClientPath.busstopinfo:
        return '/api/action/dbstore_get/';
    }
  }

  Uri get baseUri => Uri.https(
        'api.um.warszawa.pl',
        '',
        <String, dynamic>{
          'apikey': Secrets.busApiKey,
        },
      );

  Uri getUriBus(String? busstopID, String? busstopIDsmall) {
    return Uri.https(
      baseUri.authority,
      path,
      {
        'id': '88cd555f-6f31-43ca-9de4-66c479ad5942',
        'busstopId': busstopID,
        'busstopNr': busstopIDsmall,
      }..addAll(baseUri.queryParameters),
    );
  }

  Uri getUriBusInfo() {
    return Uri.http(
      baseUri.authority,
      path,
      {
        'id': 'ab75c33d-3a26-4342-b36a-6e5fef0a3ac3',
      }..addAll(baseUri.queryParameters),
    );
  }

  Uri getUriRoute(String? busstopID, String? busstopIDsmall, String? line) {
    return Uri.https(
      baseUri.authority,
      path,
      {
        'id': 'e923fa0e-d96c-43f9-ae6e-60518c9f3238',
        'busstopId': busstopID,
        'busstopNr': busstopIDsmall,
        'line': line,
      }..addAll(baseUri.queryParameters),
    );
  }
}
