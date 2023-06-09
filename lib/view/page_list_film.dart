import 'package:tugas3_123200118_httprequest/view/page_detail_film.dart';
import '../controller/api_data_source.dart';
import '../model/list_film.dart';
import 'package:flutter/material.dart';

class PageListFilms extends StatefulWidget {
  final String text;
  const PageListFilms({Key? key, required this.text}) : super(key: key);
  @override
  State<PageListFilms> createState() => _PageListFilmsState();
}

class _PageListFilmsState extends State<PageListFilms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Film"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadListFilm(widget.text),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            FilmList filmModel = FilmList.fromJson(snapshot.data);
            return _buildSuccessSection(filmModel);
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

  Widget _buildSuccessSection(FilmList filmModel) {
    return ListView.builder(
      itemCount: filmModel.search!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(filmModel.search![index]);
      },
    );
  }

  Widget _buildItemUsers(Search film) {
    return InkWell(
       onTap: () => Navigator.push(
           context,
           MaterialPageRoute(
               builder: (context) => PageDetailFilms(imdbId: film.imdbID!)
           )
        ),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(film.poster!),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(film.title!),
                Text(film.year!)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
