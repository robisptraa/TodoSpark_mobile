import 'package:flutter/material.dart';
import 'package:todospark/pages/home_page.dart';
import 'package:todospark/pages/note_page.dart';
import 'package:todospark/pages/profile_page.dart';
import 'package:todospark/widget/navbar_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoSpark',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MainPage(),
        '/note': (context) => const NotePage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _tabIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const NotePage(),
    const ProfilePage(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: _pages[_tabIndex]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Navbar(
              selectedIndex: _tabIndex,
              onTabChange: _onTabChange,
            ),
          ),
        ],
      ),
    );
  }
}