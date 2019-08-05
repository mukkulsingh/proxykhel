import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Profile',style: TextStyle(color: Colors.white),),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new CircleAvatar(
              child: Image(image: AssetImage('./../../assets/image/empty-avatar.png')),
            )
          ],
        ),
      ),
    );
  }
}
