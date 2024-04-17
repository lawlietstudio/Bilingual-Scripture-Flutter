import 'package:flutter/material.dart';
import 'package:scared_symmetry/views/books_view.dart';
import 'package:scared_symmetry/views/setting_view.dart';

class CustomTabView extends StatefulWidget {
  const CustomTabView({super.key});

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void onTabTapped(int index) {
    if (_currentIndex == index) {
      // Pop to first route if the user taps on the active tab
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          switch (index) {
            case 0:
              builder = (BuildContext context) => BooksView();
              break;
            case 1:
              builder = (BuildContext context) => SettingView();
              break;
            default:
              throw Exception('Invalid index');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: List.generate(2, (index) => _buildOffstageNavigator(index)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Scripture',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
