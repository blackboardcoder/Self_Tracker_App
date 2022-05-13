import 'package:college_attendence/Options.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dashboard extends StatefulWidget
{
  @override
  Dashboard_State createState()=> Dashboard_State();
}


class Dashboard_State extends State<Dashboard>
{
  int total=0,attend=0,absent=0;
  double percentage=0;
  List Subjects = <String>[];
  List Total_Classes = <String>[];
  List Total_Attend = <String>[];
  int length=0;
  double per_ind=0.0;

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
      if(total!=0)
      {
        percentage = (attend/total)*100;
        percentage = double.parse(percentage.toStringAsFixed(2));
        per_ind = (percentage/100)*1;
        per_ind = double.parse(per_ind.toStringAsFixed(2));
      }
      else
        {
          percentage=0;
          per_ind=0;
        }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.white,
      body: Center(
            child: InkWell(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 15.0,
                animation: true,
                animationDuration: 1500,
                circularStrokeCap: CircularStrokeCap.round,
                percent: per_ind,
                center: new Text("${percentage}%",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),),
                progressColor: Colors.green,
                backgroundColor: Colors.black26,
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Options()),);
              },
            ),
      ),
    );
  }
}
