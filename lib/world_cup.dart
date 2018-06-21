import 'package:html_parse/dates.dart';

class WorldCup {
   String logo;
  List<Dates> _matches = new List();

  set add(Dates date) => _matches.add(date);

  get matches => _matches;
}
