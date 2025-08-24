import 'package:flutter/material.dart';
import 'package:scared_symmetry/views/books_view.dart';
import 'package:scared_symmetry/views/setting_view.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

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
bottomNavigationBar: NeuContainer(
  color: Color(0xFF4A2C4A), // Deep plum base
  borderRadius: BorderRadius.circular(0),
  borderWidth: 6, // Thicker border for brutalist impact
  borderColor: Color(0xFF1A1A1A), // Darker black for a heavier outline
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    child: BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: Color(0xFFFFD700), // Bright gold for selected item
      unselectedItemColor: Color(0xFF808080), // Muted gray for unselected
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_stories, size: 28), // Larger icon
          label: 'Scripture',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, size: 28), // Larger icon
          label: 'Setting',
        ),
      ],
    ),
  ),
),
    );
  }
}
