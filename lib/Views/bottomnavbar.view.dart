import 'package:flutter/material.dart';
import './dashboard.view.dart';
import './mycontest.view.dart';
import './../Constants/slideTransitions.dart';
import './../Views/notifications.view.dart';
class BottomNavBar extends StatelessWidget {
  static int prevIndex=0;

  @override
  Widget build(BuildContext context) {

    int _selectedIndex = 0;


    void _onItemTapped(int index) {
      if (index == 0 && index == prevIndex){

      }
      else if (index == 0 && index < prevIndex) {
        Navigator.pushAndRemoveUntil(context,SlideRightRoute(widget:Dashboard()), (Route<dynamic> route)=>false);
      }
      else if (index == 1  && index > prevIndex) {
        Navigator.pushAndRemoveUntil(context, SlideLeftRoute(widget: MyContest()), (Route<dynamic> route)=>false);
      }
      else if (index == 1  && index < prevIndex) {
        Navigator.pushAndRemoveUntil(context, SlideRightRoute(widget: MyContest()), (Route<dynamic> route)=>false);
      }

      else if (index == 2 && index > prevIndex) {
        Navigator.pushAndRemoveUntil(context, SlideLeftRoute(widget: Notifications()), (Route<dynamic> route)=>false);

      }
      else if (index == 2) {
      }
      prevIndex = index;
    }

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.games,
            color:Colors.grey,
          ),
          title: Text(
            'Games',
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.input,
            color: Colors.grey,
          ),
          title: Text(
            'My contest',
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications_active,
            color: Colors.grey,
          ),
          title: Text(
            'Notification',
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
      ],
      selectedItemColor: Colors.black54,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
