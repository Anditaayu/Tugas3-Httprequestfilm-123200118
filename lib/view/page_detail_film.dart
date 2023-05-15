import 'package:flutter/material.dart';
import 'package:tugas3_123200118_httprequest/controller/api_data_source.dart';
import 'package:tugas3_123200118_httprequest/model/detail_film.dart';

class PageDetailFilms extends StatefulWidget {
  final String imdbId;

  const PageDetailFilms({Key? key, required this.imdbId}) : super(key: key);
  @override
  State<PageDetailFilms> createState() => _PageDetailFilmsState();
}

class _PageDetailFilmsState extends State<PageDetailFilms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Film"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadDetailFilm(widget.imdbId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            FilmDetail filmModel = FilmDetail.fromJson(snapshot.data);
            return _buildItemUsers(filmModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildItemUsers(FilmDetail filmModel) {
    return SafeArea(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Image.network(filmModel.poster!, width: 170, height: 200),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                filmModel.title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Year: " + filmModel.year!),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Data Released: " + filmModel.released!),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Runtime: " + filmModel.runtime!),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Genre: " + filmModel.genre!),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Director: " + filmModel.director!),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Writers: " + filmModel.writer!),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Actors: " + filmModel.actors!),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Plot: " + filmModel.plot!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
