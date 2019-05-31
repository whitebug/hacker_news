import 'package:flutter/material.dart';
import 'src/articles.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<Article> _articles = articles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          await new Future.delayed(const Duration(seconds: 1));
          setState(() {
            _articles.removeAt(0);
          });
          return;
        },
        child: ListView(
                children: _articles.map(_buildItem).toList()
              ),
      ),
    );
  }

  Widget _buildItem(Article article) {

    return Padding(
      key: Key(article.text),
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          article.text,
          style: TextStyle(fontSize: 20.0),
          textAlign: TextAlign.justify,
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 18.0,right: 58.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${article.commentsCount} comments',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blue
                  ),
                ),
                MaterialButton(
                  onPressed: () async{
                    final fakeUrl = 'http://${article.domain}';
                    if(await canLaunch(fakeUrl)){
                      await launch(fakeUrl);
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
