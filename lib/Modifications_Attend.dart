import 'package:college_attendence/Options.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';

var TextEditingControllers =  <TextEditingController>[];

class Modifications_Add_Attend extends StatefulWidget
{
  @override
  Modifications_Add_Attend_State createState()=> Modifications_Add_Attend_State ();
}

class Modifications_Add_Attend_State extends State<Modifications_Add_Attend>
{
  int total_subjects=0;
  List Sub_List = <String>[];
  void Get_Data()async
  {
    var databasesPath = await getDatabasesPath();
    String path = join(await databasesPath, 'attendence.db');
    Database database = await openDatabase(path, version: 1,);
    List<Map> list = await database.rawQuery('SELECT * FROM attendence');
    total_subjects=list.length;
    for(int i=0;i<list.length;i++)
    {
      String s= list[i]['subject'].toString();
      Sub_List.add(s);
    }
    setState(() {
      Sub_List.length;
    });
  }
  
  void ADD_ATTEND()async
  {
    int updated=0;
    var databasesPath = await getDatabasesPath();
    String path = join(await databasesPath, 'attendence.db');
    Database database = await openDatabase(path, version: 1,);
    for(int i=0;i<Sub_List.length;i++) {
      String Tx = TextEditingControllers[i].text.toString();
      int Attend = 0;
      if (TextEditingControllers[i].text != '')
      {
        Attend= int.parse(Tx);
        if(Attend!=0)
        {
          updated=1;
          String Sub = Sub_List[i];
          List<Map> list = await database.rawQuery('SELECT total, attend FROM attendence WHERE subject = ? ',[ Sub ]);
          int att = list[0]['attend'];
          Attend = Attend + att;
          int tot = list[0]['total'];
          if(Attend<=tot) {
            int count1 = await database.rawUpdate(
                'UPDATE attendence SET attend = ? WHERE subject = ?',
                [Attend, Sub]);
          }
          else
            {
              Fluttertoast.showToast(
                  msg: 'Attend should be less than or equal to Total',
                  toastLength: Toast.LENGTH_LONG,);
            }
        }
      }
    }
    if(updated==1)
    {
      Fluttertoast.showToast(
        msg: 'Successfully Updated',
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }


  @override
  void initState() {
    Get_Data();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modify Attend'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: Sub_List.length,
                  itemBuilder: (BuildContext context, int index)
                  {
                    TextEditingControllers.add(TextEditingController());
                    return Container(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '${Sub_List[index]}',
                        ),
                        controller: TextEditingControllers[index],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Container( margin: EdgeInsets.all(5),),
                ),
              ),
              Container(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: (){
                    ADD_ATTEND();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Options()),);
                  },
                  child: Text('ADD ATTEND'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                ),
              ),
              SizedBox(height: 10,),
            ],
          )
      ),
    );
  }
}