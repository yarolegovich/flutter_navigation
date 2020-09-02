

import 'package:flutter_navigation/root/loggedin/home/anything/any_page.dart';
import 'package:flutter_navigation/root/loggedin/home/profile/profile_page.dart';
import 'package:flutter_navigation/widget/design.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomePageState();

}

class HomePageState extends State<HomePage> {

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.colorWhite,
      body: SafeArea(child: _createSelectedPage()),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.content_paste),
                title: Text('Home')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile')
            )
          ],
          selectedLabelStyle: Design.textCaption(),
          selectedItemColor: Design.fontColorHighEmp,
          unselectedLabelStyle: Design.textCaption(),
          unselectedItemColor: Design.fontColorMediumEmp,
          selectedIconTheme: IconThemeData(color: Design.fontColorHighEmp),
          unselectedIconTheme: IconThemeData(color: Design.colorNeutral.shade400),
          onTap: _onTabSelected,
          currentIndex: _selectedTab
      ),
    );
  }


  Widget _createSelectedPage() {
    if (_selectedTab == 0) {
      return AnyPage();
    } else {
      return ProfilePage();
    }
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTab = index;
    });
  }
}