import 'package:college_attendence/Add_Subject.dart';
import 'package:college_attendence/Remove_Subject.dart';
import 'package:flutter/material.dart';

class Subjects_Modification extends StatefulWidget
{
  @override
  Subjects_Modification_State createState()=> Subjects_Modification_State();
}

class Subjects_Modification_State extends State<Subjects_Modification>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subjects Modification'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60,
              width: 180,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_Subject()),);
              }, child: Text('ADD SUBJECT'),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),),
            ),
            SizedBox(height: 10,),
            Container(
              height: 60,
              width: 180,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Remove_Subject()),);
              }, child: Text('REMOVE SUBJECT'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),),
            ),
          ],
        ),
      ),
    );
  }
}
