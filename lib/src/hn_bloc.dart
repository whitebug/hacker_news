import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:boring_show/src/articles.dart';
import 'package:boring_show/src/json_parsing.dart';
import 'dart:collection';

enum StoriesType{
  topStories,
  newStories,
}

class HackerNewsBloc{

  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();

  var _articles = <Article>[];

  Sink<StoriesType> get storiesType => _storiesTypeController.sink;

  final _storiesTypeController = StreamController<StoriesType>();

  static List<int> _topIds = [
    20061078,
    20077421,
    20067712,
    20074653,
  ];

  static List<int> _newIds = [
    20052623,
    20061764,
    20054831,
    20066288,
    20064169,
  ];


  HackerNewsBloc(){
    _getArticlesAndUpdate(_topIds);
    _storiesTypeController.stream.listen((storiesType){
      if(storiesType == StoriesType.newStories){
        _getArticlesAndUpdate(_newIds);
      }else{
        _getArticlesAndUpdate(_topIds);
      }
    });
  }

  _getArticlesAndUpdate(List<int> ids){
    _updateArticles(ids).then((_){
      _articlesSubject.add(UnmodifiableListView(_articles));
    });

  }

  Stream<UnmodifiableListView<Article>> get articles => _articlesSubject.stream;

  Future<Article> _getArticle(int id) async{
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final storyRes = await http.get(storyUrl);
    if(storyRes.statusCode == 200) {
      return parseArticle(storyRes.body);
    }
  }

  Future<Null> _updateArticles(List<int> articleIds) async{
    final futureArticles = articleIds.map((id) => _getArticle(id));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }

}