import 'dart:convert' as json;
import 'package:boring_show/src/articles.dart';
import 'serializers.dart';

List<int> parseTopStories(String jsonString){
  final parsed = json.jsonDecode(jsonString);
  final listOfIds = List<int>.from(parsed);
  return listOfIds;
}

Article parseArticle(String jsonStr){
  final parsed = json.jsonDecode(jsonStr);
  Article article =
    standardSerializers.deserializeWith(Article.serializer, parsed);
  return article;
}