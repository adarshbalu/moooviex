import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moooviex/bloc/bloc.dart';
import 'package:moooviex/models/movie.dart';

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
          else if (state is MovieError)
            return buildError(state.message);
          else
            return SizedBox();
        },
      ),
    );
  }

  Widget buildInitial() {
    return CircularProgressIndicator();
  }

  Widget buildError(String message) {
    return Center(
      child: Text(message),
    );
  }

  buildResults(BuildContext context, Movie movie) {
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter:
                  ColorFilter.mode(Colors.grey.shade300, BlendMode.screen),
              fit: BoxFit.cover,
              image: NetworkImage(movie.posterURL),
            ),
          ),
          child: Stack(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.8,
              ),
              Positioned.fill(
                bottom: 40,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(movie.posterURL),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    height: MediaQuery.of(context).size.height / 2.7,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Positioned.fill(
                top: 10,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2.0,
            ),
            child: Text(
              movie.imdbRating,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87),
            ),
          ),
        ),
        Center(
          child: buildRatingStar(
              int.parse(double.parse(movie.imdbRating).round().toString())),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DetailWidget(
              detail: 'Length',
              value: movie.runTime,
            ),
            DetailWidget(
              detail: 'Language',
              value: movie.language,
            ),
            DetailWidget(
              detail: 'Year',
              value: movie.year,
            ),
            DetailWidget(
              detail: 'Country',
              value: movie.country,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Storyline',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15),
          child: Text(movie.plot),
        )
      ],
    );
  }

  Widget buildRatingStar(int value) {
    List<Widget> stars = [];
    Color color = Colors.yellow.shade700;
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

class DetailWidget extends StatelessWidget {
  final String detail, value;
  const DetailWidget({
    Key key,
    this.detail,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          detail,
          style: TextStyle(color: Colors.grey, fontSize: 17),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ],
    );
  }
}
