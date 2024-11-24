import 'package:warsawtransapp/data/busstops/models/busstopdata.dart';
import 'package:warsawtransapp/data/lines/models/busline.dart';

class FavBusInfo {
  late final BusstopInfo busstopInfo;
  late final List<BusLine> busLines;

  FavBusInfo({
    required this.busstopInfo,
    required this.busLines,
  });
}
