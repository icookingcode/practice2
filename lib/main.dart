import 'package:flutter/material.dart';
import 'movie/movie_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '电影列表'),
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('guc'),
                accountEmail: Text('happygc@126.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'http://m.qpic.cn/psb?/V14eDJ0U1Q9jx2/pbvagXSYO0s1LlvCwygDgmlU48S7Ov34CkOSGIuPDE8!/b/dMUAAAAAAAAA&bo=tAO0AwAAAAARBzA!&rf=viewer_4'),
                ),
                decoration: BoxDecoration(
                  //背景图片
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'http://m.qpic.cn/psb?/V14eDJ0U1Q9jx2/pbvagXSYO0s1LlvCwygDgmlU48S7Ov34CkOSGIuPDE8!/b/dMUAAAAAAAAA&bo=tAO0AwAAAAARBzA!&rf=viewer_4')),
                ),
              ),
              ListTile(
                title: Text('用户反馈'),
                trailing: Icon(Icons.feedback),
              ),
              ListTile(
                title: Text('系统设置'),
                trailing: Icon(Icons.settings),
              ),
              ListTile(
                title: Text('我要发布'),
                trailing: Icon(Icons.send),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: Text('注销'),
                trailing: Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.black),
          height: 50,
          child: TabBar(
            indicatorWeight: 2,
            labelStyle: TextStyle(height: 0,fontSize: 10),
            tabs: [
              Tab(
                icon: Icon(Icons.movie_filter),
                text: '正在热映',
              ),
              Tab(
                icon: Icon(Icons.movie_creation),
                text: '即将上映',
              ),
              Tab(
                icon: Icon(Icons.local_movies),
                text: 'Top250',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          MovieList(type: 'in_theaters',),
          MovieList(type: 'coming_soon',),
          MovieList(type: 'top250',),
        ]),
      ),
    );
  }
}
