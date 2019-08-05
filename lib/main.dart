import "package:flutter/material.dart";
import './Controller/login.controller.dart';
import './Views/login.view.dart';
import './Views/dashboard.view.dart';
import './Constants/theme.dart' as Theme;
void main() async {
  bool isLoggedIn = await Controller.instance.isLoggedIn();
  if(isLoggedIn){
    runApp(DashboardScreen());
  }
  else{
    runApp(Login());
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.ProxykhelThemeData,
        home: Dashboard(),
      )
    );
  }
}

