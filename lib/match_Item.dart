import 'package:flutter/material.dart';
import 'package:html_parse/dates.dart';
import 'package:html_parse/teams.dart';
import 'package:intl/intl.dart';

class MatchItem extends StatelessWidget {
  const MatchItem(this.entry);

  final dynamic entry;

  Widget _buildTiles(Dates root) {
    if (root.matches.isEmpty)
      return new ListTile(title: new Text(root.date.replaceAll("\n", "")));
    return new ExpansionTile(
     // leading: new Icon(Icons.data_usage),
      //trailing: new Icon(Icons.data_usage),
      key: new PageStorageKey<Dates>(root),
      title: new Container(
          child: new Text(
              root.date.replaceAll(new RegExp(r"\s+\b|\b\s"), " ").trim())),
      children: root.matches.map(_buildCard).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (entry is Dates)
      return _buildTiles(entry);
    else
      return _buildCard(entry);
  }

  Widget _buildCard(Teams entry) {
    DateFormat format = new DateFormat("dd MMM yyyy  hh:mm");
    var formatDate = format.parse(entry.time
        .replaceAll("Local time", "")
        .replaceAll(new RegExp(r"\s+\b|\b\s"), " ")
        .replaceAll("-", "")
        .trim());

    return new Card(
        elevation: 5.0,
        margin: const EdgeInsets.all(8.0),
        child: new Container(
            child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(""),
              ),
              SizedBox(height: 10.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new Image.network(entry.homeFlag, width: 100.0),
                        SizedBox(height: 10.0),
                        new Text(entry.homeName),
                      ],
                    ),
                  ),
                  new Text(entry.score.replaceAll("\n", ""),
                      style: TextStyle(fontSize: 24.0)),
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new Image.network(entry.awayFlag, width: 100.0),
                        SizedBox(height: 10.0),
                        new Text(entry.awayName),
                      ],
                    ),
                  ),
                ],
              ),
              ListTile(
                trailing: new Text(
                  entry.group,
                  style: TextStyle(color: Colors.black38),
                ),
                title: new Text("${formatDate.hour}:${formatDate.minute}0",
                    style: TextStyle(color: Colors.black54)),
              )
            ],
          ),
        )));
  }
}
