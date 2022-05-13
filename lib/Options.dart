import 'package:college_attendence/About_Page.dart';
import 'package:college_attendence/Attendence.dart';
import 'package:college_attendence/Dashboard.dart';
import 'package:college_attendence/Erase_Data.dart';
import 'package:college_attendence/Modifications_Total.dart';
import 'package:college_attendence/Report.dart';
import 'package:college_attendence/Subjects_Modification.dart';
import 'package:flutter/material.dart';

class Options extends StatefulWidget
{
  @override
  Options_State createState()=> Options_State();
}

class Options_State extends State<Options>
{
  double Device_Width=0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      Device_Width = MediaQuery.of(context).size.width;
    });
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Self Tracker'),
            backgroundColor: Colors.teal,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 120,
                    width: Device_Width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Dashboard',
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()),);
                  },
                ),
                SizedBox(height: 10,),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 120,
                    width: Device_Width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Text(
                            'Attendence',
                          style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),
                        ),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendence()),);
                  },
                ),
                SizedBox(height: 10,),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 120,
                    width: Device_Width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Report',
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Report()),);
                  },
                ),
                SizedBox(height: 10,),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 120,
                    width: Device_Width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Modify',
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Modifications_Total()),);
                  },
                ),
                SizedBox(height: 10,),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 120,
                    width: Device_Width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Subjects',
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Subjects_Modification()),);
                  },
                ),
                SizedBox(height: 10,),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 120,
                    width: Device_Width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Erase Data',
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic,),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Erase_Data()),);
                  },
                ),
                SizedBox(height: 10,),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 120,
                    width: Device_Width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'About',
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  onTap: (){
                    //OnTap Code
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>About_Page()),);
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
