import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:moooviex/utits/constants.dart';
import 'package:moooviex/widgets/search_box.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SearchBox(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                ],
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
        ),
      ),
    );
  }
}
