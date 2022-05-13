import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:college_attendence/Modifications_Attend.dart';

var TextEditingControllers =  <TextEditingController>[];

class Modifications_Total extends StatefulWidget
{
  @override
  Modifications_Total_State createState()=> Modifications_Total_State();
}

class Modifications_Total_State extends State<Modifications_Total>
{
  int total_subjects=0;
  List Sub_List = <String>[];
  int All_Empty=0;
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

  void Show_Data()async
  {
    var databasesPath = await getDatabasesPath();
    String path = join(await databasesPath, 'attendence.db');
    Database database = await openDatabase(path, version: 1,);
    List<Map> list = await database.rawQuery('SELECT * FROM attendence');
  }

  void ADD_TOTAL()async
  {
    int updated=0;

    var databasesPath = await getDatabasesPath();
    String path = join(await databasesPath, 'attendence.db');
    Database database = await openDatabase(path, version: 1,);

    All_Empty=0;
    for(int i=0;i<Sub_List.length;i++)
    {
     if (TextEditingControllers[i].text == '')
     {
       setState(() {
         All_Empty=All_Empty+1;
       });
     }
    }


    print('Empty Value is $All_Empty');
    for(int i=0;i<Sub_List.length;i++) {
      String Tx = TextEditingControllers[i].text.toString();
      int Total = 0;

      if (TextEditingControllers[i].text != '')
      {
        Total= int.parse(Tx);
        if(Total!=0)
        {
          updated=1;
        String Sub = Sub_List[i];
        List<Map> list = await database.rawQuery('SELECT total FROM attendence WHERE subject = ? ',[ Sub ]);
        int tot = list[0]['total'];
        Total = Total + tot;

          int count1 = await database.rawUpdate(
              'UPDATE attendence SET total = ? WHERE subject = ?',
              [Total, Sub]);

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
        title: Text('Modify Total'),
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
              width: 120,
              child: ElevatedButton(
                onPressed: ()async{
                  ADD_TOTAL();
                  Fluttertoast.showToast(
                    msg: 'Just Wait a Second...',
                    toastLength: Toast.LENGTH_LONG,
                  );
                  Future.delayed(Duration(seconds: 5),(){
                    if(All_Empty!=Sub_List.length)
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Modifications_Add_Attend()));
                    }
                    else
                    {
                      Fluttertoast.showToast(
                        msg: 'You need enter atleast one subject',
                        toastLength: Toast.LENGTH_LONG,
                      );
                    }
                  });


                },
                  child: Text('ADD TOTAL'),
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