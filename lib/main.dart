import 'package:banking_app/addusers.dart';
import 'package:banking_app/home.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {"home": (context) => Home()},
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed("home");
        },
        label: Text('Home'),
        icon: Icon(Icons.home),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.purple.shade900,
              Colors.purple.shade600,
              Colors.blue
            ])),
        child: Center(
          child: Text(
            "BANKING",
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 10.0,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                  )
                ]),
          ),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   color: Colors.blue,
      //   //child: Container(height: 50.0),

      // ),
      //    floatingActionButton: FloatingActionButton(
      //      onPressed: (){ Navigator.push(MaterialPageRoute(builder: (context) => Home()))},
      //      child: const Icon(Icons.add),
      //    ),
      // //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // // );
    );
  }
}
