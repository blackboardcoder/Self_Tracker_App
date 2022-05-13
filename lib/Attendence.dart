import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Show Data
void Show_Data()async
{
  var databasesPath = await getDatabasesPath();
  String path = join(await databasesPath, 'attendence.db');
  Database database = await openDatabase(path, version: 1,);
  List<Map> list = await database.rawQuery('SELECT * FROM attendence');
  print(list);
}


class Attendence extends StatefulWidget
{
  @override
  Attendence_State createState()=> Attendence_State();
}


class Attendence_State extends State<Attendence>
{
  String dropdownValue  =  'No Class';
  var dropdownValues = <String>['No Class'];
  var Subjects = <String>[];

  @override
  void initState(){
    Get_Data();
    super.initState();
  }

//Get Data
  void Get_Data()async
  {
    var databasesPath = await getDatabasesPath();
    String path = join(await databasesPath, 'attendence.db');
    Database database = await openDatabase(path, version: 1,);
    List<Map> list = await database.rawQuery('SELECT * FROM attendence');
    for(int i=0;i<list.length;i++)
    {
      Subjects.add(list[i]['subject']);
      dropdownValues.add('No Class');
    }
    setState(() {
        Subjects.length;
    });
  }


  //Method for Data Updation
  void Upload()async
  {
    String SUB;
    for(int i=0;i<Subjects.length;i++)
    {
      var databasesPath = await getDatabasesPath();
      String path = join(await databasesPath, 'attendence.db');
      Database database = await openDatabase(path, version: 1,);
      SUB = Subjects[i];
      List<Map> list = await database.rawQuery('SELECT attend, total FROM attendence WHERE subject = ? ',[ SUB ]);
      int attend  = list[0]['attend'];
      int total =   list[0]['total'];
      print('Attend is ${attend}');

      //For Present
      if(dropdownValues[i]=="Present")
      {
        attend = attend + 1;
        total = total + 1;
        String Sattend = attend.toString();
        String Stotal = total.toString();
        int count1 = await database.rawUpdate(
            'UPDATE attendence SET attend = ? WHERE subject = ?',
            [Sattend, SUB]);

        int count2 = await database.rawUpdate(
            'UPDATE attendence SET total = ? WHERE subject = ?',
            [Stotal, SUB]);
      }

      //For Absent
      if(dropdownValues[i]=="Absent")
      {
        total = total + 1;
        String Stotal = total.toString();

        int count2 = await database.rawUpdate(
            'UPDATE attendence SET total = ? WHERE subject = ?',
            [Stotal, SUB]);
      }
    }

    Fluttertoast.showToast(
        msg: 'Successfully Uploaded...',
        toastLength: Toast.LENGTH_LONG,);
  }

  @override
  Widget build(BuildContext context) {
    print(Subjects.length);
   return Scaffold(
     appBar: AppBar(
       title: Text('Attendence'),
       backgroundColor: Colors.teal,
     ),
     body: Center(
         child: Column(
           children: <Widget>[
             Expanded(
               child: ListView.separated(
                 padding: const EdgeInsets.all(5),
                 itemCount: Subjects.length,
                 itemBuilder: (BuildContext context, int index)
                 {
                   return Container(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Container(
                           height:50.0,
                           width: 200.0,
                           color: Colors.grey,
                           child: Center(
                             child: Text('${Subjects[index]}',
                             style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                           ),
                         ),
                         Container(
                           height:80.0,
                           width: 200.0,
                           color: Colors.white,

                           child:  Center(
                             child: DropdownButton<String>(
                               value: dropdownValues[index],
                               // icon: const Icon(Icons.add),
                               elevation: 16,
                               style: const TextStyle(color: Colors.black),
                               underline: Container(
                                 height: 2,
                                 color: Colors.black,
                               ),

                               onChanged: (String? newValue) {
                                 setState(() {
                                   dropdownValues[index] = newValue!;
                                 });

                                 // print('Changed value of ${Subjects[index]} is ${dropdownValues[index]}');
                               },
                               items: <String>['No Class','Present','Absent']
                                   .map<DropdownMenuItem<String>>((String value) {
                                 return DropdownMenuItem<String>(
                                   value: value,
                                   child: Text(value),
                                 );
                               }).toList(),
                             ),
                           ),
                         ),
                       ],
                     ),
                   );
                 },
                 separatorBuilder: (BuildContext context, int index) => Container( margin: EdgeInsets.all(5),),
               ),
             ),

             Container(
               margin: EdgeInsets.all(5),
               height: 40,
               width: 200,
               color: Colors.grey,
               child: ElevatedButton(
                 onPressed: (){
                   Upload();
                   Navigator.of(context).pop();
                 },
                 style: ElevatedButton.styleFrom(
                   primary: Colors.teal,
                 ),
                 child: Text('Upload',
                 style: TextStyle(fontSize: 20),),
               ),
             ),

           ],
         )
     ),
   );
  }
}