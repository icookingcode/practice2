import 'package:flutter/material.dart';
class MovieList extends StatefulWidget {
  ///in_theaters :正在热映  coming_soon:即将上映 top250 ： Top250
  final String type;
  MovieList({Key key,@required this.type}):super(key:key);
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Text('这是电影列表 + ${widget.type}');
  }
}
