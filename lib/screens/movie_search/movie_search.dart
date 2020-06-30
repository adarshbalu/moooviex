import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moooviex/bloc/movie_bloc.dart';
import 'package:moooviex/bloc/movie_event.dart';
import 'package:moooviex/bloc/movie_state.dart';
import 'package:moooviex/models/movie.dart';
import 'package:moooviex/screens/home/home_screen.dart';
import 'package:moooviex/screens/movie_details/movie_details.dart';
import 'package:moooviex/utits/constants.dart';

class MovieSearchPage extends StatefulWidget {
  final String title, year, type;
  final int page;

  const MovieSearchPage({Key key, this.title, this.year, this.type, this.page})
      : super(key: key);
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final TextEditingController controller = TextEditingController();
  final _fullSearchKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<MovieBloc>(context)
      ..add(SearchMovies(
        page: widget.page,
        year: widget.year,
        title: widget.title,
        type: widget.type,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading)
            return buildInitial();
          else if (state is MovieSearched)
            return showResults(context, state.moviesFound);
          else
            return HomeScreen();
        },
      ),
    );
  }

  Widget buildInitial() {
    return Center(child: CircularProgressIndicator());
  }

  Widget showResults(BuildContext context, List<Movie> moviesFound) {
    String type = 'all';
    String year = '';
    return Form(
      key: _fullSearchKey,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15, 15, 15, 8),
              alignment: Alignment.center,
              color: Colors.white,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  errorStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (v) {
                  _fullSearchKey.currentState.validate();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter keyword to search';
                  }

                  if (value.length < 3) {
                    return 'Please enter more than 3 characters';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(8, 10, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 3,
                        minHeight: 50,
                        maxHeight: 70),
                    child: TextFormField(
                      initialValue: year,
                      onChanged: (v) {
                        year = v;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Year',
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorStyle: TextStyle(color: Colors.grey),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isNotEmpty) if (value.length != 4) {
                          return 'Please enter valid year';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 3,
                        maxHeight: 70,
                        minHeight: 50),
                    child: DropdownButton(
                      value: type,
                      onChanged: (v) {
                        type = v;
                      },
                      elevation: 0,
                      underline: SizedBox(),
                      dropdownColor: Colors.grey.shade100,
                      focusColor: Colors.red,
                      items: [
                        DropdownMenuItem(
                          child: Text('All'),
                          value: 'all',
                        ),
                        DropdownMenuItem(
                          child: Text('Movie'),
                          value: 'movie',
                        ),
                        DropdownMenuItem(
                          child: Text('Series'),
                          value: 'series',
                        ),
                        DropdownMenuItem(
                          child: Text('Episode'),
                          value: 'episode',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 9,
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: RaisedButton.icon(
                color: Color(0xff4A148C),
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  if (_fullSearchKey.currentState.validate())
                    startSearch(
                        context: context,
                        title: controller.text,
                        page: 1,
                        type: type,
                        year: year);
                  else
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.grey.shade200,
                        content: Text(
                          'Enter required fields',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                },
                icon: Icon(Icons.search),
                label: Text(
                  'Search',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Movies and Series',
                    style: kHeading,
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: moviesFound.length,
                itemBuilder: (ctx, index) {
                  return Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<MovieBloc>(context),
                                child: MovieDetailsPage(
                                  movieData: moviesFound[index],
                                ),
                              ),
                            ));
                          },
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: Text(moviesFound[index].title),
                          ),
                          leading: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      moviesFound[index].posterURL,
                                    ))),
                            child: SizedBox(
                              height: 50,
                              width: 50,
                            ),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(moviesFound[index].year),
                              Text(
                                ' (' + moviesFound[index].type + ')',
                              )
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startSearch(
      {BuildContext context,
      String title,
      String year,
      int page,
      String type}) {
    // ignore: close_sinks
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    movieBloc
        .add(SearchMovies(title: title, year: year, page: page, type: type));
  }
}
