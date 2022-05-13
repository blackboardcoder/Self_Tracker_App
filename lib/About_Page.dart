import 'package:flutter/material.dart';

class About_Page extends StatefulWidget
{
  @override
  About_Page_State createState()=>About_Page_State();
}

class About_Page_State extends State<About_Page>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text('Contact us',
                style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 30,),
              Container(
               child: Column(
                  children: <Widget>[
                    Center(
                      child: Text('Gmail: blackboardcoder@gmail.com',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),

                    SizedBox(height: 20,),

                    Center(
                      child: Text('Instagram: blackboardcoder',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}