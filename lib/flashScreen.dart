import 'package:covid_19/Covid_Bloc/CovidWidget.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'Covid_Bloc/CovidBloc.dart';
import 'Covid_Bloc/CovidEvent.dart';

class FlashScreen extends StatefulWidget {
  @override
  _FlashScreenState createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  Bloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = CovidBloc();
    bloc.add(InittialEvent());
    Future.delayed(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CovidPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: SafeArea(
                  child: Container(
                    width: double.infinity,
                    color: Colors.lime,
                    child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('COVID 19', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                          Container(
                            height: 350,
                            width: 350,
                            child: FittedBox(child: Image.asset('assets/images/Covid.jpg'), fit: BoxFit.fill,),
                          ),
                          Text('Design by Tu Le', style: TextStyle(fontSize: 20),)
                        ],
                      ),

                  ),
                ),
    );
  }
}
