import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19'),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text('World:'),
                Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Total:'),
                      Text('a'),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Death:'),
                      Text('a'),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Recover:'),
                      Text('a'),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Viet Nam:'),
                Container(
                  child: Text('Total'),
                ),
                Container(
                  child: Text('Death'),
                ),
                Container(
                  child: Text('Recover'),
                )
              ],
            )
          ],

        ),
      ),
    );
  }
}

Widget _buildItiem(int mount, String name, BuildContext context){
  return Container(
    child: Column(
      children: [
        Row(
          children: [
            Text(name),
            Container(
              width: MediaQuery.of(context).size.width/4,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total:'),
                  Text(mount.toString()),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/4,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Death:'),
                  Text('a'),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/4,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Recover:'),
                  Text('a'),
                ],
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(bottom: 20),)
      ],
    ),
  );

}