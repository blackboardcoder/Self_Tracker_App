import 'package:college_attendence/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Erase_Data extends StatefulWidget
{
  @override
  Erase_Data_State createState()=>Erase_Data_State();
}

class Erase_Data_State extends State<Erase_Data>
{
  void Erase()async
  {
    var databasesPath = await getDatabasesPath();
    String path = join(await databasesPath, 'attendence.db');
    Database database = await openDatabase(path, version: 1,);
    await ((await openDatabase(path)).close());
    await deleteDatabase(path);
    print("Erased");
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('fresh');
    Fluttertoast.showToast(
        msg: 'Successfully Erased...',
        toastLength: Toast.LENGTH_LONG,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Erase Data'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
          height: 60,
          width: 200,
          child: ElevatedButton(
            onPressed: (){
              Erase();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()),);
            },
            child: Text('Erase Everything...',
            style: TextStyle(fontSize: 17),),
            style: ElevatedButton.styleFrom(
              primary: Colors.teal,
            ),
          ),
        ),
      ),
    );
  }
}
