import 'package:flutter/material.dart';

bool? isFirstTime = false;
bool? isFirstTimeGraph = false;

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Dashboard"));
  }
}
