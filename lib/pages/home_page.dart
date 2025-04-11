import 'package:flutter/material.dart';
import 'package:todospark/widget/appbar/appbar_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarHome(), 
      body: Center(child: Text("Home Page",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
    );
  }
}