import 'dart:collection';

import 'package:boring_show/src/hn_bloc.dart';
import 'package:flutter/material.dart';
import 'package:boring_show/src/articles.dart';
import 'package:url_launcher/url_launcher.dart';

void main(){
  final hnBloc = HackerNewsBloc();
  runApp(MyApp(bloc: hnBloc,));
}

class MyApp extends StatelessWidget {
  final HackerNewsBloc bloc;

  MyApp({
    Key key,
    this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page',bloc: bloc,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final HackerNewsBloc bloc;
  MyHomePage({Key key, this.title, this.bloc}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
        stream: widget.bloc.articles,
        initialData: UnmodifiableListView<Article>([]),
        builder: (context,snapshot) => ListView(
          children: snapshot.data.map(_buildItem).toList(),
        ),
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
