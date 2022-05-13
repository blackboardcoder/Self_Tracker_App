import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Add_Subject extends StatefulWidget
{
  @override
  Add_Subject_State createState()=> Add_Subject_State();
}

class Add_Subject_State extends State<Add_Subject>
{
  TextEditingController TEC = TextEditingController();
  List Subjects = <String>[];

  void GET_SUBJECTS()async
  {
    var databasesPath = await getDatabasesPath();
    String path = join(await databasesPath, 'attendence.db');
    Database database = await openDatabase(path, version: 1,);
    List<Map> list = await database.rawQuery('SELECT * FROM attendence');
    Subjects.clear();
    for(int i=0;i<list.length;i++)
      {
        String s = list[i]['subject'].toString();
        Subjects.add(s);
      }
    setState(() {
      list.length;
      Subjects.length;
    });
  }

  void ADD_SUBJECT()async
  {
    int Exists=0;
    var databasesPath = await getDatabasesPath();
    String path = join(await databasesPath, 'attendence.db');
    Database database = await openDatabase(path, version: 1,);
    List<Map> list = await database.rawQuery('SELECT * FROM attendence');
    for(int i=0;i<list.length;i++)
      {
        if(TEC.text==list[i]['subject'])
          {
            Exists=1;
            Fluttertoast.showToast(
              msg: '${TEC.text} Already Exists... ',
              toastLength: Toast.LENGTH_LONG,);
            break;
          }
      }
    if(Exists==0)
    {
      await database.transaction((txn) async {
        int id = await txn.rawInsert(
            'INSERT INTO attendence(subject,total,attend) values("${TEC
                .text}",0,0)'
        );
      });
      Fluttertoast.showToast(
        msg: '${TEC.text} Successfully Added... ',
        toastLength: Toast.LENGTH_LONG,);
      GET_SUBJECTS();
    }
  }

  @override
  void initState() {
    GET_SUBJECTS();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD SUBJECT'),
        backgroundColor: Colors.teal,
      ),
     body: Center(
       child: Column(
         children: <Widget>[

           Container(
             margin: EdgeInsets.all(8),
             child:   TextField(
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 labelText: 'Enter the Subject',
               ),
               controller: TEC,
             ),
           ),

           // SizedBox(height: 10,),

           Container(
             width: 100,
             height: 40,
             child:  ElevatedButton(
               onPressed: (){
                 ADD_SUBJECT();
               },
               child: Text('ADD'),
               style: ElevatedButton.styleFrom(
                 primary: Colors.teal,
               ),
             ),
           ),
           Expanded(
             child: Container(
               child: ListView.separated(
                 padding: const EdgeInsets.all(8),
                 itemCount: Subjects.length,
                 itemBuilder: (BuildContext context, int index)
                 {
                   return Container(
                     child: Center(
                       child: Text('${index+1}. ${Subjects[index]}',
                       style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                     )
                   );
                 },
                 separatorBuilder: (BuildContext context, int index) => Container( margin: EdgeInsets.all(5),),
               ),
             ),
           ),
         ],
       ),
     ),
    );
  }
}
