import 'package:flutter/material.dart';
import 'package:html_parse/home_contract.dart';
import 'package:html_parse/match_Item.dart';
import 'package:html_parse/world_cup.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    implements HomeContract {
  HomePresenter _homePresenter;
  WorldCup _worldCup;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homePresenter = HomePresenter(this);
    _homePresenter.fetchFifaWeb();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: new Text(widget.title),
          expandedHeight: 200.0,
          pinned: true,
          titleSpacing: 10.0,
          centerTitle: false,
          flexibleSpace: new PreferredSize(
            child: new Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/background.png",
                        ))),
                child: new Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new Center(
                    child: new Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      height: 100.0,
                    ),
                  ),
                )),
            preferredSize: Size(null, 200.0),
          ),
        ),
        _isLoading
            ? SliverFillRemaining(
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                (context, index) => new MatchItem(_worldCup.matches[index]),
                childCount: _worldCup.matches.length,
              ))
      ],
    ));
  }

  @override
  onLoadingFailure(String err) {
    // TODO: implement onLoadingFailure
    setState(() {
      _isLoading = false;
    });
  }

  @override
  onLoadingSuccess(WorldCup worldCup) {
    print(worldCup.logo);
    setState(() {
      _isLoading = false;
      _worldCup = worldCup;
    });
  }
}
