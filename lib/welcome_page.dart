// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_maps_example/home_page.dart';
import 'package:flutter_maps_example/home_screen2.dart';
import 'package:flutter_maps_example/home_screen3_.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Full Screen Map',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ))),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Part of Screen Map',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage2(),
                    ))),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Part of Screen Map with location',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage3(),
                    ))),
          ],
        ),
      ),
    );
  }
}
