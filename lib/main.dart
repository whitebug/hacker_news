import 'dart:collection';
import 'package:boring_show/src/hn_bloc.dart';
import 'package:flutter/material.dart';
import 'package:boring_show/src/articles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      home: MyHomePage(title: 'Flutter Hacker News',bloc: bloc,),
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
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: LoadingInfo(widget.bloc.isLoading),
        ),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
        stream: widget.bloc.articles,
        initialData: UnmodifiableListView<Article>([]),
        builder: (context,snapshot) => ListView(
          children: snapshot.data.map(_buildItem).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              title: Text('Top Stories'),
              icon: Icon(Icons.airplay),
            ),
            BottomNavigationBarItem(
              title: Text('New Stories'),
              icon: Icon(Icons.new_releases),
            )
          ],
        onTap: (index){
          if(index == 0){
            widget.bloc.storiesType.add(StoriesType.topStories);
          }else{
            widget.bloc.storiesType.add(StoriesType.newStories);
          }
          setState(() {
            _currentIndex = index;
          });
        },
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

class LoadingInfo extends StatelessWidget {
  final Stream<bool> _isLoading;
  LoadingInfo(this._isLoading);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _isLoading,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        /*if (snapshot.hasData && snapshot.data){*/
          return Icon(FontAwesomeIcons.hackerNewsSquare);
        /*}else{
          return Container();
        }*/
      },
    );
  }
}

