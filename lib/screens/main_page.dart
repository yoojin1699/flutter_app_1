// bottomnavbar의 각 page 설정
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/profile_page.dart';
import 'package:flutter_application_1/screens/edit_profile_page.dart';
import 'package:flutter_application_1/screens/temp.dart';
import 'package:flutter_application_1/screens/feeds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/base_map.dart';

import 'FabcontainerPage.dart';

class MainPage extends StatelessWidget {
  // 메인 페이지: 인자 email
  MainPage({this.email});

  final String email;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> viewContainer = [
    BaseMapPage(), // mapping
    Timeline(), // feed
    FabcontainerPage(), // create post
    TempScreen(), // kakao pay
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar 적용
      bottomNavigationBar: CustomBottomNavigationBar(
        iconList: [
          Icons.home_outlined,
          Icons.featured_play_list_outlined,
          Icons.add_box_outlined,
          Icons.qr_code_scanner_outlined,
          Icons.account_circle_outlined,
        ],
        onChange: (val) {
          setState(() {
            _currentIndex = val;
          });
        },
        defaultSelectedIndex: 0,
      ),
      body: viewContainer[_currentIndex],
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;

  CustomBottomNavigationBar(
      {this.defaultSelectedIndex = 0,
      @required this.iconList,
      @required this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];

  @override
  void initState() {
    // implement initState
    super.initState();

    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {

      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Row(
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width / _iconList.length,
        // decoration: index == _selectedIndex
        //     ? BoxDecoration(
        //         border: Border(
        //           bottom: BorderSide(width: 4, color: Colors.green),
        //         ),
        //         gradient: LinearGradient(colors: [
        //           Colors.green.withOpacity(0.3),
        //           Colors.green.withOpacity(0.015),
        //         ], begin: Alignment.bottomCenter, end: Alignment.topCenter)
        //         // color: index == _selectedItemIndex ? Colors.green : Colors.white,
        //       )
        //     : BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedIndex ? Colors.black : Colors.grey,
          size: 28.0,
        ),
      ),
    );
  }
}
