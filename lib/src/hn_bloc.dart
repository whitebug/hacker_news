import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:boring_show/src/articles.dart';
import 'package:boring_show/src/json_parsing.dart';
import 'dart:collection';

class HackerNewsBloc{

  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();

  var _articles = <Article>[];

  List<int> _ids = [
    20052623,
    20061764,
    20054831,
    20066288,
    20064169,
    20061078,
    20077421,
    20067712,
    20074653,
  ];
  

  HackerNewsBloc(){
    _updateArticles().then((_){
      _articlesSubject.add(UnmodifiableListView(_articles));
    });
  }

  Stream<List<Article>> get articles => _articlesSubject.stream;

  Future<Article> _getArticle(int id) async{
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final storyRes = await http.get(storyUrl);
    if(storyRes.statusCode == 200) {
      return parseArticle(storyRes.body);
    }
  }

  Future<Null> _updateArticles() async{
    final futureArticles = _ids.map((id) => _getArticle(id));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }

}