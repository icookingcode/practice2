import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'movie_detail.dart';
import 'detail_net.dart';

class MovieList extends StatefulWidget {
  ///in_theaters :正在热映  coming_soon:即将上映 top250 ： Top250
  final String type;

  MovieList({Key key, @required this.type}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList>
    with AutomaticKeepAliveClientMixin {
  Dio _dio;
  int page = 1;
  int pageSize = 10;
  var mList = [];
  int total = 0;
  bool hasMore = false;

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    getMovieList();
  }

  Widget _movieItem(BuildContext context, int index) {
    var item = mList[index];
    List casts = item['casts'];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MovieDetail(
            item: item,
          );
        }));
      },
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 8.0),
                child: Image.network(
                  item['images']['small'],
                  height: 180,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 200,
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('电影名称：${item['title']}'),
                    Text('上映年份：${item['year']}年'),
                    Text('电影类型：${item['genres'].join('.')}'),
                    Text('豆瓣评分：${item['rating']['average']}分'),
                    Row(
                      children: <Widget>[
                        Text('主要演员：'),
                        Wrap(
                          spacing: 8.0,
                          children: casts
                              .map((item) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return DetailFromNet(
                                          title: item['name'],
                                          url: item['alt'],
                                        );
                                      }));
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            item['avatars']['small']),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 2,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    return Text('这是电影列表 + ${widget.type} + ${mList.length}/$total');
    return ListView.builder(
      itemBuilder: _movieItem,
      itemCount: mList.length,
    );
  }

  ///http://www.liulongbin.top:3005/api/v2/movie/${widget.type}?start=偏移量&count=每页显示多少条数据
  getMovieList() async {
    var response = await _dio.get(
        'http://www.liulongbin.top:3005/api/v2/movie/${widget.type}?start=${(page - 1) * pageSize}&count=$pageSize');
    var result = response.data;
    setState(() {
      //通过dio返回的数据必须用中括号引用
      mList = result['subjects'];
      total = result['total'];
    });
  }

  @override
  bool get wantKeepAlive => true;
}
