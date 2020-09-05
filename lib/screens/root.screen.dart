import 'package:badges/badges.dart';
import 'package:boba_time/constants/constants.dart';
import 'package:boba_time/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _bodyWidget() {
    if (_selectedIndex == 0) {
      return HomeScreen();
    } else if (_selectedIndex == 1) {
      return MapScreen();
    } else if (_selectedIndex == 2) {
      return SearchScreen();
    } else if (_selectedIndex == 3) {
      return AccountScreen();
    }
  }

  List<Widget> _navbarWidgets() {
    return [
      IconButton(
        icon: Icon(Feather.home),
        color: _selectedIndex == 0 ? AppThemes.bobaGreen : Colors.grey,
        onPressed: () => this._onItemTapped(0),
      ),
      IconButton(
        icon: Icon(Feather.map),
        color: _selectedIndex == 1 ? AppThemes.bobaGreen : Colors.grey,
        onPressed: () => this._onItemTapped(1),
      ),
      SizedBox(
        width: 30,
      ),
      IconButton(
        icon: Icon(Feather.search),
        color: _selectedIndex == 2 ? AppThemes.bobaGreen : Colors.grey,
        onPressed: () => this._onItemTapped(2),
      ),
      IconButton(
        icon: Icon(Icons.account_circle),
        color: _selectedIndex == 3 ? AppThemes.bobaGreen : Colors.grey,
        onPressed: () => this._onItemTapped(3),
      )
    ];
  }

  AppBar _homeAppBar() {
    return AppBar(
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Badge(
              badgeContent: Text(
                '3',
                style: TextStyle(color: Colors.white),
              ),
              badgeColor: Colors.redAccent,
              position: BadgePosition.topRight(top: 0, right: 3),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              child: IconButton(
                icon: Icon(Icons.notifications),
                color: Colors.white,
                onPressed: () => Get.toNamed('/notifications'),
              ),
            ),
          )
        ],
        title: Text(
          'BOBATIME',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: "PollyRounded"),
        ));
  }

  AppBar _normalAppBar(String text) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.grey[100],
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey[200],
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(4.0)),
      title: Center(
        child: Text(
          text,
          style: TextStyle(
//              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: "PollyRounded"),
        ),
      ),
    );
  }

  Widget _getAppBar() {
    if (_selectedIndex == 0) {
      return _homeAppBar();
    } else if (_selectedIndex == 1) {
      return _normalAppBar('Map');
    } else if (_selectedIndex == 2) {
      return _normalAppBar('Search');
    } else if (_selectedIndex == 3) {
      return _normalAppBar('Account');
    } else {
      return _normalAppBar('');
    }
  }

  @override
  Widget build(context) => Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: _getAppBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
          elevation: 5.0,
          onPressed: () => Get.toNamed('/new'),
        ),
        body: _bodyWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _navbarWidgets()),
          ),
        ),
      );
}
