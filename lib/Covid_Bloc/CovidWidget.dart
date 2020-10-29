import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CovidBloc.dart';
import 'CovidEvent.dart';
import 'CovidState.dart';
import 'package:translator/translator.dart';

class CovidPage extends StatefulWidget {
  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  Bloc bloc;
  TextEditingController searchController;
  final translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    bloc = CovidBloc();
    bloc.add(InittialEvent());
    // const tenSec = const Duration(seconds:2);
    // new Timer.periodic(tenSec, (Timer t) =>  bloc.add(InittialEvent()));
    // final translator = GoogleTranslator();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID 19"),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: BlocBuilder<CovidBloc, CovidState>(
              cubit: bloc,
              builder: (context, state) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      _buildItiem('World', state.totalGlobal, state.deathGlobal,
                          state.recoverGlobal, context),
                      _buildItiem('Viet Nam', state.totalVN, state.deathVN,
                          state.recoverVN, context),
                      state.loading == true
                          ? Container(
                              height: 50,
                              width: 50,
                              child: Platform.isIOS
                                  ? CupertinoActivityIndicator()
                                  : CircularProgressIndicator,
                            )
                          : Container(),
                      Text('Other Country'),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(hintText: 'Search'),
                              onChanged: (text) async {
                                // var translation = await translator
                                //     .translate(text, from: 'vi', to: 'en');
                                // String textTranslation = translation.toString();
                                bloc.add(SearchCountryEvent(
                                    textSearch: text.toString()));
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              bloc.add(SearchCountryEvent(
                                  textSearch: searchController.text));
                            },
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                          ),
                          (state.listCountriesSearch == null ||
                                  state.listCountriesSearch.isEmpty ||
                                  state.listCountriesSearch.length == 0)
                              ? Container()
                              : Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width - 15,
                                  child: LimitedBox(
                                    maxHeight: 150,
                                    child: ListView.builder(
                                        itemCount:
                                            state.listCountriesSearch.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // List <dynamic> listCountriesInVN = [];
                                          //     var a = translationListCountriesInVN(state.listCountriesSearch[index]
                                          //     ['Country']);
                                          //     print(a);
                                          // var a = await translator.translate(
                                          //     state.listCountriesSearch[index]
                                          //         ['Country'],from: 'en', to: 'vi');
                                          // listCountriesInVN.add(a);
                                          return InkWell(
                                            child: Container(
                                                width: 100,
                                                child: Text(state.listCountriesSearch[index],
                                                  // state.listCountriesSearch[index],
                                                  // var a = await translator.translate(state.listCountriesSearch[index]
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )),
                                            onTap: () {
                                              // var textSelect = state.country;
                                              searchController.text =
                                                  state.listCountriesSearch[
                                                      index]['Country'];
                                              bloc.add(ChoseItemSearchEvent(
                                                  textChose: state.listCountriesSearch[
                                                  index]
                                              ));
                                              setState(() {
                                                // state.loading == true;
                                              });
                                            },
                                          );
                                        }),
                                  ),
                                ),
                        ],
                      ),
                      _buildItiem(state.country, state.totalCountry,
                          state.deathCountry, state.recoverCountry, context),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

Widget _buildItiem(
    String country, int total, int death, int recover, BuildContext context) {
  return Center(
    // width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5),
            ),
            Container(width: 70, child: Text(country)),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total:'),
                  // Text(total.toString()),
                  Text('$total'),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Death:'),
                  Text('$death'),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Recover:'),
                  Text(recover.toString()),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5),
        )
      ],
    ),
  );
}

Future<void> translationListCountriesInVN(String input) async {
  final translator = GoogleTranslator();
  var translation = await translator.translate(input, from: 'en', to: 'vi');
  return translation.toString();
}