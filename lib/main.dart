import 'package:college_attendence/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnimatedSplashScreen(
      splash: 'images/ic_launcher.png',
      animationDuration: Duration(seconds: 2),
      nextScreen: App(),
      splashTransition: SplashTransition.fadeTransition,
    ),
  ));
}

class App extends StatefulWidget
{
  App_State createState() => App_State();
}

class App_State extends State<App>
{

  void Database_Initialize()async
  {
    final prefs = await SharedPreferences.getInstance();
    int? status = prefs.getInt('status');
    if(status==null)
    {
      await prefs.setInt('status', 1);
      var databasesPath = await getDatabasesPath();
      String path = join(await databasesPath, 'attendence.db');

      Database database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async { } );

      await database.execute(
          'CREATE TABLE attendence (subject TEXT, total INT, attend INT)'
      );
    }
  }

  @override
  void initState() {
    Database_Initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dashboard();
  }
}
