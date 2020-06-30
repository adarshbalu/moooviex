import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moooviex/bloc/bloc.dart';
import 'package:moooviex/models/movie.dart';
import 'package:moooviex/utits/constants.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movieData;
  const MovieDetailsPage({Key key, this.movieData}) : super(key: key);
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<MovieBloc>(context)
      ..add(GetMovieDetails(
        posterURL: widget.movieData.posterURL,
        year: widget.movieData.year,
        title: widget.movieData.title,
        imdbID: widget.movieData.imdbID,
        type: widget.movieData.type,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoaded)
            return buildResults(context, state.movie);
          else if (state is MovieLoading)
            return buildLoading();
          else
            return SizedBox();
        },
      ),
    );
  }

  buildInitial() {
    return Container();
  }

  buildResults(BuildContext context, Movie movie) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(movie.posterURL))),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
          ),
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        movie.title,
                        textAlign: TextAlign.left,
                        style: kHeading,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildRatingStar(double.parse(movie.imdbRating).toInt()),
                        SizedBox(
                          width: 8,
                        ),
                        Text('${movie.imdbRating} IMDb')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(movie.genre),
                        Text('|'),
                        Text(movie.runTime),
                        Text('|'),
                        Text(movie.year)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(movie.plot),
                    ),
                    Divider(
                      thickness: 1,
                      indent: 15,
                      endIndent: 15,
                    ),
                    ListTile(
                      title: Text(movie.actors),
                      subtitle: Text('Actors'),
                    ),
                    ListTile(
                      title: Text(movie.director),
                      subtitle: Text('Director'),
                    ),
                    ListTile(
                      title: Text(movie.writer),
                      subtitle: Text('Writer'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRatingStar(int value) {
    List<Widget> stars = [];
    Color color = Colors.yellow;
    if (value == 10) {
      for (int i = 0; i < 5; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
    } else if (value == 9) {
      for (int i = 0; i < 4; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
    } else if (value == 8) {
      for (int i = 0; i < 4; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 7) {
      for (int i = 0; i < 3; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 6) {
      for (int i = 0; i < 3; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 5) {
      for (int i = 0; i < 2; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 4) {
      for (int i = 0; i < 2; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 3) {
      stars.add(Icon(
        Icons.star,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 2) {
      stars.add(Icon(
        Icons.star,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else {
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
