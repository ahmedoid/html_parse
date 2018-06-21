import 'package:html/parser.dart' show parse;
import 'package:html_parse/dates.dart';
import 'package:html_parse/teams.dart';
import 'package:html_parse/world_cup.dart';
import 'package:http/http.dart' as http;
abstract class HomeContract {
  onLoadingSuccess(WorldCup dox);

  onLoadingFailure(String err);
}

class HomePresenter {
  HomeContract _view;

  HomePresenter(this._view);

  fetchFifaWeb() async
  {
    final response =
        await http.get('https://www.fifa.com/worldcup/matches/#groupphase');
    var data = parse(response.body).body;
    if(data != null)
    {
      WorldCup worldCup = new WorldCup();
      String homeFlag, homeName, awayFlag, awayName,status,score,group,time;
      worldCup.logo = data
          .getElementsByClassName(
          'fi-section-header__emblem__img emblem-workaround')[0]
          .attributes['src'];
      var matches = data.querySelector(".fi-matchlist");
      matches.children.forEach((match) {
        if (match.getElementsByClassName('fi-mu-list__head').length > 0) {
          Dates dates = new Dates();
          dates.date =
              match.getElementsByClassName('fi-mu-list__head__date').first.text;
          match.getElementsByClassName('fi-mu__m').forEach((details) {
            details.children.forEach((f) {
               status = f.querySelector('.period') != null
                  ? f.querySelector('.period').text
                  : "dp";
               //print(status);
              if (f.className.contains('fi-s-wrap')) {
                 score = f.querySelector(
                    'div.fi-s__score.fi-s__date-HHmm > span.fi-s__scoreText') !=
                    null
                    ? f
                    .querySelector(
                    'div.fi-s__score.fi-s__date-HHmm > span.fi-s__scoreText')
                    .text
                    : "99";

              }
               group =  (f.parent.parent.querySelectorAll(".fi__info__group")[0].text.toString());
               time =  (f.parent.parent.querySelector(".fi-mu__info__datetime").text.toString());
               print(time);
              if (f.className.contains('fi-t fi-i--4 home')) {
                homeFlag = f.querySelector('div > img').attributes['src'];
                homeName = f.querySelector('div > span').text;
                //print("$flag \n name $name");
              }
              if (f.className.contains('fi-t fi-i--4 away')) {
                awayFlag = f.querySelector('div > img').attributes['src'];
                awayName = f.querySelector('div > span').text;
                //print("$awayName \n name $awayFlag");
              }
            });
            Teams teames = new Teams(
                homeName: homeName,
                homeFlag: homeFlag,
                awayName: awayName,
                awayFlag: awayFlag,
                group: group,
                score: score,
                time: time,
               );
            dates.matches.add(teames);
          });
          worldCup.add = dates;
        }
      });
/*
      worldCup.matches.forEach((Dates f) {
        print('${f.date.replaceAll('\n', '').trim()}');
        f.matches.forEach((Teames f) {
          print("${f.homeName} vs ${f.awayName}");
        });
      });*/

      _view.onLoadingSuccess(worldCup);
    }
    else
      _view.onLoadingFailure("Error");
//    var logo = document
//        .getElementsByClassName(
//        'fi-section-header__emblem__img emblem-workaround')[0]
//        .attributes['src'];
//    print(logo);
  }
}
