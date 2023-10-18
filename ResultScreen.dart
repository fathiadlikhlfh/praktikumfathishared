import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late double _result;

  @override
  void initState() {
    _loadResult();
    super.initState();
  }

  void _loadResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _result = prefs.getDouble('result') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Kalkulasinya'),
      ),
      body: Center(
        child: Text(
          'Hasil: $_result',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

