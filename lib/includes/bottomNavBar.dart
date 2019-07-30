import 'package:flutter/material.dart';
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _onBottomNavSelect(int index){
      if(index==0){
//        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Dashboard()), (Route<dynamic> route)=>false);
      }
      else if(index == 1){
//        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyContest()), (Route<dynamic> route)=>false);
      }
//      else if(index == 2){
//        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Notifications()), (Route<dynamic> route)=>false);
//      }
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
            style: TextStyle(color: Colors.black, fontSize: 16.0),
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
      onTap: _onBottomNavSelect,
    );
  }
}
