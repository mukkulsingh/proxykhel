import 'package:flutter/material.dart';
import './../temp/createContest.dart';

class TabBarFootball extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateContest()));
            },
            child: new Card(
              elevation: 4,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Image.asset(
                        'assets/images/odi-logo.png',
                        height: 55.0,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        'assets/images/eng.png',
                        width: 55.0,
                        height: 55.0,
                      ),
                      new Text('ENG')
                    ],
                  ),
                  new SizedBox(
                    width: 10.0,
                  ),
                  new Text(
                    '2h 11m 7s',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  new SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        'assets/images/ind.png',
                        width: 55.0,
                        height: 55.0,
                      ),
                      new Text('IND')
                    ],
                  ),
                  new SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text('Contest'),
                      new Text(
                        '20+',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
//                          new Text('Context 20+'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}