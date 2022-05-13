import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Report extends StatefulWidget
{
  @override
  Report_Status createState()=>Report_Status();
}

class Report_Status extends State<Report>
{
  int total=0,attend=0,absent=0;
  double percentage=0;
  List Subjects = <String>[];
  List Total_Classes = <String>[];
  List Total_Attend = <String>[];
  int length=0;
  @override
  void initState() {
    Get_Report();
    super.initState();
  }
  void Get_Report()async
  {
    var databasesPath = await getDatabasesPath();
    String path = join(await databasesPath, 'attendence.db');
    Database database = await openDatabase(path, version: 1,);
    List<Map> list = await database.rawQuery('SELECT * FROM attendence');
    for(int i=0;i<list.length;i++)
      {
          String s = list[i]['subject'].toString();
          Subjects.add(s);
          String tot = list[i]['total'].toString();
          Total_Classes.add(tot);
          String at = list[i]['attend'].toString();
          Total_Attend.add(at);

          int t = list[i]['total'];
          int a = list[i]['attend'];
          total  = total  + t;
          attend = attend + a;
      }
    setState(() {
      percentage = (attend/total)*100;
      length=Subjects.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child:Column(
          children: <Widget>[
            DataTable(
              columns: <DataColumn>[
                DataColumn(label: Text('Subject',
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
                DataColumn(label: Text('Total',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
                DataColumn(label: Text('Attended',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
              ],
              rows: List.generate(length, (index) =>
                  DataRow(cells: <DataCell>[
                    DataCell(Container(
                      width: 120,
                      child: Text('${Subjects[index]}',
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    ),),
                    DataCell(Text('${Total_Classes[index]}',
                      style: TextStyle(fontWeight: FontWeight.bold),),),
                    DataCell(Text('${Total_Attend[index]}',
                      style: TextStyle(fontWeight: FontWeight.bold),),),
                  ],
                  ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text('Your Percentage: ${percentage.toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 15,),),
            ),
          ],
        )
      ),
    );
  }
}