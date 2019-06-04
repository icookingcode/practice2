import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MovieDetail extends StatefulWidget {
  var item;

  MovieDetail({Key key, @required this.item}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  var movie ={};
  @override
  void initState() {
    super.initState();
    getMovieDetail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['title']),
      ),
      body: Text('${movie['title']}'),
    );
  }

  ///http://www.liulongbin.top:3005/api/v2/movie/subject/电影Id
  void getMovieDetail() async {
    var response = await Dio().get(
        'http://www.liulongbin.top:3005/api/v2/movie/subject/${widget.item['id']}');
    var result = response.data;
    setState(() {
      movie = result;
    });
  }
}
