import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moooviex/bloc/bloc.dart';
import 'package:moooviex/models/movie.dart';
import 'package:moooviex/screens/movie_details/movie_details.dart';
import 'package:moooviex/utits/constants.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final _fullSearchKey = GlobalKey<FormState>();
  final _searchKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieInitial)
                return buildInitial(context);
              else if (state is MovieLoading)
                return buildLoading();
              else if (state is MovieSearched)
                return buildSearchResult(context, state.moviesFound);
              else
                return buildInitial(context);
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildInitial(BuildContext context) {
    String type = 'all';
    String year = '';
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Form(
            key: _fullSearchKey,
            child: Stack(
              children: <Widget>[
                Column(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.3,
                ),
              ],
            ),
          ),
          Center(
            child: Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 4,
                child: Image.asset(kSearchImage)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Explore the library',
              style: kHeading,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 0, 8, 8),
            child: Text(
              'Search for any Movie , TV Series or Episodes.',
              style: kBodyText,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget buildSearchResult(BuildContext context, List<Movie> moviesFound) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 15, 8),
          alignment: Alignment.center,
          color: Colors.white,
          child: Form(
            key: _searchKey,
            child: TextFormField(
              controller: controller,
              onFieldSubmitted: (v) {
                if (_searchKey.currentState.validate())
                  startSearch(
                      context: context, title: v, type: '', year: '', page: 1);
              },
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
              Spacer(),
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
