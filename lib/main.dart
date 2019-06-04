import 'package:flutter/material.dart';
import 'package:boring_show/src/json_parsing.dart';
import 'src/articles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  Future<Article> _getArticle(int id) async{
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final storyRes = await http.get(storyUrl);
    if(storyRes.statusCode == 200) {
      return parseArticle(storyRes.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
          children: _ids.map((id) =>
              FutureBuilder<Article>(
                future: _getArticle(id),
                builder: (BuildContext context, AsyncSnapshot<Article> snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    return _buildItem(snapshot.data);
                  }else{
                    return Center(
                      child:
                      CircularProgressIndicator(),
                    );
                  }
                },

              )
          ).toList()
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.title),
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          article.title ?? '[null]',
          style: TextStyle(fontSize: 20.0),
          textAlign: TextAlign.justify,
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 58.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${article.descendants} comments',
                  style: TextStyle(fontSize: 15.0, color: Colors.blue),
                ),
                MaterialButton(
                  onPressed: () async {
                    if (await canLaunch(article.url)) {
                      await launch(article.url);
                    }
                  },
                  child: Text(
                    'Open',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blueAccent,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
