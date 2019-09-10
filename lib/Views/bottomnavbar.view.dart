import 'package:flutter/material.dart';
import './dashboard.view.dart';
import './mycontest.view.dart';
import './../Constants/slideTransitions.dart';
import './../Views/notifications.view.dart';
class BottomNavBar extends StatefulWidget {
  static int prevIndex=0;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      if (index == 0 && index == BottomNavBar.prevIndex){
      }
      else if (index == 0 && index < BottomNavBar.prevIndex) {
        Navigator.pushAndRemoveUntil(context,SlideRightRoute(widget:Dashboard()), (Route<dynamic> route)=>false);
      }
      else if (index == 1  && index > BottomNavBar.prevIndex) {
        Navigator.pushAndRemoveUntil(context, SlideLeftRoute(widget: MyContest()), (Route<dynamic> route)=>false);
      }
      else if (index == 1  && index < BottomNavBar.prevIndex) {
        Navigator.pushAndRemoveUntil(context, SlideRightRoute(widget: MyContest()), (Route<dynamic> route)=>false);
      }

      else if (index == 2 && index > BottomNavBar.prevIndex) {
        Navigator.pushAndRemoveUntil(context, SlideLeftRoute(widget: Notifications()), (Route<dynamic> route)=>false);

      }
      else if (index == 2) {
      }
      setState(() {
        BottomNavBar.prevIndex = index;
      });
    }

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.games,
          ),
          activeIcon: Icon(Icons.games,),
          title: Text(
            'Games',
            style: TextStyle( fontSize: 16.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.input,
          ),
          activeIcon: Icon(Icons.input,),
          title: Text(
            'My contest',
            style: TextStyle( fontSize: 16.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications_active,
            color: Colors.grey,
          ),
          activeIcon: Icon(Icons.notifications_active,),

          title: Text(
            'Notification',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      currentIndex: BottomNavBar.prevIndex,
      onTap: _onItemTapped,
    );
  }
}
