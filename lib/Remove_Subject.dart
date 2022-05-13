import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Remove_Subject extends StatefulWidget
{
  @override
  Remove_Subject_State createState()=>Remove_Subject_State();
}

class Remove_Subject_State extends State<Remove_Subject>
{

  String dropdownValue  =  '';
  var dropdownValues = <String>[''];
  @override
  void initState() {
    Load_Subjects();
    setState(() {
      dropdownValue=dropdownValues[0];
    });
    super.initState();
  }

  void Load_Subjects()async
  {
    var databasesPath = await getDatabasesPath();
    String path = join(await databasesPath, 'attendence.db');
    Database database = await openDatabase(path, version: 1,);
    List<Map> list = await database.rawQuery('SELECT * FROM attendence');
    dropdownValues.clear();
    for(int i=0;i<list.length;i++)
      {
        String s = list[i]['subject'].toString();
        dropdownValues.add(s);
      }
    setState(() {
      dropdownValue=dropdownValues[0];
    });

  }

  void REMOVE_SUBJECT()async
  {
    var databasesPath = await getDatabasesPath();
    String path = join(await databasesPath, 'attendence.db');
    Database database = await openDatabase(path, version: 1,);
    String SUB = dropdownValue;
    var count = await database
        .rawDelete('DELETE FROM attendence WHERE subject = ?', [SUB]);
    if(count!=0)
      {

        Load_Subjects();
        Fluttertoast.showToast(
          msg: '${SUB} Removed Successfully...',
          toastLength: Toast.LENGTH_LONG,);
      }
    else
      {
        Fluttertoast.showToast(
          msg: 'Try Again...',
          toastLength: Toast.LENGTH_LONG,);
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Subject'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: DropdownButton<String>(
                value: dropdownValue,
                // icon: const Icon(Icons.add),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),

                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });

                  // print('Changed value of ${Subjects[index]} is ${dropdownValues[index]}');
                },
                items: dropdownValues
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 10,),
            Container(
              height: 40,
              width: 120,
              child: ElevatedButton(
                onPressed: (){
                  REMOVE_SUBJECT();
                },
                child: Text('REMOVE'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}