import 'package:flutter/material.dart';

void main() => runApp(Test());

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            )
        ),
        child: new Scaffold(
          backgroundColor: Colors.transparent,
          body: new Center(

            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
            new Container(
            margin: EdgeInsets.only(top:30.0),
            child: Image.asset('assets/images/logo.png'),
          ),
                  new TextField(
                    decoration: InputDecoration(
                        labelText: 'Example',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                    ),
                  ),
                  new TextField(
                    decoration: InputDecoration(
                        labelText: 'Example',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                    ),
                  ),
                  new TextField(
                    decoration: InputDecoration(
                        labelText: 'Example',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                    ),
                  ),
                  new TextField(
                    decoration: InputDecoration(
                        labelText: 'Example',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                    ),
                  ),
                  new RaisedButton(
                      child: Text('sin'),
                      onPressed: (){}
                  )
            ],
          ),
        ),
      ),
    ),
    );
  }
}
